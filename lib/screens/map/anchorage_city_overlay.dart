import 'package:flutter/material.dart';

import '../../data/anchorage_data.dart';
import '../../theme/app_colors.dart';

const List<(AnchoragePOICategory, String, String)> _allCategories = [
  (AnchoragePOICategory.fishing, '🎣', 'Fishing'),
  (AnchoragePOICategory.lake, '🏞', 'Lakes'),
  (AnchoragePOICategory.food, '🍽', 'Food'),
  (AnchoragePOICategory.lodging, '🏨', 'Lodging'),
  (AnchoragePOICategory.gearRental, '🎒', 'Gear'),
  (AnchoragePOICategory.trail, '🥾', 'Trails'),
  (AnchoragePOICategory.scenic, '📸', 'Scenic'),
  (AnchoragePOICategory.wildlife, '🦅', 'Wildlife'),
];

/// Full immersive city-mode UI shell: a slide-down top bar with category
/// filter pills, and a bottom horizontal strip of POI cards. Rendered as
/// an overlay above the map when Anchorage city mode is active.
class AnchorageCityOverlay extends StatefulWidget {
  final VoidCallback onExit;
  final Set<AnchoragePOICategory> activeCategories;
  final ValueChanged<AnchoragePOICategory> onCategoryToggle;
  final List<AnchoragePOI> pois;
  final ValueChanged<AnchoragePOI> onPoiSelected;

  const AnchorageCityOverlay({
    super.key,
    required this.onExit,
    required this.activeCategories,
    required this.onCategoryToggle,
    required this.pois,
    required this.onPoiSelected,
  });

  @override
  State<AnchorageCityOverlay> createState() => _AnchorageCityOverlayState();
}

class _AnchorageCityOverlayState extends State<AnchorageCityOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    )..forward();
    _slideAnim = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutQuart));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  List<AnchoragePOI> get _filteredPois {
    if (widget.activeCategories.isEmpty) return widget.pois;
    return widget.pois.where((p) => widget.activeCategories.contains(p.category)).toList();
  }

  List<AnchoragePOI> get _orderedCards {
    final pois = [..._filteredPois];
    pois.sort((a, b) {
      int rank(AnchoragePOI p) =>
          p.isTurnagainOutfitters ? 0 : (p.isFeatured ? 1 : 2);
      return rank(a).compareTo(rank(b));
    });
    return pois;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _slideAnim,
            child: SafeArea(
              bottom: false,
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: widget.onExit,
                            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                          ),
                          Text('ANCHORAGE',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(letterSpacing: 1.2)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.pine.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.pine),
                            ),
                            child: const Text(
                              'City Mode',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.pine,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        children: _allCategories.map((c) {
                          final (category, emoji, label) = c;
                          final isSelected = widget.activeCategories.contains(category);
                          return GestureDetector(
                            onTap: () => widget.onCategoryToggle(category),
                            child: Container(
                              margin: const EdgeInsets.only(right: 6, bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.pine.withValues(alpha: 0.16)
                                    : AppColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? AppColors.pine : AppColors.border,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Text(
                                '$emoji $label',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                  color: isSelected ? AppColors.pine : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                itemCount: _orderedCards.length,
                itemBuilder: (context, i) => _PoiCard(
                  poi: _orderedCards[i],
                  onTap: () => widget.onPoiSelected(_orderedCards[i]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PoiCard extends StatelessWidget {
  final AnchoragePOI poi;
  final VoidCallback onTap;

  const _PoiCard({required this.poi, required this.onTap});

  String get _emoji => switch (poi.category) {
        AnchoragePOICategory.fishing => '🎣',
        AnchoragePOICategory.lake => '🎣',
        AnchoragePOICategory.food => '🍽',
        AnchoragePOICategory.lodging => '🏨',
        AnchoragePOICategory.gearRental => '🎒',
        AnchoragePOICategory.trail => '🥾',
        AnchoragePOICategory.scenic => '📸',
        AnchoragePOICategory.wildlife => '🦅',
      };

  @override
  Widget build(BuildContext context) {
    final isTo = poi.isTurnagainOutfitters;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isTo ? AppColors.rust.withValues(alpha: 0.14) : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isTo ? AppColors.rust : AppColors.border,
            width: isTo ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(_emoji, style: const TextStyle(fontSize: 18)),
                if (isTo) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.star, size: 14, color: AppColors.rust),
                ],
              ],
            ),
            Text(
              poi.name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              poi.quickFact,
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
