/// A themed point of interest along a highway, grouped by activity —
/// fishing holes, wildlife viewing spots, campgrounds, trailheads,
/// survival/emergency resources, aurora viewing spots, harvesting/foraging
/// areas, and food stops. Shown as an optional overlay on the map,
/// independent of the core [HighwayStop] pins.
class Waypoint {
  final double mile;
  final String highwaySlug;
  final String name;
  final String category;
  final double lat;
  final double lng;

  /// A short label/value pair shown prominently, e.g. "Target: King Salmon, Rainbow Trout"
  /// or "Difficulty: Moderate · Terrain: Forested loop".
  final String detail;

  /// Additional context shown below [detail].
  final String note;

  const Waypoint({
    required this.mile,
    required this.highwaySlug,
    required this.name,
    required this.category,
    required this.lat,
    required this.lng,
    required this.detail,
    required this.note,
  });
}

/// Categories for [Waypoint] pins — mirrors the Field Guide categories so
/// the map and guides stay in sync.
class WaypointCategories {
  WaypointCategories._();

  static const String fishing = 'Fishing';
  static const String wildlife = 'Wildlife';
  static const String camping = 'Camping';
  static const String hiking = 'Hiking';
  static const String survival = 'Survival';
  static const String aurora = 'Aurora';
  static const String harvesting = 'Harvesting';
  static const String food = 'Food';

  static const List<String> all = [
    fishing,
    wildlife,
    camping,
    hiking,
    survival,
    aurora,
    harvesting,
    food,
  ];
}
