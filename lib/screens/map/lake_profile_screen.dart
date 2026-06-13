import 'package:flutter/material.dart';

import '../../models/lake.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bathymetry_chart.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

class LakeProfileScreen extends StatelessWidget {
  final Lake lake;

  const LakeProfileScreen({super.key, required this.lake});

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
                        AppColors.info.withValues(alpha: 0.30),
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
                            const Text('💧', style: TextStyle(fontSize: 40)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LAKE PROFILE · ${lake.area.toUpperCase()}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.info,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(lake.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
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
                          value: '~${lake.maxDepthFt} ft',
                          label: 'MAX DEPTH',
                        ),
                        _Stat(
                          icon: Icons.water,
                          value: '${lake.surfaceAcres.round()} ac',
                          label: 'SURFACE',
                        ),
                        _Stat(
                          icon: Icons.set_meal,
                          value: '${lake.species.length}',
                          label: 'SPECIES',
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(lake.blurb,
                        style: Theme.of(context).textTheme.bodyMedium),

                    // ── Depth chart ──────────────────────────────────
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Text('Depth Chart',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const Spacer(),
                        const Icon(Icons.pinch_outlined,
                            size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text('pinch to zoom',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BathymetryChart(lake: lake),
                    const SizedBox(height: 6),
                    Text(
                      'Stylized chart — depths approximate. Not for navigation.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    // ── Species ──────────────────────────────────────
                    const SizedBox(height: 24),
                    Text('What\'s Swimming',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 10),
                    ...lake.species.map((s) => _SpeciesCard(species: s)),

                    // ── Tactics ──────────────────────────────────────
                    if (lake.tactics.isNotEmpty) ...[
                      const SizedBox(height: 18),
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
                            const Row(
                              children: [
                                Icon(Icons.tips_and_updates_outlined,
                                    color: AppColors.pine, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'LOCAL TACTICS',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.pine,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...lake.tactics.map((t) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('▸ ',
                                          style: TextStyle(
                                              color: AppColors.pine,
                                              fontSize: 13)),
                                      Expanded(
                                        child: Text(t,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColors.textSecondary,
                                              height: 1.4,
                                            )),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],

                    // ── Access ───────────────────────────────────────
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.directions_car_outlined,
                            size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(lake.access,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    if (lake.accessNote != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.warning.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline,
                                size: 16, color: AppColors.warning),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                lake.accessNote!,
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
                      'Stocking follows the ADF&G program — check current stocking reports and regulations before fishing.',
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppColors.info),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                  fontSize: 15,
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

class _SpeciesCard extends StatelessWidget {
  final LakeSpecies species;

  const _SpeciesCard({required this.species});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(species.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(species.name,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              if (species.stocked)
                const MetaBadge(label: 'Stocked', color: AppColors.info),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: species.baits
                .map((b) => MetaBadge(label: b, color: AppColors.birch))
                .toList(),
          ),
          const SizedBox(height: 10),
          Text(species.tip, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
