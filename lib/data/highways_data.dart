import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

import '../models/highway.dart';

/// The major named Alaska highways, in Milepost order of appearance — the
/// basis for a highway-by-highway walkthrough.
class HighwaysData {
  HighwaysData._();

  static const List<Highway> highways = [
    Highway(
      slug: 'seward-highway',
      name: 'Seward Highway',
      route: 'AK-1 / AK-9',
      color: Color(0xFFE53935),
    ),
    Highway(
      slug: 'glenn-highway',
      name: 'Glenn Highway',
      route: 'AK-1',
      color: Color(0xFFFB8C00),
    ),
    Highway(
      slug: 'parks-highway',
      name: 'George Parks Highway',
      route: 'AK-3',
      color: Color(0xFF8E24AA),
    ),
    Highway(
      slug: 'sterling-highway',
      name: 'Sterling Highway',
      route: 'AK-1',
      color: Color(0xFF43A047),
    ),
    Highway(
      slug: 'richardson-highway',
      name: 'Richardson Highway',
      route: 'AK-2 / AK-4',
      color: Color(0xFF1E88E5),
    ),
    Highway(
      slug: 'alaska-highway',
      name: 'Alaska Highway',
      route: 'AK-2',
      color: Color(0xFFD81B60),
    ),
    Highway(
      slug: 'tok-cutoff',
      name: 'Tok Cutoff',
      route: 'AK-1',
      color: Color(0xFF6D4C41),
    ),
    Highway(
      slug: 'denali-highway',
      name: 'Denali Highway',
      route: 'AK-8',
      color: Color(0xFF00897B),
    ),
  ];
}

/// Loads highway centerline segments from bundled GeoJSON
/// (`assets/highways/highways.geojson`), digitized from OpenStreetMap.
///
/// Coverage reflects what OSM's Nominatim search surfaces per highway —
/// the main named segments, not necessarily every mile of every route.
class HighwayLoader {
  HighwayLoader._();

  static List<HighwaySegment>? _cache;

  static Future<List<HighwaySegment>> load() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/highways/highways.geojson');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final features =
        (json['features'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

    final segments = <HighwaySegment>[];
    for (final f in features) {
      final props = (f['properties'] as Map?) ?? const {};
      final geom = f['geometry'] as Map<String, dynamic>?;
      if (geom == null || geom['type'] != 'LineString') continue;
      final coords = (geom['coordinates'] as List?) ?? const [];

      final colorHex = props['color'] as String?;
      final color = colorHex != null
          ? Color(int.parse(colorHex, radix: 16))
          : const Color(0xFFE53935);

      segments.add(HighwaySegment(
        slug: props['slug'] as String? ?? '',
        name: props['name'] as String? ?? '',
        route: props['route'] as String? ?? '',
        color: color,
        points: [
          for (final pt in coords)
            LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()),
        ],
      ));
    }
    _cache = segments;
    return segments;
  }
}
