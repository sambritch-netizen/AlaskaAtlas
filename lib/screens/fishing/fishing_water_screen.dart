import 'package:flutter/material.dart';

import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';

/// Detail of a single regulated water body — its seasons and methods/means.
class FishingWaterScreen extends StatelessWidget {
  final FishingWater water;

  const FishingWaterScreen({super.key, required this.water});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          water.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: TopoBackground(
        opacity: 0.3,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            if (water.notes != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  water.notes!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ),
            if (water.species.isNotEmpty)
              _SpeciesCard(species: water.species),
            if (water.seasons.isNotEmpty)
              _Card(
                title: 'Seasons',
                icon: Icons.calendar_month,
                items: water.seasons,
              ),
            if (water.methods.isNotEmpty)
              _Card(
                title: 'Methods & Means',
                icon: Icons.set_meal_outlined,
                items: water.methods,
              ),
            if (water.seasons.isEmpty &&
                water.methods.isEmpty &&
                water.species.isEmpty)
              const _Card(
                title: 'Notes',
                icon: Icons.info_outline,
                items: [
                  'No water-specific special regulations beyond the sub-region general regs.',
                  'Check the ADF&G booklet for the latest bag limits and any emergency orders.',
                ],
              ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: const Text(
                'Bag limits, length limits, and possession limits are '
                'intentionally omitted. Check the current ADF&G booklet '
                'and emergency orders at adfg.alaska.gov/sf/EONR before '
                'you cast.',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeciesCard extends StatelessWidget {
  final List<String> species;
  const _SpeciesCard({required this.species});

  static const Map<String, String> _emoji = {
    'King Salmon': '👑',
    'Coho (Silver) Salmon': '🥈',
    'Sockeye (Red) Salmon': '🔴',
    'Pink (Humpy) Salmon': '🩷',
    'Chum (Dog) Salmon': '🐕',
    'Rainbow/Steelhead Trout': '🌈',
    'Arctic Char / Dolly Varden': '🐠',
    'Arctic Grayling': '🪶',
    'Lake Trout': '🎣',
    'Burbot': '🦈',
    'Northern Pike (Invasive)': '⚠️',
    'Whitefish': '🐟',
    'Other Finfish': '🐡',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
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
            const Row(
              children: [
                Icon(Icons.set_meal, size: 16, color: AppColors.pine),
                SizedBox(width: 8),
                Text(
                  'SPECIES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in species)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_emoji[s] ?? '🐟',
                            style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 6),
                        Text(
                          s,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  const _Card({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
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
            Row(
              children: [
                Icon(icon, size: 16, color: AppColors.pine),
                const SizedBox(width: 8),
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                    height: 1.45,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
