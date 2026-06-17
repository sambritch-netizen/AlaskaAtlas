import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/alaska_cities_data.dart';
import '../../data/trip_activities_data.dart';
import '../../models/trip_plan.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _fmtDate(DateTime d) => '${_monthNames[d.month - 1]} ${d.day}';

/// The Trip tab: an empty-state CTA into the setup wizard, or the live
/// itinerary once a trip has dates and at least an arrival/departure city.
class TripPlannerScreen extends ConsumerWidget {
  const TripPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(tripPlanProvider);
    final hasTrip = plan.hasDates && plan.arrivalCityId != null;

    return Scaffold(
      body: TopoBackground(
        opacity: 0.35,
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
                    Text('Trip Planner',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 21)),
                    const Text(
                      'YOUR ALASKA ITINERARY, BUILT YOUR WAY',
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
              actions: [
                if (hasTrip)
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Start Over',
                    onPressed: () => _confirmReset(context, ref),
                  ),
              ],
            ),
            if (!hasTrip)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(onStart: () => context.go('/trip/setup')),
              )
            else
              ..._buildItinerary(context, ref, plan),
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Start a new trip?'),
        content: const Text('This clears your dates, cities, and saved activities.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(tripPlanProvider.notifier).reset();
              Navigator.of(context).pop();
            },
            child: const Text('Start Over'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItinerary(BuildContext context, WidgetRef ref, TripPlan plan) {
    final notifier = ref.read(tripPlanProvider.notifier);
    final cities = plan.cityIds
        .map((id) => AlaskaCitiesData.byId(id))
        .whereType<AlaskaCity>()
        .toList();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: _TripSummaryCard(plan: plan, cityCount: cities.length),
        ),
      ),
      const SliverToBoxAdapter(
        child: SectionHeader(
          title: 'Your Route',
          subtitle: 'Drag to reorder · tap a city for things to do',
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        sliver: SliverReorderableList(
          itemCount: cities.length,
          onReorder: notifier.reorderCities,
          itemBuilder: (context, i) {
            final city = cities[i];
            final isEndpoint =
                city.id == plan.arrivalCityId || city.id == plan.departureCityId;
            final savedCount = plan.savedActivitiesByCity[city.id]?.length ?? 0;
            return ReorderableDelayedDragStartListener(
              key: ValueKey(city.id),
              index: i,
              child: Column(
                children: [
                  _CityRow(
                    city: city,
                    isEndpoint: isEndpoint,
                    savedCount: savedCount,
                    onTap: () => context.go('/trip/city', extra: city),
                    onRemove: isEndpoint ? null : () => notifier.toggleCity(city.id),
                  ),
                  if (i < cities.length - 1)
                    _RouteConnector(from: city, to: cities[i + 1]),
                ],
              ),
            );
          },
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: OutlinedButton.icon(
            onPressed: () => context.go('/trip/cities'),
            icon: const Icon(Icons.add_location_alt_outlined),
            label: const Text('Add a City'),
          ),
        ),
      ),
    ];
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onStart;

  const _EmptyState({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🗺️', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text('Plan Your Alaska Trip',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Pick your dates, your arrival and departure cities, then the '
              'stops in between — we\'ll surface things to do in each city '
              'and along the way.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStart,
                child: const Text('Start Planning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripSummaryCard extends StatelessWidget {
  final TripPlan plan;
  final int cityCount;

  const _TripSummaryCard({required this.plan, required this.cityCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.pineDeep.withValues(alpha: 0.85),
            AppColors.card,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_fmtDate(plan.startDate!)} – ${_fmtDate(plan.endDate!)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '${plan.dayCount} days · $cityCount stops · '
                  '${plan.totalSavedActivities} saved',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.flight_takeoff, color: AppColors.pine, size: 28),
        ],
      ),
    );
  }
}

class _CityRow extends StatelessWidget {
  final AlaskaCity city;
  final bool isEndpoint;
  final int savedCount;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const _CityRow({
    required this.city,
    required this.isEndpoint,
    required this.savedCount,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
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
                      Text(city.name, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 2),
                      Text(
                        savedCount > 0
                            ? '$savedCount saved things to do'
                            : 'Tap to find things to do',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
                if (isEndpoint)
                  MetaBadge(
                    label: city.hasAirport ? 'Hub' : 'Endpoint',
                    color: AppColors.rust,
                  ),
                if (onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
                    onPressed: onRemove,
                  ),
                const Icon(Icons.drag_handle, color: AppColors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RouteConnector extends StatelessWidget {
  final AlaskaCity from;
  final AlaskaCity to;

  const _RouteConnector({required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    final hasRoute = TripActivitiesData.activitiesAlongRoute(from, to).isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 22),
          Container(width: 2, height: 24, color: AppColors.border),
          const SizedBox(width: 12),
          Expanded(
            child: hasRoute
                ? OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                    ),
                    onPressed: () => context.go('/trip/route', extra: [from, to]),
                    icon: const Icon(Icons.alt_route, size: 16),
                    label: const Text('Stops along the way', style: TextStyle(fontSize: 12)),
                  )
                : Text(
                    from.accessibleByRoad && to.accessibleByRoad
                        ? 'No shared highway'
                        : 'Fly or ferry between these',
                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
          ),
        ],
      ),
    );
  }
}
