import pandas as pd

from .indicators import add_all


def score_setup(df: pd.DataFrame) -> dict:
    """Score 0-100. Higher = stronger long setup."""
    if len(df) < 50:
        return {"score": 0, "signals": {}, "reason": "insufficient_data"}

    latest = df.iloc[-1]
    prev = df.iloc[-2]
    score = 50
    signals = {}

    # Trend alignment
    if latest["close"] > latest["ema_21"] > latest["sma_50"]:
        signals["trend"] = "strong_uptrend"
        score += 15
    elif latest["close"] > latest["ema_21"]:
        signals["trend"] = "uptrend"
        score += 8
    elif latest["close"] < latest["ema_21"] < latest["sma_50"]:
        signals["trend"] = "strong_downtrend"
        score -= 15
    else:
        signals["trend"] = "mixed"

    # RSI — sweet spot for momentum longs: 45-70
    rsi_val = float(latest["rsi"])
    if 45 <= rsi_val <= 70:
        signals["rsi"] = "bullish_momentum"
        score += 10
    elif 30 <= rsi_val < 45:
        signals["rsi"] = "recovering"
        score += 5
    elif rsi_val > 80:
        signals["rsi"] = "overbought"
        score -= 10
    elif rsi_val < 30:
        signals["rsi"] = "oversold"
        score -= 5
    else:
        signals["rsi"] = "neutral"

    # MACD crossover
    if latest["macd"] > latest["macd_signal"] and prev["macd"] <= prev["macd_signal"]:
        signals["macd"] = "bullish_crossover"
        score += 15
    elif latest["macd"] > latest["macd_signal"]:
        signals["macd"] = "bullish"
        score += 5
    elif latest["macd"] < latest["macd_signal"] and prev["macd"] >= prev["macd_signal"]:
        signals["macd"] = "bearish_crossover"
        score -= 15
    else:
        signals["macd"] = "bearish"
        score -= 5

    # Volume confirmation
    rel_vol = float(latest["rel_volume"]) if not pd.isna(latest["rel_volume"]) else 1.0
    if rel_vol >= 1.5:
        signals["volume"] = "high"
        score += 10
    elif rel_vol >= 1.0:
        signals["volume"] = "normal"
    else:
        signals["volume"] = "low"
        score -= 5

    # VWAP position
    if latest["close"] > latest["vwap"]:
        signals["vwap"] = "above"
        score += 5
    else:
        signals["vwap"] = "below"
        score -= 5

    # Bollinger Band breakout
    if latest["close"] > latest["bb_upper"]:
        signals["bb"] = "breakout_up"
        score += 10
    elif latest["close"] < latest["bb_lower"]:
        signals["bb"] = "breakdown"
        score -= 10

    return {
        "score": max(0, min(100, score)),
        "signals": signals,
        "current_price": round(float(latest["close"]), 2),
        "atr": round(float(latest["atr"]), 4),
        "rsi": round(rsi_val, 1),
        "rel_volume": round(rel_vol, 2),
        "vwap": round(float(latest["vwap"]), 2),
    }


def screen_candidates(watchlist: list[str], data_client, min_score: int = 60) -> list[dict]:
    """Return watchlist stocks scored above min_score, sorted by score descending."""
    candidates = []

    for symbol in watchlist:
        try:
            df = data_client.get_bars([symbol], multiplier=5, limit=100)
            if df.empty:
                continue

            symbol_df = df.loc[symbol] if isinstance(df.index, pd.MultiIndex) else df
            symbol_df = symbol_df.reset_index()
            scored = score_setup(add_all(symbol_df))

            if scored["score"] >= min_score:
                candidates.append({"symbol": symbol, **scored})

        except Exception as exc:
            print(f"  [screener] {symbol}: {exc}")

    return sorted(candidates, key=lambda x: x["score"], reverse=True)
