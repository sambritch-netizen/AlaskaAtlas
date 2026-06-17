import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/alaska_cities_data.dart';
import '../../data/trip_activities_data.dart';
import '../../data/trip_route_utils.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';

/// The payoff screen: the full day-by-day itinerary built from the
/// arranged cities, nights-per-stop, and saved activities — with a
/// distance/time estimate for every leg in between.
class TripItineraryScreen extends ConsumerWidget {
  const TripItineraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(tripPlanProvider);
    final cities = plan.cityIds
        .map((id) => AlaskaCitiesData.byId(id))
        .whereType<AlaskaCity>()
        .toList();
    final legs = TripRouteUtils.legsFor(cities);

    var currentDay = plan.startDate;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Itinerary')),
      body: cities.isEmpty
          ? const Center(
              child: Text('Add cities first.',
                  style: TextStyle(color: AppColors.textMuted)),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              itemCount: cities.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  final leg = legs[index ~/ 2];
                  return _LegCard(leg: leg);
                }

                final i = index ~/ 2;
                final city = cities[i];
                final nights = plan.nightsFor(city.id);
                final stayStart = currentDay;
                final stayEnd = stayStart?.add(Duration(days: nights));
                if (currentDay != null) {
                  currentDay = currentDay!.add(Duration(days: nights));
                }
                final activities = plan.savedActivitiesByCity[city.id]
                        ?.map(TripActivitiesData.resolve)
                        .whereType<TripActivity>()
                        .toList() ??
                    const [];

                return _CityCard(
                  index: i,
                  city: city,
                  nights: nights,
                  stayStart: stayStart,
                  stayEnd: stayEnd,
                  activities: activities,
                );
              },
            ),
    );
  }
}

class _CityCard extends StatelessWidget {
  final int index;
  final AlaskaCity city;
  final int nights;
  final DateTime? stayStart;
  final DateTime? stayEnd;
  final List<TripActivity> activities;

  const _CityCard({
    required this.index,
    required this.city,
    required this.nights,
    required this.stayStart,
    required this.stayEnd,
    required this.activities,
  });

  String _fmt(DateTime d) => '${_month(d.month)} ${d.day}';

  String _month(int m) => const [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ][m - 1];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.pine.withValues(alpha: 0.18),
                  border: Border.all(color: AppColors.pine),
                ),
                child: Center(
                  child: Text('${index + 1}',
                      style: const TextStyle(
                          color: AppColors.pine,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ),
              ),
              const SizedBox(width: 10),
              Text(city.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(city.name,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Text('$nights night${nights == 1 ? "" : "s"}',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.pine)),
            ],
          ),
          if (stayStart != null && stayEnd != null) ...[
            const SizedBox(height: 6),
            Text('${_fmt(stayStart!)} – ${_fmt(stayEnd!)}',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
          if (activities.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final a in activities)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Text(a.emoji, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(a.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _LegCard extends StatelessWidget {
  final RouteLeg leg;

  const _LegCard({required this.leg});

  @override
  Widget build(BuildContext context) {
    final isDrive = leg.mode == LegMode.drive;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(width: 2, height: 28, color: AppColors.border),
          const SizedBox(width: 10),
          Icon(isDrive ? Icons.directions_car : Icons.flight,
              size: 16, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(
            '${leg.formattedDistance} · ${leg.formattedDuration}'
            '${isDrive ? '' : ' (fly/ferry)'}',
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
