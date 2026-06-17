import 'package:latlong2/latlong.dart';

import 'alaska_cities_data.dart';

const _distance = Distance();

/// Alaska's two-lane, frequently-curving highways average well under
/// interstate speeds — used only for a rough estimate, not turn-by-turn
/// routing.
const double _avgDriveSpeedMph = 45;

enum LegMode { drive, flyOrFerry }

/// A single leg between two consecutive itinerary cities, with a rough
/// distance/time estimate. Distances are great-circle, not road distance,
/// so they run a little short of the real drive — flagged as an estimate
/// everywhere it's shown.
class RouteLeg {
  final AlaskaCity from;
  final AlaskaCity to;
  final double miles;
  final LegMode mode;

  const RouteLeg({
    required this.from,
    required this.to,
    required this.miles,
    required this.mode,
  });

  Duration get estimatedDriveTime =>
      Duration(minutes: (miles / _avgDriveSpeedMph * 60).round());

  String get formattedDistance => '${miles.round()} mi';

  String get formattedDuration {
    final d = estimatedDriveTime;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }
}

class TripRouteUtils {
  TripRouteUtils._();

  static double milesBetween(AlaskaCity a, AlaskaCity b) =>
      _distance.as(LengthUnit.Mile, a.location, b.location);

  static RouteLeg legBetween(AlaskaCity from, AlaskaCity to) {
    final shared =
        from.highwaySlugs.toSet().intersection(to.highwaySlugs.toSet());
    final mode = (from.accessibleByRoad && to.accessibleByRoad && shared.isNotEmpty)
        ? LegMode.drive
        : LegMode.flyOrFerry;
    return RouteLeg(
      from: from,
      to: to,
      miles: milesBetween(from, to),
      mode: mode,
    );
  }

  static List<RouteLeg> legsFor(List<AlaskaCity> orderedCities) {
    final legs = <RouteLeg>[];
    for (var i = 0; i < orderedCities.length - 1; i++) {
      legs.add(legBetween(orderedCities[i], orderedCities[i + 1]));
    }
    return legs;
  }
}
