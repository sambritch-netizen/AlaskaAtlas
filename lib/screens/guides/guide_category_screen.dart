import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/fish_species_data.dart';
import '../../data/guides_data.dart';
import '../../data/harvest_species_data.dart';
import '../../data/wildlife_species_data.dart';
import '../../models/guide.dart';
import '../../models/species.dart';
import '../../theme/app_colors.dart';
import '../../widgets/categorized_tile.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

/// Species sub-categories shown as a "browse by type" row for the
/// Fishing, Wildlife, and Harvesting guide categories.
const Map<String, List<SpeciesSubcategory>> _speciesSubcategories = {
  'Fishing': [
    SpeciesSubcategory(
      name: 'Fish Species',
      emoji: '🐟',
      description: 'Identification, habitat & how-to-fish for Alaska gamefish',
    ),
  ],
  'Wildlife': [
    SpeciesSubcategory(
      name: 'Birds',
      emoji: '🦅',
      description: 'Eagles, swans, grouse & more',
    ),
    SpeciesSubcategory(
      name: 'Land Animals',
      emoji: '🐻',
      description: 'Bears, moose, caribou & more',
    ),
  ],
  'Harvesting': [
    SpeciesSubcategory(
      name: 'Berries',
      emoji: '🫐',
      description: 'What to pick & when',
    ),
    SpeciesSubcategory(
      name: 'Mushrooms & Foraging',
      emoji: '🍄',
      description: 'Edible fungi & how to ID them safely',
    ),
    SpeciesSubcategory(
      name: 'Other Wild Edibles',
      emoji: '🌿',
      description: 'Greens, shoots & more',
    ),
  ],
};

List<Species> _speciesForSubcategory(String name) {
  return [
    ...FishSpeciesData.all,
    ...WildlifeSpeciesData.all,
    ...HarvestSpeciesData.all,
  ].where((s) => s.subcategory == name).toList();
}

/// A single guide category — shows its species sub-categories (if any)
/// and the list of field guides for that category.
class GuideCategoryScreen extends StatelessWidget {
  final String category;

  const GuideCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final guides =
        GuidesData.guides.where((g) => g.category == category).toList();
    final subcategories = _speciesSubcategories[category];

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
                    Row(
                      children: [
                        Icon(guidesCategoryIcon(category),
                            color: AppColors.pine, size: 22),
                        const SizedBox(width: 8),
                        Text(category,
                            style: Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (subcategories != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Browse by Type',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      ...subcategories
                          .map((sub) => _SubcategoryCard(subcategory: sub)),
                      const SizedBox(height: 14),
                      Text('Guides',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            else
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList.builder(
                itemCount: guides.length,
                itemBuilder: (context, i) => _GuideCard(guide: guides[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubcategoryCard extends StatelessWidget {
  final SpeciesSubcategory subcategory;

  const _SubcategoryCard({required this.subcategory});

  @override
  Widget build(BuildContext context) {
    final species = _speciesForSubcategory(subcategory.name);
    return CategorizedTile(
      title: subcategory.name,
      subtitle: subcategory.description,
      leadingIcon: guidesCategoryIcon(subcategory.name),
      onTap: () => context.go('/guides/species-list', extra: {
        'title': subcategory.name,
        'species': species,
      }),
      trailing: [
        MetaBadge(label: '${species.length}', color: AppColors.textMuted),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final Guide guide;

  const _GuideCard({required this.guide});

  Color get _difficultyColor => switch (guide.difficulty) {
        'Beginner' => AppColors.pine,
        'Intermediate' => AppColors.warning,
        _ => AppColors.danger,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go('/guides/detail', extra: guide),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.pine.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.pine.withValues(alpha: 0.25)),
                      ),
                      child: Icon(guidesCategoryIcon(guide.category),
                          color: AppColors.pine, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(guide.title,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textMuted, size: 20),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  guide.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    MetaBadge(label: guide.difficulty, color: _difficultyColor),
                    const SizedBox(width: 8),
                    MetaBadge(
                      label: '${guide.readMinutes} min read',
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        guide.season,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
