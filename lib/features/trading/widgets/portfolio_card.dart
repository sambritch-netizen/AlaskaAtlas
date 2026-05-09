import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../models/trading_models.dart';
import 'sparkline.dart';

class PortfolioCard extends StatelessWidget {
  final AccountSummary account;

  const PortfolioCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final plColor = account.isDayPositive ? AppColors.accent : AppColors.danger;
    final plSign = account.isDayPositive ? '+' : '';

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            'PORTFOLIO VALUE',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),

          // Big number
          Text(
            '\$${_fmt(account.portfolioValue)}',
            style: GoogleFonts.inter(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),

          // Day P&L
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: plColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      account.isDayPositive
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      color: plColor,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$plSign\$${_fmt(account.dayPL.abs())}  '
                      '$plSign${account.dayPLPct.toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: plColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'today',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sparkline
          if (account.equityCurve.isNotEmpty)
            SizedBox(
              height: 48,
              child: Sparkline(
                data: account.equityCurve,
                color: plColor,
                strokeWidth: 2,
                filled: true,
              ),
            ),

          const SizedBox(height: 16),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),

          // Cash / Buying power row
          Row(
            children: [
              _StatChip(label: 'CASH', value: '\$${_fmtK(account.cash)}'),
              const SizedBox(width: 12),
              _StatChip(
                  label: 'BUYING POWER',
                  value: '\$${_fmtK(account.buyingPower)}'),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(double v) {
    final abs = v.abs();
    if (abs >= 1000) {
      final s = abs.toStringAsFixed(2);
      final parts = s.split('.');
      final intPart = parts[0];
      final dec = parts[1];
      final buf = StringBuffer();
      for (int i = 0; i < intPart.length; i++) {
        if (i > 0 && (intPart.length - i) % 3 == 0) buf.write(',');
        buf.write(intPart[i]);
      }
      return '${buf.toString()}.$dec';
    }
    return abs.toStringAsFixed(2);
  }

  String _fmtK(double v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}k';
    return v.toStringAsFixed(0);
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
