import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/fishing_regs_data.dart';
import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';
import 'fishing_common.dart';

/// Detail of a single regulated water body — its species and methods/means.
class FishingWaterScreen extends StatelessWidget {
  final FishingWater water;

  const FishingWaterScreen({super.key, required this.water});

  /// Walk the regs tree to find which region/subregion contains this water.
  /// Anglers arriving via search need this — ADF&G rules differ by region.
  ({String region, String sub})? _locate() {
    for (final region in FishingRegsData.regions) {
      for (final sub in region.subRegions) {
        if (sub.waters.contains(water)) {
          return (
            region: region.name.replaceAll(' Regulations', ''),
            sub: sub.name,
          );
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final loc = _locate();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: TopoBackground(
        opacity: 0.3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 150,
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 56, right: 16, bottom: 14),
                title: Text(
                  water.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'MudTrack',
                    fontSize: 20,
                    letterSpacing: 0.5,
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x4D5B8BAB), AppColors.background],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 48, right: 20),
                        child: Icon(Icons.phishing,
                            size: 64, color: Color(0x335B8BAB)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (loc != null) ...[
                    Row(
                      children: [
                        const Icon(Icons.place_outlined,
                            size: 13, color: FishingStyle.water),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            '${loc.region} · ${loc.sub}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                  if (water.notes != null) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: FishingStyle.water.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: FishingStyle.water.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline,
                              size: 16, color: FishingStyle.water),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              water.notes!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                  if (water.species.isNotEmpty) ...[
                    const FishingSectionHeader('SPECIES PRESENT'),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap a species for ID, habitat & how to fish it.',
                      style:
                          TextStyle(fontSize: 11.5, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final s in water.species)
                          SpeciesChip(
                            species: s,
                            onTap: () =>
                                context.go('/fishing/species', extra: s),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (water.methods.isNotEmpty) ...[
                    const FishingSectionHeader('METHODS & MEANS'),
                    const SizedBox(height: 12),
                    _BulletCard(items: water.methods),
                  ],
                  if (water.species.isEmpty && water.methods.isEmpty)
                    const _BulletCard(items: [
                      'No species or method-specific information on file '
                          'for this water.',
                    ]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  final List<String> items;
  const _BulletCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: FishingStyle.water,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.trim(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.45,
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
}
