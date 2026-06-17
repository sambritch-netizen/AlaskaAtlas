import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/alaska_cities_data.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

/// Step 2 of the trip planner: pick which cities the trip will stop in,
/// beyond the fixed arrival/departure points.
class TripCitiesScreen extends ConsumerStatefulWidget {
  const TripCitiesScreen({super.key});

  @override
  ConsumerState<TripCitiesScreen> createState() => _TripCitiesScreenState();
}

class _TripCitiesScreenState extends ConsumerState<TripCitiesScreen> {
  String? _regionFilter;

  @override
  Widget build(BuildContext context) {
    final plan = ref.watch(tripPlanProvider);
    final notifier = ref.read(tripPlanProvider.notifier);
    final regions = {for (final c in AlaskaCitiesData.cities) c.region}.toList()..sort();
    final cities = _regionFilter == null
        ? AlaskaCitiesData.cities
        : AlaskaCitiesData.cities.where((c) => c.region == _regionFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pick Your Cities')),
      body: TopoBackground(
        opacity: 0.3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Text(
                'Tap to add a stop. Your arrival and departure cities are '
                'locked in already.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            FilterChipsRow(
              options: regions,
              selected: _regionFilter,
              onSelected: (r) => setState(() => _regionFilter = r),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                itemCount: cities.length,
                itemBuilder: (context, i) {
                  final city = cities[i];
                  final isPinned = city.id == plan.arrivalCityId ||
                      city.id == plan.departureCityId;
                  final isSelected = plan.cityIds.contains(city.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.pine : AppColors.border,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: isPinned ? null : () => notifier.toggleCity(city.id),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Text(city.emoji, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(city.name,
                                            style: Theme.of(context).textTheme.titleLarge),
                                        if (isPinned) ...[
                                          const SizedBox(width: 6),
                                          MetaBadge(
                                            label: city.id == plan.arrivalCityId
                                                ? 'Arrival'
                                                : 'Departure',
                                            color: AppColors.rust,
                                          ),
                                        ],
                                        if (!city.accessibleByRoad) ...[
                                          const SizedBox(width: 6),
                                          const MetaBadge(
                                            label: 'Fly/Ferry',
                                            color: AppColors.info,
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(city.blurb,
                                        style: Theme.of(context).textTheme.bodySmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              Icon(
                                isSelected || isPinned
                                    ? Icons.check_circle
                                    : Icons.add_circle_outline,
                                color: isSelected || isPinned
                                    ? AppColors.pine
                                    : AppColors.textMuted,
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/trip'),
              child: const Text('Build My Itinerary'),
            ),
          ),
        ),
      ),
    );
  }
}
