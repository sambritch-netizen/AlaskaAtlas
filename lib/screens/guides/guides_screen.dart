import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/guides_data.dart';
import '../../models/guide.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';

/// Field Guides landing page — a grid of category tiles. Tapping a
/// tile opens [GuideCategoryScreen] for that category.
class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

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
                    Text('Field Guides',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 21)),
                    const Text(
                      'KNOW-HOW FOR THE LAST FRONTIER',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.pine,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.15,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) =>
                      _CategoryTile(category: GuidesData.categories[i]),
                  childCount: GuidesData.categories.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final GuideCategory category;

  const _CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    final count =
        GuidesData.guides.where((g) => g.category == category.name).length;

    final hasImage = category.imagePath != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasImage)
              Image.asset(category.imagePath!, fit: BoxFit.cover)
            else
              const Center(
                child: Icon(Icons.image_outlined,
                    color: AppColors.pine, size: 36),
              ),
            if (hasImage)
              // Dark gradient at the bottom so text stays legible
              // on top of the photo.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Color(0xCC000000),
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                    context.go('/guides/category', extra: category.name),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        category.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: hasImage
                                  ? Colors.white
                                  : AppColors.textPrimary,
                              shadows: hasImage
                                  ? const [
                                      Shadow(
                                          blurRadius: 6,
                                          color: Colors.black54),
                                    ]
                                  : null,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$count guide${count == 1 ? '' : 's'}',
                        style: TextStyle(
                          fontSize: 11,
                          color: hasImage
                              ? Colors.white.withValues(alpha: 0.85)
                              : AppColors.textMuted,
                          shadows: hasImage
                              ? const [
                                  Shadow(
                                      blurRadius: 4,
                                      color: Colors.black54),
                                ]
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
