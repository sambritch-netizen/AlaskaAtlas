import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';

/// Lists the sub-regions inside a single [FishingRegion].
class FishingRegionScreen extends StatelessWidget {
  final FishingRegion region;

  const FishingRegionScreen({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          region.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: TopoBackground(
        opacity: 0.3,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Text(
              region.summary,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            for (final sub in region.subRegions) ...[
              _SubRegionCard(sub: sub),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 8),
            const _AdfgFooter(),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.water, color: AppColors.info, size: 22),
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
                    const SizedBox(height: 4),
                    Text(
                      '${sub.waters.length} regulated waters',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine,
                        letterSpacing: 0.6,
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

class _AdfgFooter extends StatelessWidget {
  const _AdfgFooter();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: const Text(
        'Summarized from the 2026 ADF&G Southcentral Sport Fishing '
        'Regulations. Bag/length limits intentionally omitted — '
        'emergency orders supersede published regulations. '
        'Always check adfg.alaska.gov/sf/EONR before you cast.',
        style: TextStyle(
          fontSize: 11,
          color: AppColors.textMuted,
          height: 1.45,
        ),
      ),
    );
  }
}
