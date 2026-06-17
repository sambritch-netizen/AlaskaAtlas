import 'package:latlong2/latlong.dart';

import 'alaska_cities_data.dart';
import 'highways_data.dart';
import 'hotspots_data.dart';
import 'waypoints_data.dart';

/// A single thing-to-do candidate for the trip planner, normalized from
/// whichever underlying data source it came from (hot spots, trip
/// waypoints, local food picks, or highway mile-marker stops).
class TripActivity {
  final String ref;
  final String name;
  final String emoji;
  final String category;
  final String blurb;
  final String sourceLabel;
  final LatLng? location;

  const TripActivity({
    required this.ref,
    required this.name,
    required this.emoji,
    required this.category,
    required this.blurb,
    required this.sourceLabel,
    this.location,
  });
}

const _distance = Distance();

class TripActivitiesData {
  TripActivitiesData._();

  static List<TripActivity> get _allHotspots => [
        for (final h in HotspotsData.hotspots)
          TripActivity(
            ref: 'hotspot:${h.id}',
            name: h.name,
            emoji: h.emoji,
            category: h.category,
            blurb: h.blurb,
            sourceLabel: 'Hot Spot',
            location: h.location,
          ),
      ];

  static List<TripActivity> get _allWaypoints => [
        for (var i = 0; i < WaypointsData.all.length; i++)
          TripActivity(
            ref: 'waypoint:$i',
            name: WaypointsData.all[i].name,
            emoji: '📍',
            category: WaypointsData.all[i].category,
            blurb: WaypointsData.all[i].detail,
            sourceLabel: 'Waypoint',
            location: LatLng(WaypointsData.all[i].lat, WaypointsData.all[i].lng),
          ),
      ];

  static List<TripActivity> get _allLocalPicks => [
        for (var i = 0; i < HotspotsData.localPicks.length; i++)
          TripActivity(
            ref: 'localpick:$i',
            name: HotspotsData.localPicks[i].name,
            emoji: HotspotsData.localPicks[i].emoji,
            category: 'Food',
            blurb: HotspotsData.localPicks[i].blurb,
            sourceLabel: HotspotsData.localPicks[i].town,
          ),
      ];

  /// Things to do within [radiusKm] of [city] — hot spots and waypoints by
  /// distance, local food picks by matching town name.
  static List<TripActivity> activitiesNearCity(AlaskaCity city,
      {double radiusKm = 60}) {
    final near = <TripActivity>[
      for (final a in _allHotspots)
        if (a.location != null &&
            _distance.as(LengthUnit.Kilometer, city.location, a.location!) <=
                radiusKm)
          a,
      for (final a in _allWaypoints)
        if (a.location != null &&
            _distance.as(LengthUnit.Kilometer, city.location, a.location!) <=
                radiusKm)
          a,
      for (final a in _allLocalPicks)
        if (a.sourceLabel.toLowerCase().contains(
                city.name.split(' ').first.toLowerCase()) ||
            city.name.toLowerCase().contains(a.sourceLabel.toLowerCase()))
          a,
    ];
    return near;
  }

  static List<String> categoriesFor(List<TripActivity> activities) {
    final set = <String>{};
    for (final a in activities) {
      set.add(a.category);
    }
    final list = set.toList()..sort();
    return list;
  }

  /// Highway mile-marker stops and themed waypoints found on a highway
  /// shared by both [from] and [to] — a rough "what's along the way"
  /// suggestion for a road-trip leg between two cities.
  static List<TripActivity> activitiesAlongRoute(
      AlaskaCity from, AlaskaCity to) {
    final sharedSlugs =
        from.highwaySlugs.toSet().intersection(to.highwaySlugs.toSet());
    if (sharedSlugs.isEmpty) return [];

    final stops = <TripActivity>[];
    for (final highway in HighwaysData.highways) {
      if (!sharedSlugs.contains(highway.slug)) continue;
      for (final stop in highway.stops) {
        stops.add(TripActivity(
          ref: 'highwaystop:${highway.slug}:${stop.mile}:${stop.name}',
          name: stop.name,
          emoji: stop.emoji,
          category: stop.category,
          blurb: stop.description,
          sourceLabel: '${highway.name} · Mile ${stop.mile}',
          location: LatLng(stop.lat, stop.lng),
        ));
      }
    }
    for (var i = 0; i < WaypointsData.all.length; i++) {
      final wp = WaypointsData.all[i];
      if (!sharedSlugs.contains(wp.highwaySlug)) continue;
      stops.add(TripActivity(
        ref: 'waypoint:$i',
        name: wp.name,
        emoji: '📍',
        category: wp.category,
        blurb: wp.detail,
        sourceLabel: 'Mile ${wp.mile}',
        location: LatLng(wp.lat, wp.lng),
      ));
    }
    stops.sort((a, b) => a.name.compareTo(b.name));
    return stops;
  }

  /// Resolve a saved activity ref back to a [TripActivity], scanning every
  /// source. Used to render the saved-activity list in the itinerary view.
  static TripActivity? resolve(String ref) {
    for (final a in [..._allHotspots, ..._allWaypoints, ..._allLocalPicks]) {
      if (a.ref == ref) return a;
    }
    if (ref.startsWith('highwaystop:')) {
      final parts = ref.split(':');
      if (parts.length >= 4) {
        final slug = parts[1];
        final name = parts.sublist(3).join(':');
        for (final highway in HighwaysData.highways) {
          if (highway.slug != slug) continue;
          for (final stop in highway.stops) {
            if (stop.name == name) {
              return TripActivity(
                ref: ref,
                name: stop.name,
                emoji: stop.emoji,
                category: stop.category,
                blurb: stop.description,
                sourceLabel: '${highway.name} · Mile ${stop.mile}',
                location: LatLng(stop.lat, stop.lng),
              );
            }
          }
        }
      }
    }
    return null;
  }
}
