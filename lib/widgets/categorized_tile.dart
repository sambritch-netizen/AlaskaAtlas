import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Standard row-tile used across Explore (hotspots), Guides (subcategories,
/// species lists). Locks down the icon-in-rounded-box + title + subtitle +
/// optional trailing pattern so it stops drifting between screens.
class CategorizedTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final IconData? leadingIcon;
  final String? leadingEmoji;
  final Color leadingColor;
  final List<Widget> trailing;
  final VoidCallback onTap;

  const CategorizedTile({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.subtitleStyle,
    this.leadingIcon,
    this.leadingEmoji,
    this.leadingColor = AppColors.pine,
    this.trailing = const [],
  }) : assert(leadingIcon != null || leadingEmoji != null,
            'Provide either leadingIcon or leadingEmoji');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: leadingColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: leadingColor.withValues(alpha: 0.25)),
                  ),
                  child: Center(
                    child: leadingEmoji != null
                        ? Text(leadingEmoji!,
                            style: const TextStyle(fontSize: 22))
                        : Icon(leadingIcon,
                            color: leadingColor, size: 22),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.titleLarge),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: subtitleStyle ??
                              Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                for (final w in trailing) ...[
                  const SizedBox(width: 6),
                  w,
                ],
                const SizedBox(width: 6),
                const Icon(Icons.chevron_right,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
