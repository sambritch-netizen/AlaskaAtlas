"""
AI Trading Agent — Paper Trading Mode
Schedules: morning study at 9:15 ET, trading cycle every 10 min, position monitor every 2 min,
end-of-day close at 3:45 ET.
"""

import json
import os
import sqlite3
import time
from datetime import datetime
from pathlib import Path

import pytz
import schedule
from dotenv import load_dotenv

load_dotenv()

import agents.trading_agent  # noqa: E402 — after load_dotenv so env vars are ready
from agents.market_analyst import MarketAnalyst
from agents.trading_agent import TradingAgent
from analysis.screener import screen_candidates
from core.broker import BrokerClient
from core.market_data import MarketDataClient
from core.order_manager import OrderManager
from risk.position_sizing import calculate_position_size, validate_trade

ET = pytz.timezone("America/New_York")
MAX_TRADES_PER_DAY = int(os.getenv("MAX_TRADES_PER_DAY", 5))


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def now_et() -> datetime:
    return datetime.now(ET)


def log(msg: str) -> None:
    print(f"[{now_et().strftime('%H:%M:%S')}] {msg}")


def is_market_hours() -> bool:
    now = now_et()
    if now.weekday() >= 5:
        return False
    open_ = now.replace(hour=9, minute=35, second=0, microsecond=0)
    close = now.replace(hour=15, minute=44, second=0, microsecond=0)
    return open_ <= now <= close


def load_watchlist() -> list[str]:
    path = Path(__file__).parent / "watchlist.json"
    return json.loads(path.read_text())["all"]


# ---------------------------------------------------------------------------
# SQLite trade log
# ---------------------------------------------------------------------------

def init_db() -> sqlite3.Connection:
    db_path = Path(__file__).parent / "data" / "trade_log.db"
    db_path.parent.mkdir(exist_ok=True)
    conn = sqlite3.connect(str(db_path))
    conn.execute("""
        CREATE TABLE IF NOT EXISTS trades (
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            date          TEXT,
            symbol        TEXT,
            action        TEXT,
            shares        INTEGER,
            entry_price   REAL,
            stop_price    REAL,
            target_price  REAL,
            dollar_risk   REAL,
            reason        TEXT,
            confidence    REAL,
            order_id      TEXT,
            timestamp     TEXT
        )
    """)
    conn.commit()
    return conn


def log_trade(conn: sqlite3.Connection, trade: dict) -> None:
    conn.execute(
        """INSERT INTO trades
           (date, symbol, action, shares, entry_price, stop_price, target_price,
            dollar_risk, reason, confidence, order_id, timestamp)
           VALUES (?,?,?,?,?,?,?,?,?,?,?,?)""",
        (
            trade.get("date"), trade.get("symbol"), trade.get("action"),
            trade.get("shares"), trade.get("entry_price"), trade.get("stop_price"),
            trade.get("target_price"), trade.get("dollar_risk"), trade.get("reason"),
            trade.get("confidence"), trade.get("order_id"), trade.get("timestamp"),
        ),
    )
    conn.commit()


# ---------------------------------------------------------------------------
# Global state (initialised in main())
# ---------------------------------------------------------------------------

data_client: MarketDataClient = None
broker: BrokerClient = None
orders: OrderManager = None
analyst: MarketAnalyst = None
agent: TradingAgent = None
db: sqlite3.Connection = None
session_trades: list[dict] = []
trades_today: int = 0


# ---------------------------------------------------------------------------
# Scheduled tasks
# ---------------------------------------------------------------------------

def run_morning_study() -> None:
    if now_et().weekday() >= 5:
        return
    log("=== MORNING STUDY ===")
    try:
        context = analyst.gather_market_context()
        plan = agent.morning_study(context)
        log(f"Market bias: {plan.get('market_bias', '?')} | {plan.get('notes', '')[:120]}")
    except Exception as exc:
        log(f"Morning study error: {exc}")


