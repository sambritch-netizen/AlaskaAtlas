import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../data/alaska_cities_data.dart';
import '../../data/trip_activities_data.dart';
import '../../data/trip_route_utils.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';

const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _fmtDate(DateTime d) => '${_monthNames[d.month - 1]} ${d.day}';

/// A single point in the rendered itinerary: a city stop or a saved
/// activity within it, in visit order.
class _Node {
  final AlaskaCity city;
  final bool isCity;
  final int cityIndex;
  final int nights;
  final DateTime? stayStart;
  final DateTime? stayEnd;
  final TripActivity? activity;

  const _Node.city(this.city, this.cityIndex, this.nights, this.stayStart, this.stayEnd)
      : isCity = true,
        activity = null;

  const _Node.activity(this.city, this.cityIndex, this.activity)
      : isCity = false,
        nights = 0,
        stayStart = null,
        stayEnd = null;

  String get label => isCity ? city.name : activity!.name;
  String get emoji => isCity ? city.emoji : activity!.emoji;
  LatLng? get location => isCity ? city.location : activity!.location;
}

/// The payoff screen: the full day-by-day itinerary built from the
/// arranged cities, nights-per-stop, and saved activities — with a
/// distance/time estimate between every single stop along the way,
/// not just between cities.
class TripItineraryScreen extends ConsumerWidget {
  const TripItineraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(tripPlanProvider);
    final cities = plan.cityIds
        .map((id) => AlaskaCitiesData.byId(id))
        .whereType<AlaskaCity>()
        .toList();

    if (cities.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Itinerary')),
        body: const Center(
          child: Text('Add cities first.',
              style: TextStyle(color: AppColors.textMuted)),
        ),
      );
    }

    final nodes = <_Node>[];
    var currentDay = plan.startDate;
    for (var i = 0; i < cities.length; i++) {
      final city = cities[i];
      final nights = plan.nightsFor(city.id);
      final stayStart = currentDay;
      final stayEnd = stayStart?.add(Duration(days: nights));
      if (currentDay != null) currentDay = currentDay.add(Duration(days: nights));
      nodes.add(_Node.city(city, i, nights, stayStart, stayEnd));

      final activities = plan.savedActivitiesByCity[city.id]
              ?.map(TripActivitiesData.resolve)
              .whereType<TripActivity>()
              .toList() ??
          const [];
      for (final a in activities) {
        nodes.add(_Node.activity(city, i, a));
      }
    }

    final stops = [
      for (final n in nodes)
        RouteStop(label: n.label, emoji: n.emoji, location: n.location, city: n.city),
    ];
    final legs = TripRouteUtils.legsForStops(stops);

    final items = <Widget>[];
    var locatedIndex = -1;
    for (final n in nodes) {
      if (n.location != null) {
        locatedIndex++;
        if (locatedIndex > 0) {
          items.add(_LegRow(leg: legs[locatedIndex - 1]));
        }
      }
      items.add(n.isCity
          ? _CityCard(
              index: n.cityIndex,
              city: n.city,
              nights: n.nights,
              stayStart: n.stayStart,
              stayEnd: n.stayEnd,
            )
          : _ActivityCard(activity: n.activity!));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your Itinerary')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: items,
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

  const _CityCard({
    required this.index,
    required this.city,
    required this.nights,
    required this.stayStart,
    required this.stayEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(city.name, style: Theme.of(context).textTheme.titleLarge),
                if (stayStart != null && stayEnd != null)
                  Text('${_fmtDate(stayStart!)} – ${_fmtDate(stayEnd!)}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text('$nights night${nights == 1 ? "" : "s"}',
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.pine)),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final TripActivity activity;

  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 38),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(activity.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(activity.name,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class _LegRow extends StatelessWidget {
  final RouteLeg leg;

  const _LegRow({required this.leg});

  IconData get _icon {
    switch (leg.mode) {
      case LegMode.drive:
        return Icons.directions_car;
      case LegMode.flyOrFerry:
        return Icons.flight;
      case LegMode.local:
        return Icons.directions_walk;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(width: 2, height: 24, color: AppColors.border),
          const SizedBox(width: 10),
          Icon(_icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(
            '${leg.formattedDistance} · ${leg.formattedDuration}'
            '${leg.mode == LegMode.flyOrFerry ? ' (fly/ferry)' : ''}',
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
