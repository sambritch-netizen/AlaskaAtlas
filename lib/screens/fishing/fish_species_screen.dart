import 'package:flutter/material.dart';

import '../../data/fishing_species_profiles.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';

/// Individual fish species page — opened when you tap a species chip on a
/// regulated water detail page.
class FishSpeciesScreen extends StatelessWidget {
  final String speciesName;

  const FishSpeciesScreen({super.key, required this.speciesName});

  @override
  Widget build(BuildContext context) {
    final profile = FishingSpeciesProfiles.byName[speciesName];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          speciesName,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: TopoBackground(
        opacity: 0.3,
        child: profile == null
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No profile on file for this species yet.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  // Icon placeholder — replace with bundled species art later.
                  Container(
                    height: 140,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_outlined,
                      size: 40,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    profile.scientificName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppColors.pine,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.summary,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (profile.identification.isNotEmpty)
                    _Card(
                      title: 'Identification',
                      items: profile.identification,
                    ),
                  if (profile.habitat.isNotEmpty)
                    _Card(
                      title: 'Habitat',
                      items: profile.habitat,
                    ),
                  if (profile.season.isNotEmpty)
                    _Card(
                      title: 'Prime Window',
                      items: [profile.season],
                    ),
                  if (profile.tacticsAndGear.isNotEmpty)
                    _Card(
                      title: 'Tactics & Gear',
                      items: profile.tacticsAndGear,
                    ),
                ],
              ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final List<String> items;
  const _Card({required this.title, required this.items});

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
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.pine,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '• $item',
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