def run_trading_cycle() -> None:
    global trades_today

    if not is_market_hours():
        return
    if trades_today >= MAX_TRADES_PER_DAY:
        log(f"Daily trade limit ({MAX_TRADES_PER_DAY}) reached — skipping scan")
        return

    log("=== TRADING CYCLE ===")

    try:
        account = broker.get_account()
        positions = broker.get_positions()
        log(f"Positions: {len(positions)} open | Buying power: ${float(account.buying_power):,.2f}")

        watchlist = load_watchlist()
        context = analyst.gather_market_context()
        candidates = screen_candidates(watchlist, data_client, min_score=60)

        held = {p.symbol for p in positions}
        candidates = [c for c in candidates if c["symbol"] not in held]

        if not candidates:
            log("No qualified candidates")
            return

        log(f"Candidates: {[c['symbol'] for c in candidates[:5]]}")
        enriched = analyst.enrich_candidates(candidates[:8])
        decisions = agent.make_trading_decisions(enriched, context, positions, account)

        for decision in decisions:
            if trades_today >= MAX_TRADES_PER_DAY:
                break

            symbol = decision.get("symbol", "")
            action = decision.get("action", "hold")

            if action != "buy":
                log(f"  {symbol}: {action} — {str(decision.get('reason', ''))[:80]}")
                continue

            candidate = next((c for c in enriched if c["symbol"] == symbol), None)
            if not candidate:
                log(f"  {symbol}: no candidate data, skipping")
                continue

            pos_size = calculate_position_size(candidate["current_price"], candidate["atr"])

            positions = broker.get_positions()  # refresh
            ok, reason = validate_trade(account, positions, pos_size)
            if not ok:
                log(f"  {symbol}: rejected — {reason}")
                continue

            try:
                order = orders.place_bracket_buy(
                    symbol=symbol,
                    qty=pos_size["shares"],
                    take_profit_price=pos_size["target_price"],
                    stop_loss_price=pos_size["stop_price"],
                )
                trades_today += 1
                record = {
                    "date": now_et().strftime("%Y-%m-%d"),
                    "symbol": symbol,
                    "action": "buy",
                    "shares": pos_size["shares"],
                    "entry_price": candidate["current_price"],
                    "stop_price": pos_size["stop_price"],
                    "target_price": pos_size["target_price"],
                    "dollar_risk": pos_size["dollar_risk"],
                    "reason": decision.get("reason", ""),
                    "confidence": decision.get("confidence", 0.0),
                    "order_id": order.get("order_id", ""),
                    "timestamp": now_et().isoformat(),
                }
                log_trade(db, record)
                session_trades.append(record)
                log(
                    f"  TRADE #{trades_today}: BUY {pos_size['shares']} {symbol} "
                    f"@ ~${candidate['current_price']:.2f} | "
                    f"Stop ${pos_size['stop_price']:.2f} | "
                    f"Target ${pos_size['target_price']:.2f} | "
                    f"Risk ${pos_size['dollar_risk']:.2f}"
                )
            except Exception as exc:
                log(f"  {symbol}: order failed — {exc}")

    except Exception as exc:
        log(f"Trading cycle error: {exc}")


def monitor_positions() -> None:
    if not is_market_hours():
        return
    try:
        positions = broker.get_positions()
        for p in positions:
            pnl = float(p.unrealized_pl)
            pnl_pct = float(p.unrealized_plpc) * 100
            if abs(pnl) > 10:  # only log meaningful moves
                direction = "+" if pnl >= 0 else ""
                log(f"  {p.symbol}: {direction}{pnl_pct:.1f}% ({direction}${pnl:.2f})")
    except Exception as exc:
        log(f"Position monitor error: {exc}")


def end_of_day() -> None:
    global trades_today

    if now_et().weekday() >= 5:
        return
    log("=== END OF DAY ===")

    try:
        orders.cancel_all_orders()
        positions = broker.get_positions()
        if positions:
            broker.close_all_positions()
            log(f"Closed {len(positions)} position(s)")

        context = analyst.gather_market_context()
        journal_path = agent.write_journal(session_trades, context)
        log(f"Journal written: {journal_path}")

        account = broker.get_account()
        log(f"Final portfolio value: ${float(account.portfolio_value):,.2f}")

        session_trades.clear()
        trades_today = 0

    except Exception as exc:
        log(f"End-of-day error: {exc}")


# ---------------------------------------------------------------------------
# Boot
# ---------------------------------------------------------------------------

def main() -> None:
    global data_client, broker, orders, analyst, agent, db

    print("=" * 55)
    print("  AI Trading Agent — Paper Trading")
    print("  Risk per trade: $100 | Max positions: 3")
    print("=" * 55)

    data_client = MarketDataClient()
    broker = BrokerClient()
    orders = OrderManager(broker.client)
    analyst = MarketAnalyst(data_client)
    agent = TradingAgent()
    db = init_db()

    account = broker.get_account()
    log(f"Account ready | Portfolio: ${float(account.portfolio_value):,.2f} | Cash: ${float(account.cash):,.2f}")

    schedule.every().day.at("09:15").do(run_morning_study)
    schedule.every(10).minutes.do(run_trading_cycle)
    schedule.every(2).minutes.do(monitor_positions)
    schedule.every().day.at("15:45").do(end_of_day)

    log("Schedule: morning study 9:15 ET | trading every 10 min | monitor every 2 min | close 3:45 ET")

    # Run immediately if the timing is right
    now = now_et()
    if now.weekday() < 5 and now.hour == 9 and 15 <= now.minute < 35:
        run_morning_study()
    if is_market_hours():
        run_trading_cycle()

    log("Agent running — press Ctrl+C to stop\n")
    while True:
        schedule.run_pending()
        time.sleep(30)


if __name__ == "__main__":
    main()
