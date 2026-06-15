import 'package:flutter/material.dart';

import '../../models/species.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

/// Full field-guide page for a single [Species] — fish, bird, land
/// animal, berry, or mushroom.
class SpeciesDetailScreen extends StatelessWidget {
  final Species species;

  const SpeciesDetailScreen({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopoBackground(
        opacity: 0.25,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 160,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.pine.withValues(alpha: 0.30),
                        AppColors.background,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(species.emoji,
                                style: const TextStyle(fontSize: 44)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    species.subcategory.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.pine,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(species.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                  Text(
                                    species.scientificName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Stats ────────────────────────────────────────
                    Row(
                      children: [
                        _Stat(
                          icon: Icons.straighten,
                          value: species.size,
                          label: 'SIZE',
                        ),
                        _Stat(
                          icon: Icons.calendar_today_outlined,
                          value: species.season,
                          label: 'SEASON',
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(species.overview,
                        style: Theme.of(context).textTheme.bodyMedium),

                    // ── Habitat ──────────────────────────────────────
                    const SizedBox(height: 22),
                    Text('Habitat',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(species.habitat,
                        style: Theme.of(context).textTheme.bodyMedium),

                    // ── Facts ────────────────────────────────────────
                    const SizedBox(height: 22),
                    Text('Quick Facts',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 10),
                    ...species.facts.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('▸ ',
                                  style: TextStyle(
                                      color: AppColors.pine, fontSize: 13)),
                              Expanded(
                                child: Text(f,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    )),
                              ),
                            ],
                          ),
                        )),

                    // ── Baits / Lures ────────────────────────────────
                    if (species.baits.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Text('Best Baits & Lures',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: species.baits
                            .map((b) =>
                                MetaBadge(label: b, color: AppColors.birch))
                            .toList(),
                      ),
                    ],

                    // ── Tips ─────────────────────────────────────────
                    const SizedBox(height: 22),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.pine.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.pine.withValues(alpha: 0.25)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.tips_and_updates_outlined,
                                  color: AppColors.pine, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                species.subcategory == 'Fish Species'
                                    ? 'HOW TO FISH IT'
                                    : species.subcategory == 'Birds' ||
                                            species.subcategory ==
                                                'Land Animals'
                                        ? 'HOW TO SPOT IT'
                                        : 'HOW TO HARVEST IT',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.pine,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(species.tips,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),

                    // ── Caution ──────────────────────────────────────
                    if (species.caution != null) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.danger.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                size: 16, color: AppColors.danger),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                species.caution!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),
                    Text(
                      'Always check current ADF&G regulations, bag limits, and seasons before fishing, hunting, or harvesting.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _Stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppColors.pine),
            const SizedBox(height: 6),
            Text(value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                )),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  letterSpacing: 1.1,
                )),
          ],
        ),
      ),
    );
  }
}
