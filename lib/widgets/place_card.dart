import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import '../core/constants/app_colors.dart';
import '../features/trips/trips_provider.dart';

// Horizontal featured card
class PlaceFeaturedCard extends ConsumerWidget {
  final Place place;
  final VoidCallback? onTap;

  const PlaceFeaturedCard({
    super.key,
    required this.place,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(isFavoriteProvider(place.id));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    place.images.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: place.images.first,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(color: AppColors.surfaceElevated),
                            errorWidget: (_, __, ___) => _imageFallback(place.category),
                          )
                        : _imageFallback(place.category),
                    // Gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Difficulty badge
                    if (place.difficulty != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: _DifficultyBadge(difficulty: place.difficulty!),
                      ),
                    // Favorite button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => ref.read(favoritesProvider.notifier).toggle(place),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? AppColors.danger : Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 11, color: AppColors.textMuted),
                        const SizedBox(width: 3),
                        Text(
                          place.bestSeason,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    if (place.rating != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 13, color: AppColors.warning),
                          const SizedBox(width: 3),
                          Text(
                            '${place.rating!.toStringAsFixed(1)} (${place.reviewCount})',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageFallback(String category) {
    return Container(
      color: AppColors.surfaceElevated,
      child: Center(
        child: Text(
          MockDataIcon.forCategory(category),
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

// Vertical nearby/list card
class PlaceListCard extends ConsumerWidget {
  final Place place;
  final VoidCallback? onTap;

  const PlaceListCard({
    super.key,
    required this.place,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(isFavoriteProvider(place.id));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: SizedBox(
                width: 90,
                height: 90,
                child: place.images.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: place.images.first,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: AppColors.surfaceElevated),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.surfaceElevated,
                          child: Center(
                            child: Text(
                              MockDataIcon.forCategory(place.category),
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                      )
                    : Container(color: AppColors.surfaceElevated),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${place.category} · ${place.bestSeason}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (place.distanceMiles != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        '${place.distanceMiles!.toStringAsFixed(0)} mi away',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: place.tags
                          .take(2)
                          .map((t) => _TagPill(label: t))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Favorite
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => ref.read(favoritesProvider.notifier).toggle(place),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? AppColors.danger : AppColors.textMuted,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final String difficulty;
  const _DifficultyBadge({required this.difficulty});

  Color get _color => switch (difficulty) {
        'Easy' => AppColors.success,
        'Moderate' => AppColors.warning,
        'Hard' => AppColors.danger,
        _ => AppColors.textMuted,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  final String label;
  const _TagPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
      ),
    );
  }
}

// Utility — avoids importing mock_data in models
class MockDataIcon {
  static String forCategory(String category) => switch (category) {
        'Hikes' => '🥾',
        'Fishing' => '🎣',
        'Camping' => '⛺',
        'Food' => '🍽️',
        'Scenic' => '🏔️',
        'Wildlife' => '🦅',
        'Hidden Gems' => '💎',
        _ => '📍',
      };
}
