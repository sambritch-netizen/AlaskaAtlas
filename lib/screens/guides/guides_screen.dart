import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/guides_data.dart';
import '../../models/guide.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
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
                titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                title: Text('Field Guides',
                    style: Theme.of(context).textTheme.headlineMedium),
                centerTitle: true,
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

    // Outer container provides the visible rounded border; inner ClipRRect
    // clips the photo flush to the inside edge of that border.
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasImage)
              Image.asset(category.imagePath!, fit: BoxFit.cover)
            else
              Container(
                color: AppColors.card,
                child: Center(
                  child: Icon(guidesCategoryIcon(category.name),
                      color: AppColors.pine, size: 36),
                ),
              ),
            if (hasImage)
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Color(0xDD000000),
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                    context.go('/guides/category', extra: category.name),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        category.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'MudTrack',
                          fontSize: 24,
                          letterSpacing: 1.0,
                          color: hasImage ? Colors.white : AppColors.textPrimary,
                          shadows: hasImage
                              ? const [
                                  Shadow(blurRadius: 8, color: Colors.black87),
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$count guide${count == 1 ? '' : 's'}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: hasImage
                              ? Colors.white.withValues(alpha: 0.82)
                              : AppColors.textMuted,
                          shadows: hasImage
                              ? const [
                                  Shadow(blurRadius: 4, color: Colors.black87),
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
