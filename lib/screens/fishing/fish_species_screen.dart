import 'package:flutter/material.dart';

import '../../data/fishing_species_profiles.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';
import 'fishing_common.dart';

/// Individual fish species page — opened when you tap a species chip on a
/// regulated water detail page or the browse strip.
class FishSpeciesScreen extends StatelessWidget {
  final String speciesName;

  const FishSpeciesScreen({super.key, required this.speciesName});

  @override
  Widget build(BuildContext context) {
    final profile = FishingSpeciesProfiles.byName[speciesName];
    final c = FishingStyle.colorFor(speciesName);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: TopoBackground(
        opacity: 0.3,
        child: profile == null
            ? Column(
                children: [
                  AppBar(
                    backgroundColor: AppColors.background,
                    elevation: 0,
                    title: Text(speciesName),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No profile on file for this species yet.',
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    ),
                  ),
                ],
              )
            : CustomScrollView(
                slivers: [
                  // ── Themed hero ───────────────────────────────────────
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 196,
                    backgroundColor: AppColors.background,
                    foregroundColor: AppColors.textPrimary,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding:
                          const EdgeInsets.only(left: 56, right: 16, bottom: 14),
                      title: Text(
                        FishingStyle.shortFor(speciesName).toUpperCase(),
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
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  c.withValues(alpha: 0.38),
                                  AppColors.background,
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 52, right: 24),
                              child: SpeciesBadge(
                                  species: speciesName, size: 72),
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
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.scientificName,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontStyle: FontStyle.italic,
                            color: c,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          profile.summary,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.5,
                          ),
                        ),
                        if (profile.season.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _PrimeWindow(text: profile.season, color: c),
                        ],
                        const SizedBox(height: 8),
                        if (profile.identification.isNotEmpty)
                          _InfoCard(
                            icon: Icons.visibility_outlined,
                            title: 'Identification',
                            items: profile.identification,
                            color: c,
                          ),
                        if (profile.habitat.isNotEmpty)
                          _InfoCard(
                            icon: Icons.terrain_outlined,
                            title: 'Habitat',
                            items: profile.habitat,
                            color: c,
                          ),
                        if (profile.tacticsAndGear.isNotEmpty)
                          _InfoCard(
                            icon: Icons.phishing,
                            title: 'Tactics & Gear',
                            items: profile.tacticsAndGear,
                            color: c,
                          ),
                      ]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _PrimeWindow extends StatelessWidget {
  final String text;
  final Color color;
  const _PrimeWindow({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.event_available_outlined, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRIME WINDOW',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
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

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;
  final Color color;
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.items,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 8),
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
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
      ),
    );
  }
}
