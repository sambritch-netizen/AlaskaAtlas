import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/anchorage_data.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';

bool _isFishingCategory(AnchoragePOICategory c) =>
    c == AnchoragePOICategory.fishing || c == AnchoragePOICategory.lake;

String _categoryLabel(AnchoragePOICategory c) => switch (c) {
      AnchoragePOICategory.fishing => 'Fishing',
      AnchoragePOICategory.lake => 'Lake',
      AnchoragePOICategory.food => 'Food',
      AnchoragePOICategory.lodging => 'Lodging',
      AnchoragePOICategory.gearRental => 'Gear Rental',
      AnchoragePOICategory.trail => 'Trail',
      AnchoragePOICategory.scenic => 'Scenic',
      AnchoragePOICategory.wildlife => 'Wildlife',
    };

void showAnchoragePoiSheet(BuildContext context, AnchoragePOI poi) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AnchoragePoiSheet(poi: poi),
  );
}

class _AnchoragePoiSheet extends StatelessWidget {
  final AnchoragePOI poi;

  const _AnchoragePoiSheet({required this.poi});

  bool get _isFishing => _isFishingCategory(poi.category);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          controller: controller,
          padding: EdgeInsets.fromLTRB(
              24, 0, 24, 24 + MediaQuery.of(context).padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetHandle(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(poi.name,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  MetaBadge(
                    label: _categoryLabel(poi.category),
                    color: poi.isTurnagainOutfitters
                        ? AppColors.rust
                        : AppColors.pine,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                poi.quickFact,
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 14),
              Text(poi.description, style: Theme.of(context).textTheme.bodyMedium),
              if (_isFishing && poi.fishingSpecies.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Species', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: poi.fishingSpecies
                      .map((s) => MetaBadge(label: s, color: AppColors.pine))
                      .toList(),
                ),
                if (poi.fishingNotes != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      poi.fishingNotes!,
                      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ],
              if (poi.tags.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: poi.tags
                      .map((t) => MetaBadge(label: t, color: AppColors.textSecondary))
                      .toList(),
                ),
              ],
              if (poi.websiteUrl != null) ...[
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () =>
                      launchUrl(Uri.parse(poi.websiteUrl!), mode: LaunchMode.externalApplication),
                  child: const Text('Visit Website'),
                ),
              ],
              if (_isFishing && !poi.isTurnagainOutfitters) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.rust),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go('/gear');
                    },
                    icon: const Icon(Icons.backpack),
                    label: const Text('Rent Gear for This Spot'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
