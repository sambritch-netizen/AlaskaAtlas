import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/hotspots_data.dart';
import '../../models/hotspot.dart';
import '../../theme/app_colors.dart';
import '../../widgets/categorized_tile.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';
import '../map/hotspot_sheet.dart';

/// The recommendations page: editor's picks, browse by category,
/// local flavor, and the Turnagain Outfitters banner.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? _category;

  @override
  Widget build(BuildContext context) {
    final spots = HotspotsData.byCategory(_category);

    return Scaffold(
      body: TopoBackground(
        opacity: 0.35,
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
                    Text('Alaska Atlas',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 21)),
                    const Text(
                      'RECOMMENDATIONS FOR THE LAST FRONTIER',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.pine,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Editor's picks ─────────────────────────────────────────
            const SliverToBoxAdapter(
              child: SectionHeader(
                title: "Editor's Picks",
                subtitle: 'The places worth building a trip around',
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  itemCount: HotspotsData.featured.length,
                  itemBuilder: (context, i) =>
                      _FeaturedCard(spot: HotspotsData.featured[i]),
                ),
              ),
            ),

            // ── Browse all ─────────────────────────────────────────────
            const SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Browse Hot Spots',
                subtitle: 'Filter by what you came for',
              ),
            ),
            SliverToBoxAdapter(
              child: FilterChipsRow(
                options: HotspotsData.categories,
                selected: _category,
                emojiFor: HotspotsData.categoryEmoji,
                onSelected: (c) => setState(() => _category = c),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverList.builder(
                itemCount: spots.length,
                itemBuilder: (context, i) => _SpotListTile(spot: spots[i]),
              ),
            ),

            // ── Local flavor ───────────────────────────────────────────
            const SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Eat Like a Local',
                subtitle: 'Where Alaskans actually go',
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  itemCount: HotspotsData.localPicks.length,
                  itemBuilder: (context, i) =>
                      _LocalPickCard(pick: HotspotsData.localPicks[i]),
                ),
              ),
            ),

            // ── Turnagain banner ───────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                child: _TurnagainBanner(onTap: () => context.go('/gear')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final Hotspot spot;

  const _FeaturedCard({required this.spot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showHotspotSheet(context, spot),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.pineDeep.withValues(alpha: 0.85),
              AppColors.card,
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(spot.emoji, style: const TextStyle(fontSize: 30)),
                  const Spacer(),
                  MetaBadge(
                    label: spot.rating.toStringAsFixed(1),
                    color: AppColors.warning,
                    icon: Icons.star,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                spot.region.toUpperCase(),
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: AppColors.pine,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(spot.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Text(
                spot.blurb,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpotListTile extends StatelessWidget {
  final Hotspot spot;

  const _SpotListTile({required this.spot});

  @override
  Widget build(BuildContext context) {
    return CategorizedTile(
      title: spot.name,
      subtitle: spot.blurb,
      leadingEmoji: spot.emoji,
      onTap: () => showHotspotSheet(context, spot),
      trailing: [
        MetaBadge(label: spot.category, color: AppColors.pine),
        MetaBadge(label: spot.region, color: AppColors.textSecondary),
      ],
    );
  }
}

class _LocalPickCard extends StatelessWidget {
  final LocalPick pick;

  const _LocalPickCard({required this.pick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(pick.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pick.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${pick.kind} · ${pick.town}',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.rust,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              pick.blurb,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TurnagainBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _TurnagainBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.rust.withValues(alpha: 0.28),
            AppColors.rust.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.rust.withValues(alpha: 0.4)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.rust,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text('🎒', style: TextStyle(fontSize: 22))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'GEAR RENTALS BY',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                      ),
                      Text('Turnagain Outfitters',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 2),
                      Text(
                        'Fishing & camping packages, Starlink, and more',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.rust),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
