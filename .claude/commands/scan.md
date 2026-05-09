---
description: Run a morning market scan using Alpaca live data
---

Use the Alpaca MCP tools to:
1. Get current SPY and QQQ snapshots (price, daily change, volume)
2. Get snapshots for: AAPL, MSFT, NVDA, AMZN, META, GOOGL, TSLA, AMD, NFLX
3. Identify the top 3 strongest setups based on: price above VWAP, positive day change, high relative volume
4. For each top setup, check the last 5 daily bars to confirm uptrend
5. Give a buy/pass verdict for each with a one-sentence reason

Risk rules to enforce: max $100 risk per trade, stop at 1.5x ATR, target at 3x ATR (2:1 R:R). Long only. No earnings plays.
