import 'package:latlong2/latlong.dart';

import '../models/highway.dart';
import '../models/hotspot.dart';
import '../models/lake.dart';
import '../models/waypoint.dart';
import 'highways_data.dart';
import 'hotspots_data.dart';
import 'lakes_data.dart';
import 'waypoints_data.dart';

/// One searchable place on the map — a town/hot spot, highway stop,
/// trip-planning waypoint, or fishing lake.
class SearchResult {
  final String name;
  final String subtitle;
  final LatLng location;
  final Hotspot? hotspot;
  final Highway? highway;
  final HighwayStop? highwayStop;
  final Waypoint? waypoint;
  final Lake? lake;

  const SearchResult({
    required this.name,
    required this.subtitle,
    required this.location,
    this.hotspot,
    this.highway,
    this.highwayStop,
    this.waypoint,
    this.lake,
  });
}

/// Flat, searchable index of every named place shown on the map — built
/// once from the bundled hot spot, highway, waypoint, and lake data.
class SearchIndex {
  SearchIndex._();

  static final List<SearchResult> all = [
    for (final h in HotspotsData.hotspots)
      SearchResult(
        name: h.name,
        subtitle: '${h.category} · ${h.region}',
        location: h.location,
        hotspot: h,
      ),
    for (final highway in HighwaysData.highways)
      for (final stop in highway.stops)
        SearchResult(
          name: stop.name,
          subtitle: '${highway.name} · MP ${stop.mile.toStringAsFixed(0)}',
          location: LatLng(stop.lat, stop.lng),
          highway: highway,
          highwayStop: stop,
        ),
    for (final wp in WaypointsData.all)
      SearchResult(
        name: wp.name,
        subtitle: '${wp.category} · MP ${wp.mile.toStringAsFixed(0)}',
        location: LatLng(wp.lat, wp.lng),
        waypoint: wp,
      ),
    for (final lake in LakesData.lakes)
      SearchResult(
        name: lake.name,
        subtitle: 'Lake · ${lake.area}',
        location: lake.location,
        lake: lake,
      ),
  ];

  /// Case-insensitive substring match on place name, ranked so names that
  /// start with the query come before names that merely contain it.
  static List<SearchResult> search(String query, {int limit = 30}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    final starts = <SearchResult>[];
    final contains = <SearchResult>[];
    for (final result in all) {
      final name = result.name.toLowerCase();
      if (name.startsWith(q)) {
        starts.add(result);
      } else if (name.contains(q)) {
        contains.add(result);
      }
    }
    return [...starts, ...contains].take(limit).toList();
  }
}
