import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';
import 'fishing_common.dart';

/// Lists the sub-regions inside a single [FishingRegion].
class FishingRegionScreen extends StatelessWidget {
  final FishingRegion region;

  const FishingRegionScreen({super.key, required this.region});

  int get _waterCount =>
      region.subRegions.fold(0, (s, sub) => s + sub.waters.length);

  @override
  Widget build(BuildContext context) {
    final title = region.name.replaceAll(' Regulations', '');
    return Scaffold(
      backgroundColor: AppColors.background,
      body: TopoBackground(
        opacity: 0.3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 132,
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 56, bottom: 14),
                title: Text(
                  title.toUpperCase(),
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
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      region.summary,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 18),
                    FishingSectionHeader(
                      'SUB-REGIONS',
                      trailing: Text(
                        '${region.subRegions.length} · $_waterCount waters',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: FishingStyle.water,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              sliver: SliverList.separated(
                itemCount: region.subRegions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) =>
                    _SubRegionCard(sub: region.subRegions[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubRegionCard extends StatelessWidget {
  final FishingSubRegion sub;
  const _SubRegionCard({required this.sub});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.go('/fishing/subregion', extra: sub),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: FishingStyle.water.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.water, color: FishingStyle.water),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sub.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${sub.waters.length} regulated waters',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: FishingStyle.water,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
