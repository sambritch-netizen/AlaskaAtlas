---
description: Execute a bracket order for a given symbol — usage: /trade NVDA
---

The symbol to trade is: $ARGUMENTS

Use the Alpaca MCP tools to:
1. Get the current snapshot for $ARGUMENTS (price, daily bars, volume)
2. Get account info to check buying power and open positions
3. Get all open positions to check the count

Enforce these risk rules before placing any order:
- Skip if already 3 or more positions open
- Skip if market is closed or within 5 min of open (before 9:35 AM ET)
- Skip if the stock is down more than 1% on the day (no catching falling knives)
- Max risk: $100. Calculate shares = floor($100 / (1.5 × ATR)).
- Stop loss = entry − (1.5 × ATR), rounded to 2 decimals
- Take profit = entry + (3 × ATR), rounded to 2 decimals (2:1 R:R)

If all checks pass, place a bracket market order with the calculated qty, stop, and target.
Report the order details or explain why you skipped.
