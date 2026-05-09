import os

MAX_RISK_PER_TRADE = float(os.getenv("MAX_RISK_PER_TRADE", 100))
MAX_DAILY_DEPLOYMENT = float(os.getenv("MAX_DAILY_DEPLOYMENT", 4000))
MAX_POSITIONS = int(os.getenv("MAX_POSITIONS", 3))
ATR_STOP_MULTIPLIER = 1.5
REWARD_RISK_RATIO = 2.0


def calculate_position_size(price: float, atr: float, risk_dollars: float = None) -> dict:
    """Size a position so the ATR-based stop risks at most risk_dollars."""
    risk = risk_dollars or MAX_RISK_PER_TRADE
    stop_distance = atr * ATR_STOP_MULTIPLIER

    if stop_distance <= 0 or price <= 0:
        return {"shares": 0, "dollar_value": 0.0, "stop_price": 0.0, "target_price": 0.0, "dollar_risk": 0.0}

    shares = max(1, int(risk / stop_distance))
    return {
        "shares": shares,
        "dollar_value": round(shares * price, 2),
        "stop_price": round(price - stop_distance, 2),
        "target_price": round(price + stop_distance * REWARD_RISK_RATIO, 2),
        "stop_distance": round(stop_distance, 4),
        "dollar_risk": round(shares * stop_distance, 2),
    }


def validate_trade(account, open_positions: list, position_size: dict) -> tuple[bool, str]:
    """Return (ok, reason). Checks position count, buying power, risk, and daily deployment."""
    if len(open_positions) >= MAX_POSITIONS:
        return False, f"max positions ({MAX_POSITIONS}) already open"

    buying_power = float(account.buying_power)
    if position_size["dollar_value"] > buying_power:
        return False, f"insufficient buying power (need ${position_size['dollar_value']:.2f})"

    if position_size["dollar_risk"] > MAX_RISK_PER_TRADE * 1.1:
        return False, f"risk ${position_size['dollar_risk']:.2f} exceeds limit ${MAX_RISK_PER_TRADE}"

    deployed = sum(float(p.market_value) for p in open_positions)
    if deployed + position_size["dollar_value"] > MAX_DAILY_DEPLOYMENT:
        return False, f"would exceed daily deployment cap ${MAX_DAILY_DEPLOYMENT}"

    return True, "ok"
