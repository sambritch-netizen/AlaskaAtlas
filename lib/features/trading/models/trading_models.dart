import 'package:flutter/material.dart';

class AccountSummary {
  final double portfolioValue;
  final double cash;
  final double buyingPower;
  final double dayPL;
  final double dayPLPct;
  final List<double> equityCurve;

  const AccountSummary({
    required this.portfolioValue,
    required this.cash,
    required this.buyingPower,
    required this.dayPL,
    required this.dayPLPct,
    required this.equityCurve,
  });

  bool get isDayPositive => dayPL >= 0;
}

class Position {
  final String symbol;
  final double qty;
  final double avgEntryPrice;
  final double currentPrice;
  final double marketValue;
  final double unrealizedPL;
  final double unrealizedPLPct;
  final double stopPrice;
  final double targetPrice;

  const Position({
    required this.symbol,
    required this.qty,
    required this.avgEntryPrice,
    required this.currentPrice,
    required this.marketValue,
    required this.unrealizedPL,
    required this.unrealizedPLPct,
    required this.stopPrice,
    required this.targetPrice,
  });

  bool get isProfit => unrealizedPL >= 0;

  double get riskToTarget => targetPrice - currentPrice;
  double get riskToStop => currentPrice - stopPrice;
}

class WatchlistQuote {
  final String symbol;
  final double price;
  final double change;
  final double changePct;
  final int signalScore;
  final String signalTrend;
  final List<double> miniChart;

  const WatchlistQuote({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePct,
    required this.signalScore,
    required this.signalTrend,
    required this.miniChart,
  });

  bool get isUp => change >= 0;

  Color get scoreColor {
    if (signalScore >= 70) return const Color(0xFF00FF66);
    if (signalScore >= 50) return const Color(0xFFFFAA00);
    return const Color(0xFFFF4444);
  }

  String get scoreLabel {
    if (signalScore >= 70) return 'STRONG';
    if (signalScore >= 50) return 'NEUTRAL';
    return 'WEAK';
  }
}

class TradeOrder {
  final String symbol;
  final int qty;
  final String side;
  final String orderType;
  final double? limitPrice;
  final double stopLoss;
  final double takeProfit;
  final double dollarRisk;

  const TradeOrder({
    required this.symbol,
    required this.qty,
    required this.side,
    required this.orderType,
    this.limitPrice,
    required this.stopLoss,
    required this.takeProfit,
    required this.dollarRisk,
  });
}
