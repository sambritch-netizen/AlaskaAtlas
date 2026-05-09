import os
from datetime import datetime, timedelta

import pandas as pd
import pytz
from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest, StockLatestQuoteRequest, StockSnapshotRequest
from alpaca.data.timeframe import TimeFrame, TimeFrameUnit

ET = pytz.timezone("America/New_York")


class MarketDataClient:
    def __init__(self):
        self.client = StockHistoricalDataClient(
            api_key=os.getenv("ALPACA_API_KEY"),
            secret_key=os.getenv("ALPACA_SECRET_KEY"),
        )

    def get_bars(
        self,
        symbols: list[str] | str,
        multiplier: int = 5,
        unit: TimeFrameUnit = TimeFrameUnit.Minute,
        limit: int = 100,
    ) -> pd.DataFrame:
        if isinstance(symbols, str):
            symbols = [symbols]
        end = datetime.now(ET)
        start = end - timedelta(days=5)
        request = StockBarsRequest(
            symbol_or_symbols=symbols,
            timeframe=TimeFrame(amount=multiplier, unit=unit),
            start=start,
            end=end,
            limit=limit,
        )
        return self.client.get_stock_bars(request).df

    def get_daily_bars(self, symbols: list[str] | str, days: int = 30) -> pd.DataFrame:
        if isinstance(symbols, str):
            symbols = [symbols]
        end = datetime.now(ET)
        start = end - timedelta(days=days)
        request = StockBarsRequest(
            symbol_or_symbols=symbols,
            timeframe=TimeFrame.Day,
            start=start,
            end=end,
        )
        return self.client.get_stock_bars(request).df

    def get_latest_quotes(self, symbols: list[str] | str) -> dict:
        if isinstance(symbols, str):
            symbols = [symbols]
        return self.client.get_stock_latest_quote(StockLatestQuoteRequest(symbol_or_symbols=symbols))

    def get_snapshots(self, symbols: list[str] | str) -> dict:
        if isinstance(symbols, str):
            symbols = [symbols]
        return self.client.get_stock_snapshot(StockSnapshotRequest(symbol_or_symbols=symbols))
