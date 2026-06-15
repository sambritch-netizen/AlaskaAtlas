import 'package:flutter/material.dart';

import '../../models/waypoint.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';

/// Compact bottom sheet shown when a themed trip-planning waypoint
/// (fishing, wildlife, camping, hiking, survival, aurora, harvesting, or
/// food) is tapped on the map.
void showWaypointSheet(BuildContext context, Waypoint waypoint, Color color) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      maxChildSize: 0.8,
      minChildSize: 0.25,
      builder: (context, controller) => SingleChildScrollView(
        controller: controller,
        padding: EdgeInsets.fromLTRB(
            24, 0, 24, 24 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHandle(),
            const SizedBox(height: 8),
            Text(
              '${waypoint.category.toUpperCase()} · MILE ${waypoint.mile.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(waypoint.name,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                waypoint.detail,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(waypoint.note, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.place_outlined,
                    size: 14, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(
                  '${waypoint.lat.toStringAsFixed(4)}, ${waypoint.lng.toStringAsFixed(4)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
