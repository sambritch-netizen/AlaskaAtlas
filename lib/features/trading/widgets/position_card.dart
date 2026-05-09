import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../models/trading_models.dart';

class PositionCard extends StatelessWidget {
  final Position position;
  final VoidCallback? onClose;

  const PositionCard({super.key, required this.position, this.onClose});

  @override
  Widget build(BuildContext context) {
    final plColor = position.isProfit ? AppColors.accent : AppColors.danger;
    final plSign = position.isProfit ? '+' : '';
    final progressPct = _progressToTarget();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          // Left accent bar + main content
          IntrinsicHeight(
            child: Row(
              children: [
                // Left colored bar
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: plColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Symbol + current price row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  position.symbol,
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${_fmtQty(position.qty)} shares  ·  avg \$${position.avgEntryPrice.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${position.currentPrice.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: plColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '$plSign\$${position.unrealizedPL.abs().toStringAsFixed(2)}  '
                                    '$plSign${position.unrealizedPLPct.toStringAsFixed(2)}%',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: plColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Progress bar: stop ←─── current ──→ target
                        _ProgressBar(
                          progress: progressPct,
                          color: plColor,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              'Stop \$${position.stopPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.danger,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Target \$${position.targetPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.accent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer: market value + close button
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Market value  ',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.textMuted),
                ),
                Text(
                  '\$${position.marketValue.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.danger.withValues(alpha: 0.4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Close Position',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _progressToTarget() {
    final total = position.targetPrice - position.stopPrice;
    if (total <= 0) return 0.5;
    final progress = (position.currentPrice - position.stopPrice) / total;
    return progress.clamp(0.0, 1.0);
  }

  String _fmtQty(double qty) =>
      qty == qty.truncate() ? qty.truncate().toString() : qty.toString();
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;

  const _ProgressBar({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 4,
        child: Stack(
          children: [
            Container(color: AppColors.surfaceElevated),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.danger, color],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
