import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/species.dart';
import '../../theme/app_colors.dart';
import '../../widgets/categorized_tile.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

/// Shows a list of [Species] entries for a single sub-category
/// (e.g. "Fish Species", "Birds", "Berries").
class SpeciesListScreen extends StatelessWidget {
  final String title;
  final List<Species> species;

  const SpeciesListScreen({
    super.key,
    required this.title,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopoBackground(
        opacity: 0.3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 108,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text(
                      '${species.length} species',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              sliver: SliverList.builder(
                itemCount: species.length,
                itemBuilder: (context, i) => _SpeciesCard(species: species[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeciesCard extends StatelessWidget {
  final Species species;

  const _SpeciesCard({required this.species});

  @override
  Widget build(BuildContext context) {
    return CategorizedTile(
      title: species.name,
      subtitle: species.scientificName,
      subtitleStyle: const TextStyle(
        fontSize: 11,
        fontStyle: FontStyle.italic,
        color: AppColors.textMuted,
      ),
      leadingIcon: guidesCategoryIcon(species.subcategory),
      onTap: () => context.go('/guides/species', extra: species),
    );
  }
}
