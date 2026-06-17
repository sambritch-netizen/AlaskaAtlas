import 'package:latlong2/latlong.dart';

import 'alaska_cities_data.dart';

const _distance = Distance();

/// Alaska's two-lane, frequently-curving highways average well under
/// interstate speeds — used only for a rough estimate, not turn-by-turn
/// routing.
const double _avgDriveSpeedMph = 45;

/// In-town hops (city center to a nearby attraction) run well below
/// highway speed once parking, traffic, and short trip overhead are
/// factored in.
const double _avgLocalSpeedMph = 20;

enum LegMode { drive, flyOrFerry, local }

/// One point in the full itinerary route — a city stop or a saved
/// activity within that city — used to chain distance/time estimates
/// across the whole trip, not just city to city.
class RouteStop {
  final String label;
  final String emoji;
  final LatLng? location;
  final AlaskaCity city;

  const RouteStop({
    required this.label,
    required this.emoji,
    required this.location,
    required this.city,
  });
}

/// A single leg between two consecutive stops in the itinerary, with a
/// rough distance/time estimate. Distances are great-circle, not road
/// distance, so they run a little short of the real drive — flagged as an
/// estimate everywhere it's shown.
class RouteLeg {
  final String fromLabel;
  final String toLabel;
  final String fromEmoji;
  final String toEmoji;
  final double miles;
  final LegMode mode;

  const RouteLeg({
    required this.fromLabel,
    required this.toLabel,
    required this.fromEmoji,
    required this.toEmoji,
    required this.miles,
    required this.mode,
  });

  Duration get estimatedTime {
    final speed = mode == LegMode.local ? _avgLocalSpeedMph : _avgDriveSpeedMph;
    return Duration(minutes: (miles / speed * 60).round());
  }

  String get formattedDistance =>
      miles < 1 ? '${(miles * 5280).round()} ft' : '${miles.round()} mi';

  String get formattedDuration {
    final d = estimatedTime;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }
}

class TripRouteUtils {
  TripRouteUtils._();

  static double milesBetweenPoints(LatLng a, LatLng b) =>
      _distance.as(LengthUnit.Mile, a, b);

  /// Both ends just need to be on the road system — [AlaskaCity.accessibleByRoad]
  /// already flags island/ferry-only towns correctly, and Alaska's handful
  /// of highways all connect to each other at junctions, so two
  /// road-connected cities are drivable even without a directly shared
  /// highway slug (e.g. Seward to Soldotna via Tern Lake Junction).
  static LegMode interCityMode(AlaskaCity from, AlaskaCity to) {
    return (from.accessibleByRoad && to.accessibleByRoad)
        ? LegMode.drive
        : LegMode.flyOrFerry;
  }

  /// Builds a leg for every consecutive pair of [stops] that both have
  /// known coordinates, skipping stops with no location (e.g. local food
  /// picks aren't pinned) so the chain just bridges over them.
  static List<RouteLeg> legsForStops(List<RouteStop> stops) {
    final legs = <RouteLeg>[];
    RouteStop? prev;
    for (final stop in stops) {
      if (stop.location == null) continue;
      if (prev != null) {
        final mode = prev.city.id == stop.city.id
            ? LegMode.local
            : interCityMode(prev.city, stop.city);
        legs.add(RouteLeg(
          fromLabel: prev.label,
          toLabel: stop.label,
          fromEmoji: prev.emoji,
          toEmoji: stop.emoji,
          miles: milesBetweenPoints(prev.location!, stop.location!),
          mode: mode,
        ));
      }
      prev = stop;
    }
    return legs;
  }
}
