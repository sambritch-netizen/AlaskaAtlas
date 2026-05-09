from datetime import datetime

import pandas as pd
import pytz

from analysis.indicators import add_all
from core.market_data import MarketDataClient

ET = pytz.timezone("America/New_York")
BENCHMARK_SYMBOLS = ["SPY", "QQQ"]


class MarketAnalyst:
    def __init__(self, data_client: MarketDataClient):
        self.data_client = data_client

    def gather_market_context(self) -> dict:
        """Return daily technical snapshot of SPY and QQQ."""
        context: dict = {"timestamp": datetime.now(ET).isoformat()}

        for symbol in BENCHMARK_SYMBOLS:
            try:
                df = self.data_client.get_daily_bars([symbol], days=60)
                if df.empty:
                    continue

                symbol_df = df.loc[symbol] if isinstance(df.index, pd.MultiIndex) else df
                enriched = add_all(symbol_df.reset_index())
                latest = enriched.iloc[-1]
                prev = enriched.iloc[-2]

                pct_change = ((latest["close"] - prev["close"]) / prev["close"]) * 100

                context[symbol] = {
                    "price": round(float(latest["close"]), 2),
                    "pct_change": round(float(pct_change), 2),
                    "rsi_daily": round(float(latest["rsi"]), 1),
                    "above_ema21": bool(latest["close"] > latest["ema_21"]),
                    "above_sma50": bool(latest["close"] > latest["sma_50"]),
                    "macd_bullish": bool(latest["macd"] > latest["macd_signal"]),
                    "rel_volume": round(float(latest["rel_volume"]), 2),
                }
            except Exception as exc:
                context[symbol] = {"error": str(exc)}

        return context

    def enrich_candidates(self, candidates: list[dict]) -> list[dict]:
        """Add daily-timeframe context to intraday-scored candidates."""
        for candidate in candidates:
            symbol = candidate["symbol"]
            try:
                df = self.data_client.get_daily_bars([symbol], days=30)
                if df.empty:
                    continue
                symbol_df = df.loc[symbol] if isinstance(df.index, pd.MultiIndex) else df
                enriched = add_all(symbol_df.reset_index())
                daily = enriched.iloc[-1]
                candidate["daily"] = {
                    "rsi": round(float(daily["rsi"]), 1),
                    "above_ema21": bool(daily["close"] > daily["ema_21"]),
                    "above_sma50": bool(daily["close"] > daily["sma_50"]),
                    "macd_bullish": bool(daily["macd"] > daily["macd_signal"]),
                }
            except Exception:
                pass
        return candidates
