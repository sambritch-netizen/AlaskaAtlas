import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Maps a guide or species category/subcategory name to a real icon.
IconData guidesCategoryIcon(String name) => switch (name) {
      'Fishing' || 'Fish Species' => Icons.phishing,
      'Wildlife' || 'Birds' || 'Land Animals' => Icons.pets,
      'Camping' => Icons.forest,
      'Hiking' => Icons.hiking,
      'Harvesting' || 'Berries' || 'Mushrooms & Foraging' || 'Other Wild Edibles' =>
        Icons.eco,
      'Survival' => Icons.explore,
      'Aurora' => Icons.nights_stay,
      'Food' => Icons.restaurant,
      _ => Icons.menu_book,
    };

/// Section heading used across screens.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child:
                  Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
            ),
        ],
      ),
    );
  }
}

/// Small bordered badge for difficulty, read time, price, etc.
class MetaBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const MetaBadge({super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

/// Horizontally scrolling filter chips with an "All" entry.
class FilterChipsRow extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onSelected;
  final String Function(String)? emojiFor;

  const FilterChipsRow({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.emojiFor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _chip(context, label: 'All', isSelected: selected == null, onTap: () => onSelected(null)),
          ...options.map((opt) {
            final emoji = emojiFor?.call(opt);
            return _chip(
              context,
              label: emoji == null ? opt : '$emoji $opt',
              isSelected: selected == opt,
              onTap: () => onSelected(selected == opt ? null : opt),
            );
          }),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context,
      {required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.pine.withValues(alpha: 0.16)
              : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.pine : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.pine : AppColors.textSecondary,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

/// Standard drag handle for bottom sheets.
class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
