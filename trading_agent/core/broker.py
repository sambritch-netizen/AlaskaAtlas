import os
from alpaca.trading.client import TradingClient


class BrokerClient:
    def __init__(self):
        self.client = TradingClient(
            api_key=os.getenv("ALPACA_API_KEY"),
            secret_key=os.getenv("ALPACA_SECRET_KEY"),
            paper=True,
        )

    def get_account(self):
        return self.client.get_account()

    def get_positions(self):
        return self.client.get_all_positions()

    def get_open_orders(self):
        return self.client.get_orders()

    def close_all_positions(self):
        return self.client.close_all_positions(cancel_orders=True)

    def close_position(self, symbol: str):
        return self.client.close_position(symbol)
