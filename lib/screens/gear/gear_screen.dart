import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/gear_data.dart';
import '../../models/gear_item.dart';
import '../../services/turnagain_service.dart';
import '../../theme/app_colors.dart';
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
              expandedHeight: 96,
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
            catalogAsync.when(
              loading: () => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                    child: CircularProgressIndicator(color: AppColors.rust)),
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
              data: (items) => _buildCatalog(context, items),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatalog(BuildContext context, List<GearItem> items) {
    final filtered = _category == null
        ? items
        : items.where((i) => i.category == _category).toList();
    final featured = items.where((i) => i.featured).toList();
    final showFeatured = _category == null && featured.isNotEmpty;

    return SliverMainAxisGroup(
      slivers: [
        // ── Outfitter banner ────────────────────────────────────────
        const SliverToBoxAdapter(child: _OutfitterBanner()),

        // ── Featured carousel (only on the "All" view) ──────────────
        if (showFeatured) ...[
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: _SectionLabel('FEATURED GEAR'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: featured.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) =>
                    _FeaturedCard(item: featured[i]),
              ),
            ),
          ),
        ],

        // ── Category chips ──────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: _CategoryChips(
              selected: _category,
              counts: {
                for (final c in GearData.categories)
                  c: items.where((i) => i.category == c).length
              },
              total: items.length,
              onSelected: (c) => setState(() => _category = c),
            ),
          ),
        ),

        // ── Grid of gear ────────────────────────────────────────────
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.74,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) => _GearCard(item: filtered[i]),
              childCount: filtered.length,
            ),
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Shared pieces
// ────────────────────────────────────────────────────────────────────────

/// A network product photo with a graceful category-tinted fallback.
class GearImage extends StatelessWidget {
  final GearItem item;
  final BoxFit fit;

  const GearImage({super.key, required this.item, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      color: AppColors.rust.withValues(alpha: 0.12),
      alignment: Alignment.center,
      child: Text(item.emoji, style: const TextStyle(fontSize: 40)),
    );
    if (item.imageUrl == null) return fallback;
    return Image.network(
      item.imageUrl!,
      fit: fit,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : Container(color: AppColors.card),
      errorBuilder: (context, _, __) => fallback,
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: AppColors.textSecondary,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _OutfitterBanner extends StatelessWidget {
  const _OutfitterBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.rust.withValues(alpha: 0.25),
            AppColors.rust.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.rust.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.rust,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.backpack, color: Colors.white, size: 24),
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
                          style: Theme.of(context).textTheme.titleLarge),
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
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final String? selected;
  final Map<String, int> counts;
  final int total;
  final ValueChanged<String?> onSelected;

  const _CategoryChips({
    required this.selected,
    required this.counts,
    required this.total,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final entries = <(String?, String, int)>[
      (null, 'All', total),
      for (final c in GearData.categories) (c, c, counts[c] ?? 0),
    ];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (value, label, count) = entries[i];
          final active = selected == value;
          return GestureDetector(
            onTap: () => onSelected(value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AppColors.rust : Colors.transparent,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: active ? AppColors.rust : AppColors.border,
                ),
              ),
              child: Text(
                '$label · $count',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Featured carousel card
// ────────────────────────────────────────────────────────────────────────

class _FeaturedCard extends StatelessWidget {
  final GearItem item;
  const _FeaturedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/gear/detail', extra: item),
      child: SizedBox(
        width: 260,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              GearImage(item: item),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xE6000000)],
                    stops: [0.4, 1.0],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item.isPackage) const _PackagePill(),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        height: 1.0,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _PriceTag(price: item.pricePerDay, light: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Grid card
// ────────────────────────────────────────────────────────────────────────

class _GearCard extends StatelessWidget {
  final GearItem item;
  const _GearCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/gear/detail', extra: item),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GearImage(item: item),
                    if (item.isPackage)
                      const Positioned(
                        top: 8,
                        left: 8,
                        child: _PackagePill(),
                      ),
                    if (item.noFly)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: _NoFlyBadge(),
                      ),
                  ],
                ),
              ),
            ),
            // Text
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _PriceTag(price: item.pricePerDay),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Small bits
// ────────────────────────────────────────────────────────────────────────

class _PriceTag extends StatelessWidget {
  final double price;
  final bool light;
  const _PriceTag({required this.price, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '\$${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: light ? Colors.white : AppColors.rust,
          ),
        ),
        Text(
          ' /day',
          style: TextStyle(
            fontSize: 11,
            color: light
                ? Colors.white.withValues(alpha: 0.8)
                : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _PackagePill extends StatelessWidget {
  const _PackagePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.pine,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'PACKAGE',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _NoFlyBadge extends StatelessWidget {
  const _NoFlyBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.no_transfer, color: Colors.white, size: 14),
    );
  }
}
