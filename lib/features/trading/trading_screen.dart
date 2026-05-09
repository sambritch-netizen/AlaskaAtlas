import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import 'trading_provider.dart';
import 'widgets/portfolio_card.dart';
import 'widgets/position_card.dart';
import 'widgets/watchlist_tile.dart';
import 'widgets/trade_entry_sheet.dart';

class TradingScreen extends ConsumerWidget {
  const TradingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tradingProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.accent,
        backgroundColor: AppColors.surface,
        onRefresh: () => ref.read(tradingProvider.notifier).refresh(),
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              pinned: true,
              backgroundColor: AppColors.background,
              title: Text(
                'Trading',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              actions: [
                if (state.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: AppColors.accent,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded,
                        color: AppColors.textSecondary),
                    onPressed: () =>
                        ref.read(tradingProvider.notifier).refresh(),
                  ),
                _MarketStatusChip(),
                const SizedBox(width: 8),
              ],
            ),

            // Portfolio card
            SliverToBoxAdapter(
              child: PortfolioCard(account: state.account),
            ),

            // Positions section
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Positions',
                count: state.positions.length,
                trailing: state.positions.isEmpty
                    ? null
                    : TextButton(
                        onPressed: () {},
                        child: Text(
                          'Close All',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.danger,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
            ),

            if (state.positions.isEmpty)
              SliverToBoxAdapter(
                child: _EmptyState(
                  icon: Icons.show_chart_rounded,
                  message: 'No open positions',
                  sub: 'Tap + on any watchlist stock to enter a trade',
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => PositionCard(
                    position: state.positions[i],
                    onClose: () => ref
                        .read(tradingProvider.notifier)
                        .closePosition(state.positions[i].symbol),
                  ),
                  childCount: state.positions.length,
                ),
              ),

            // Watchlist section
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Watchlist',
                count: state.watchlist.length,
                trailing: _WatchlistFilter(),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final quote = state.watchlist[i];
                  return WatchlistTile(
                    quote: quote,
                    onTrade: () => showTradeEntrySheet(context, quote),
                  );
                },
                childCount: state.watchlist.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),

      // New trade FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (state.watchlist.isNotEmpty) {
            showTradeEntrySheet(context, state.watchlist.first);
          }
        },
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.background,
        elevation: 0,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'New Trade',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// ── Supporting widgets ────────────────────────────────────────────────────────

class _MarketStatusChip extends StatelessWidget {
  bool _isMarketOpen() {
    final now = DateTime.now().toUtc().subtract(const Duration(hours: 4));
    if (now.weekday > 5) return false;
    final open = DateTime(now.year, now.month, now.day, 9, 30);
    final close = DateTime(now.year, now.month, now.day, 16, 0);
    return now.isAfter(open) && now.isBefore(close);
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = _isMarketOpen();
    final color = isOpen ? AppColors.accent : AppColors.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            isOpen ? 'OPEN' : 'CLOSED',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Widget? trailing;

  const _SectionHeader(
      {required this.title, required this.count, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 8, 4),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '$count',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _WatchlistFilter extends StatefulWidget {
  @override
  State<_WatchlistFilter> createState() => _WatchlistFilterState();
}

class _WatchlistFilterState extends State<_WatchlistFilter> {
  String _filter = 'All';
  static const _options = ['All', 'Strong', 'Movers'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _options
          .map(
            (o) => GestureDetector(
              onTap: () => setState(() => _filter = o),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(left: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _filter == o
                      ? AppColors.accent.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: _filter == o
                        ? AppColors.accent.withValues(alpha: 0.4)
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  o,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _filter == o
                        ? AppColors.accent
                        : AppColors.textMuted,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String sub;

  const _EmptyState(
      {required this.icon, required this.message, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(icon, color: AppColors.textMuted, size: 36),
          const SizedBox(height: 10),
          Text(message,
              style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
          const SizedBox(height: 4),
          Text(sub,
              style: GoogleFonts.inter(
                  color: AppColors.textMuted, fontSize: 13)),
        ],
      ),
    );
  }
}
