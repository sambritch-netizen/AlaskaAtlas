import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';

/// Detail of a single [FishingSubRegion] — its general regulations
/// (inclusive waters, methods, seasons) plus a list of all individually-
/// regulated water bodies, each tappable for a deeper breakdown.
class FishingSubRegionScreen extends StatelessWidget {
  final FishingSubRegion sub;

  const FishingSubRegionScreen({super.key, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          sub.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: TopoBackground(
        opacity: 0.3,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          children: [
            _Section(
              title: 'Inclusive Waters',
              child: Text(
                sub.inclusiveWaters,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
            ),
            if (sub.generalSeasons.isNotEmpty)
              _Section(
                title: 'General Seasons',
                child: _BulletList(items: sub.generalSeasons),
              ),
            if (sub.generalMethods.isNotEmpty)
              _Section(
                title: 'Methods & Means',
                child: _BulletList(items: sub.generalMethods),
              ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                'REGULATED WATERS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            for (final w in sub.waters) ...[
              _WaterRow(water: w),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.pine,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              item.startsWith(' ') || item.startsWith('   ')
                  ? item
                  : '• $item',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
      ],
    );
  }
}

class _WaterRow extends StatelessWidget {
  final FishingWater water;
  const _WaterRow({required this.water});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.go('/fishing/water', extra: water),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.water_drop_outlined,
                  color: AppColors.info, size: 18),
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
                    if (water.notes != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        water.notes!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          height: 1.35,
                        ),
                      ),
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
