from alpaca.trading.client import TradingClient
from alpaca.trading.enums import OrderClass, OrderSide, TimeInForce
from alpaca.trading.requests import MarketOrderRequest, StopLossRequest, TakeProfitRequest


class OrderManager:
    def __init__(self, trading_client: TradingClient):
        self.client = trading_client

    def place_bracket_buy(
        self,
        symbol: str,
        qty: int,
        take_profit_price: float,
        stop_loss_price: float,
    ) -> dict:
        request = MarketOrderRequest(
            symbol=symbol,
            qty=qty,
            side=OrderSide.BUY,
            time_in_force=TimeInForce.DAY,
            order_class=OrderClass.BRACKET,
            take_profit=TakeProfitRequest(limit_price=round(take_profit_price, 2)),
            stop_loss=StopLossRequest(stop_price=round(stop_loss_price, 2)),
        )
        order = self.client.submit_order(request)
        return {
            "order_id": str(order.id),
            "symbol": order.symbol,
            "qty": str(order.qty),
            "side": str(order.side),
            "status": str(order.status),
            "take_profit": take_profit_price,
            "stop_loss": stop_loss_price,
        }

    def cancel_all_orders(self):
        return self.client.cancel_orders()

    def cancel_order(self, order_id: str):
        return self.client.cancel_order_by_id(order_id)
