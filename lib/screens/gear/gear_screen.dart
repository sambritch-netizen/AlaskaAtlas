import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/gear_data.dart';
import '../../models/gear_item.dart';
import '../../services/turnagain_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

/// Gear catalog — live from the Turnagain Outfitters Base44 app when the
/// connector is configured, bundled catalog otherwise.
final gearCatalogProvider = FutureProvider<List<GearItem>>(
  (ref) => TurnagainService.instance.fetchCatalog(),
);

class GearScreen extends ConsumerStatefulWidget {
  const GearScreen({super.key});

  @override
  ConsumerState<GearScreen> createState() => _GearScreenState();
}

class _GearScreenState extends ConsumerState<GearScreen> {
  String? _category;

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(gearCatalogProvider);

    return Scaffold(
      body: TopoBackground(
        opacity: 0.3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 108,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rent Gear',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 21)),
                    const Text(
                      'COURTESY OF TURNAGAIN OUTFITTERS',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.rust,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Outfitter header card ──────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.rust.withValues(alpha: 0.25),
                      AppColors.rust.withValues(alpha: 0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: AppColors.rust.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.rust,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Center(
                          child: Text('🎒', style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(GearData.outfitterName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.verified,
                                  color: AppColors.rust, size: 16),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(GearData.outfitterTagline,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: FilterChipsRow(
                  options: GearData.categories,
                  selected: _category,
                  onSelected: (c) => setState(() => _category = c),
                ),
              ),
            ),

            catalogAsync.when(
              loading: () => const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(48),
                  child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.rust)),
                ),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text('Couldn\'t load the catalog: $e',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ),
              data: (items) {
                final filtered = _category == null
                    ? items
                    : items.where((i) => i.category == _category).toList();
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  sliver: SliverList.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) =>
                        _GearCard(item: filtered[i]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GearCard extends StatelessWidget {
  final GearItem item;

  const _GearCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go('/gear/detail', extra: item),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.rust.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: AppColors.rust.withValues(alpha: 0.3)),
                  ),
                  child: Center(
                      child: Text(item.emoji,
                          style: const TextStyle(fontSize: 24))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 3),
                      Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          MetaBadge(label: item.category, color: AppColors.rust),
                          const Spacer(),
                          Text(
                            '\$${item.pricePerDay.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Text(
                            ' /day',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
