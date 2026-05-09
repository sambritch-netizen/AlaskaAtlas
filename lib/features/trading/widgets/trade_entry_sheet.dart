import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../models/trading_models.dart';
import '../trading_provider.dart';

class TradeEntrySheet extends ConsumerStatefulWidget {
  final WatchlistQuote quote;

  const TradeEntrySheet({super.key, required this.quote});

  @override
  ConsumerState<TradeEntrySheet> createState() => _TradeEntrySheetState();
}

class _TradeEntrySheetState extends ConsumerState<TradeEntrySheet> {
  String _side = 'buy';
  String _orderType = 'market';
  int _qty = 1;
  final _limitController = TextEditingController();

  static const double _atrMultiplier = 1.5;
  static const double _rrRatio = 2.0;
  static const double _maxRisk = 100.0;

  // Estimated ATR from mini chart range
  double get _estimatedAtr {
    final data = widget.quote.miniChart;
    if (data.length < 2) return widget.quote.price * 0.01;
    final high = data.reduce((a, b) => a > b ? a : b);
    final low = data.reduce((a, b) => a < b ? a : b);
    return (high - low).clamp(widget.quote.price * 0.005, widget.quote.price * 0.03);
  }

  double get _stopDistance => _estimatedAtr * _atrMultiplier;
  double get _stopPrice => widget.quote.price - _stopDistance;
  double get _targetPrice => widget.quote.price + _stopDistance * _rrRatio;
  int get _suggestedQty => (_maxRisk / _stopDistance).floor().clamp(1, 999);
  double get _dollarRisk => _qty * _stopDistance;
  double get _orderValue => _qty * widget.quote.price;

  @override
  void initState() {
    super.initState();
    _qty = _suggestedQty;
    _limitController.text = widget.quote.price.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBuy = _side == 'buy';
    final actionColor = isBuy ? AppColors.accent : AppColors.danger;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 8,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.quote.symbol,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '\$${widget.quote.price.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Signal score
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.quote.scoreColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: widget.quote.scoreColor.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${widget.quote.signalScore}',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: widget.quote.scoreColor,
                      ),
                    ),
                    Text(
                      widget.quote.scoreLabel,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: widget.quote.scoreColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Buy / Sell toggle
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              children: [
                _SideButton(
                  label: 'BUY',
                  active: isBuy,
                  color: AppColors.accent,
                  onTap: () => setState(() => _side = 'buy'),
                ),
                _SideButton(
                  label: 'SELL',
                  active: !isBuy,
                  color: AppColors.danger,
                  onTap: () => setState(() => _side = 'sell'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Order type tabs
          Row(
            children: [
              _TypeTab(
                label: 'Market',
                active: _orderType == 'market',
                onTap: () => setState(() => _orderType = 'market'),
              ),
              const SizedBox(width: 8),
              _TypeTab(
                label: 'Limit',
                active: _orderType == 'limit',
                onTap: () => setState(() => _orderType = 'limit'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Limit price field (visible when limit selected)
          if (_orderType == 'limit') ...[
            TextField(
              controller: _limitController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
              ],
              style: GoogleFonts.inter(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'Limit Price',
                labelStyle:
                    GoogleFonts.inter(color: AppColors.textMuted, fontSize: 13),
                prefixText: '\$  ',
                prefixStyle:
                    GoogleFonts.inter(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Quantity stepper
          Row(
            children: [
              Text(
                'Shares',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              _QtyButton(
                icon: Icons.remove_rounded,
                onTap: () {
                  if (_qty > 1) setState(() => _qty--);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$_qty',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _QtyButton(
                icon: Icons.add_rounded,
                onTap: () => setState(() => _qty++),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Risk summary card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                _RiskRow(
                  label: 'Order value',
                  value: '\$${_orderValue.toStringAsFixed(2)}',
                  valueColor: AppColors.textPrimary,
                ),
                const SizedBox(height: 8),
                _RiskRow(
                  label: 'Stop loss',
                  value: '\$${_stopPrice.toStringAsFixed(2)}',
                  valueColor: AppColors.danger,
                ),
                const SizedBox(height: 8),
                _RiskRow(
                  label: 'Take profit',
                  value: '\$${_targetPrice.toStringAsFixed(2)}',
                  valueColor: AppColors.accent,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: AppColors.divider, height: 1),
                ),
                _RiskRow(
                  label: 'Max risk',
                  value: '\$${_dollarRisk.toStringAsFixed(2)}',
                  valueColor: _dollarRisk > _maxRisk
                      ? AppColors.warning
                      : AppColors.textSecondary,
                  bold: true,
                ),
              ],
            ),
          ),

          if (_dollarRisk > _maxRisk)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.warning, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'Risk exceeds \$${_maxRisk.toStringAsFixed(0)} limit — reduce shares',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.warning),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // Confirm button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _dollarRisk <= _maxRisk * 1.1 ? _submit : null,
              style: FilledButton.styleFrom(
                backgroundColor: actionColor,
                foregroundColor: AppColors.background,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                '${_side.toUpperCase()}  $_qty  ${widget.quote.symbol}',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final order = TradeOrder(
      symbol: widget.quote.symbol,
      qty: _qty,
      side: _side,
      orderType: _orderType,
      limitPrice:
          _orderType == 'limit' ? double.tryParse(_limitController.text) : null,
      stopLoss: _stopPrice,
      takeProfit: _targetPrice,
      dollarRisk: _dollarRisk,
    );

    if (!mounted) return;
    Navigator.pop(context);

    final ok = await ref.read(tradingProvider.notifier).placeOrder(order);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_side.toUpperCase()} $_qty ${widget.quote.symbol} submitted',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          backgroundColor: _side == 'buy' ? AppColors.accent : AppColors.danger,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }
}

class _SideButton extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  const _SideButton({
    required this.label,
    required this.active,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: active ? color.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            border: active
                ? Border.all(color: color.withValues(alpha: 0.5))
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: active ? color : AppColors.textMuted,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TypeTab(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: active
              ? AppColors.surfaceElevated
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? AppColors.borderColor : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? AppColors.textPrimary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 18),
      ),
    );
  }
}

class _RiskRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool bold;

  const _RiskRow({
    required this.label,
    required this.value,
    required this.valueColor,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

void showTradeEntrySheet(BuildContext context, WatchlistQuote quote) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => TradeEntrySheet(quote: quote),
  );
}
