import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/alaska_cities_data.dart';
import '../../data/trip_activities_data.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

/// Filterable "things to do" browser for either a single city, or the
/// route between two consecutive itinerary cities. Tapping an activity
/// saves/unsaves it against the city it's attached to.
class TripActivitiesScreen extends ConsumerStatefulWidget {
  final AlaskaCity city;
  final AlaskaCity? routeTo;

  const TripActivitiesScreen({super.key, required this.city, this.routeTo});

  @override
  ConsumerState<TripActivitiesScreen> createState() => _TripActivitiesScreenState();
}

class _TripActivitiesScreenState extends ConsumerState<TripActivitiesScreen> {
  String? _category;

  bool get _isRoute => widget.routeTo != null;

  List<TripActivity> get _activities => _isRoute
      ? TripActivitiesData.activitiesAlongRoute(widget.city, widget.routeTo!)
      : TripActivitiesData.activitiesNearCity(widget.city);

  @override
  Widget build(BuildContext context) {
    ref.watch(tripPlanProvider);
    final notifier = ref.read(tripPlanProvider.notifier);
    final all = _activities;
    final categories = TripActivitiesData.categoriesFor(all);
    final filtered =
        _category == null ? all : all.where((a) => a.category == _category).toList();
    final title = _isRoute
        ? '${widget.city.name} → ${widget.routeTo!.name}'
        : widget.city.name;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: TopoBackground(
        opacity: 0.3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Text(
                _isRoute
                    ? 'Stops worth a detour between these two cities.'
                    : '${all.length} things to do near ${widget.city.name}.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            if (categories.isNotEmpty)
              FilterChipsRow(
                options: categories,
                selected: _category,
                onSelected: (c) => setState(() => _category = c),
              ),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        _isRoute
                            ? 'No shared highway data for this leg yet.'
                            : 'Nothing curated near here yet.',
                        style: const TextStyle(color: AppColors.textMuted),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final activity = filtered[i];
                        final saved =
                            notifier.isActivitySaved(widget.city.id, activity.ref);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: saved ? AppColors.pine : AppColors.border,
                              width: saved ? 1.5 : 1,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () =>
                                  notifier.toggleActivity(widget.city.id, activity.ref),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Text(activity.emoji,
                                        style: const TextStyle(fontSize: 22)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(activity.name,
                                              style:
                                                  Theme.of(context).textTheme.titleMedium),
                                          const SizedBox(height: 2),
                                          Text(activity.blurb,
                                              style: Theme.of(context).textTheme.bodySmall,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 6),
                                          MetaBadge(
                                              label: activity.sourceLabel,
                                              color: AppColors.textSecondary),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      saved
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: saved ? AppColors.pine : AppColors.textMuted,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
