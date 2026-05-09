import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/trading_models.dart';

// ── Mock data ─────────────────────────────────────────────────────────────────
// Replace with live Alpaca API calls once keys are wired in.

final _mockEquityCurve = [
  99820, 99750, 99900, 99840, 99980, 100020, 100150,
  100090, 100200, 100310, 100180, 100250, 100248,
].map((v) => v.toDouble()).toList();

final _mockAccount = const AccountSummary(
  portfolioValue: 100247.83,
  cash: 45230.52,
  buyingPower: 90461.04,
  dayPL: 247.83,
  dayPLPct: 0.25,
  equityCurve: [],
);

final _mockPositions = const [
  Position(
    symbol: 'NVDA',
    qty: 10,
    avgEntryPrice: 812.50,
    currentPrice: 847.30,
    marketValue: 8473.00,
    unrealizedPL: 348.00,
    unrealizedPLPct: 4.28,
    stopPrice: 795.60,
    targetPrice: 860.40,
  ),
  Position(
    symbol: 'AAPL',
    qty: 5,
    avgEntryPrice: 182.60,
    currentPrice: 189.20,
    marketValue: 946.00,
    unrealizedPL: 33.00,
    unrealizedPLPct: 3.62,
    stopPrice: 179.40,
    targetPrice: 195.80,
  ),
];

final _mockWatchlist = const [
  WatchlistQuote(
    symbol: 'SPY',
    price: 523.41,
    change: 2.18,
    changePct: 0.42,
    signalScore: 68,
    signalTrend: 'uptrend',
    miniChart: [519.2, 520.1, 519.8, 521.3, 521.9, 522.4, 522.0, 523.1, 523.4],
  ),
  WatchlistQuote(
    symbol: 'QQQ',
    price: 441.82,
    change: 1.94,
    changePct: 0.44,
    signalScore: 71,
    signalTrend: 'strong_uptrend',
    miniChart: [438.1, 438.9, 439.2, 440.1, 440.8, 440.6, 441.2, 441.5, 441.8],
  ),
  WatchlistQuote(
    symbol: 'NVDA',
    price: 847.30,
    change: 34.80,
    changePct: 4.28,
    signalScore: 84,
    signalTrend: 'strong_uptrend',
    miniChart: [812.5, 818.2, 822.4, 830.1, 835.6, 838.9, 841.2, 845.0, 847.3],
  ),
  WatchlistQuote(
    symbol: 'AAPL',
    price: 189.20,
    change: 1.90,
    changePct: 1.01,
    signalScore: 72,
    signalTrend: 'uptrend',
    miniChart: [186.8, 187.1, 187.6, 187.9, 188.4, 188.6, 188.9, 189.0, 189.2],
  ),
  WatchlistQuote(
    symbol: 'MSFT',
    price: 412.55,
    change: -1.45,
    changePct: -0.35,
    signalScore: 48,
    signalTrend: 'mixed',
    miniChart: [414.2, 413.9, 413.4, 413.8, 413.2, 412.9, 413.1, 412.7, 412.6],
  ),
  WatchlistQuote(
    symbol: 'TSLA',
    price: 251.40,
    change: -4.20,
    changePct: -1.64,
    signalScore: 32,
    signalTrend: 'downtrend',
    miniChart: [256.1, 255.4, 254.8, 254.2, 253.6, 253.0, 252.4, 251.8, 251.4],
  ),
  WatchlistQuote(
    symbol: 'META',
    price: 518.90,
    change: 6.30,
    changePct: 1.23,
    signalScore: 77,
    signalTrend: 'strong_uptrend',
    miniChart: [511.2, 512.6, 513.8, 515.1, 516.3, 517.0, 517.8, 518.4, 518.9],
  ),
  WatchlistQuote(
    symbol: 'AMD',
    price: 162.40,
    change: 3.10,
    changePct: 1.95,
    signalScore: 65,
    signalTrend: 'uptrend',
    miniChart: [158.4, 159.1, 159.8, 160.3, 160.9, 161.4, 161.8, 162.1, 162.4],
  ),
  WatchlistQuote(
    symbol: 'AMZN',
    price: 198.74,
    change: 0.84,
    changePct: 0.42,
    signalScore: 55,
    signalTrend: 'uptrend',
    miniChart: [197.4, 197.6, 197.9, 198.0, 198.2, 198.3, 198.5, 198.6, 198.7],
  ),
  WatchlistQuote(
    symbol: 'NFLX',
    price: 694.20,
    change: -8.30,
    changePct: -1.18,
    signalScore: 41,
    signalTrend: 'mixed',
    miniChart: [703.1, 702.4, 701.6, 700.3, 699.1, 698.2, 696.9, 695.4, 694.2],
  ),
];

// ── State ─────────────────────────────────────────────────────────────────────

class TradingState {
  final AccountSummary account;
  final List<Position> positions;
  final List<WatchlistQuote> watchlist;
  final bool isLoading;
  final String? lastOrderMessage;

  const TradingState({
    required this.account,
    required this.positions,
    required this.watchlist,
    this.isLoading = false,
    this.lastOrderMessage,
  });

  TradingState copyWith({
    AccountSummary? account,
    List<Position>? positions,
    List<WatchlistQuote>? watchlist,
    bool? isLoading,
    String? lastOrderMessage,
  }) {
    return TradingState(
      account: account ?? this.account,
      positions: positions ?? this.positions,
      watchlist: watchlist ?? this.watchlist,
      isLoading: isLoading ?? this.isLoading,
      lastOrderMessage: lastOrderMessage,
    );
  }
}

class TradingNotifier extends StateNotifier<TradingState> {
  TradingNotifier()
      : super(TradingState(
          account: _mockAccount.copyWith(equityCurve: _mockEquityCurve),
          positions: _mockPositions,
          watchlist: _mockWatchlist,
        ));

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(isLoading: false);
  }

  Future<bool> placeOrder(TradeOrder order) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 1200));
    state = state.copyWith(
      isLoading: false,
      lastOrderMessage:
          '${order.side.toUpperCase()} ${order.qty} ${order.symbol} order submitted',
    );
    return true;
  }

  Future<void> closePosition(String symbol) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 800));
    final updated = state.positions.where((p) => p.symbol != symbol).toList();
    state = state.copyWith(
      positions: updated,
      isLoading: false,
      lastOrderMessage: 'Closed $symbol position',
    );
  }
}

extension _AccountSummaryX on AccountSummary {
  AccountSummary copyWith({List<double>? equityCurve}) => AccountSummary(
        portfolioValue: portfolioValue,
        cash: cash,
        buyingPower: buyingPower,
        dayPL: dayPL,
        dayPLPct: dayPLPct,
        equityCurve: equityCurve ?? this.equityCurve,
      );
}

// ── Providers ─────────────────────────────────────────────────────────────────

final tradingProvider = StateNotifierProvider<TradingNotifier, TradingState>(
  (ref) => TradingNotifier(),
);
