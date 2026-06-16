import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';
import 'fishing_common.dart';

/// Detail of a single [FishingSubRegion] — the list of regulated waters.
class FishingSubRegionScreen extends StatelessWidget {
  final FishingSubRegion sub;

  const FishingSubRegionScreen({super.key, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: TopoBackground(
        opacity: 0.3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 124,
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 56, bottom: 14),
                title: Text(
                  sub.name.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'MudTrack',
                    fontSize: 20,
                    letterSpacing: 0.5,
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x335B8BAB), AppColors.background],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
                child: FishingSectionHeader(
                    '${sub.waters.length} REGULATED WATERS'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              sliver: SliverList.separated(
                itemCount: sub.waters.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) => _WaterRow(water: sub.waters[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaterRow extends StatelessWidget {
  final FishingWater water;
  const _WaterRow({required this.water});

  @override
  Widget build(BuildContext context) {
    final species = water.species;
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () => context.go('/fishing/water', extra: water),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.water_drop_outlined,
                  color: FishingStyle.water, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      water.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (species.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      _SpeciesDots(species: species),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// A compact row of colored species dots + count, previewing what swims here.
class _SpeciesDots extends StatelessWidget {
  final List<String> species;
  const _SpeciesDots({required this.species});

  @override
  Widget build(BuildContext context) {
    final shown = species.take(6).toList();
    return Row(
      children: [
        for (final s in shown)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: FishingStyle.colorFor(s),
                shape: BoxShape.circle,
              ),
            ),
          ),
        const SizedBox(width: 4),
        Text(
          '${species.length} species',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
