import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

/// One real depth contour (isobath) for a lake: the polygon(s) enclosing all
/// water at least [depthFt] deep.
class DepthContour {
  final double depthFt;
  final List<List<LatLng>> rings; // first ring outer, rest are holes

  const DepthContour({required this.depthFt, required this.rings});
}

/// Loads survey-accurate lake bathymetry from bundled GeoJSON, keyed by lake
/// id. Files live at `assets/bathymetry/{lakeId}.geojson` and are produced by
/// digitizing ADF&G contour maps (used with ADF&G's permission).
///
/// Expected GeoJSON: a FeatureCollection of Polygon/MultiPolygon features in
/// WGS84 lng,lat order, each with a numeric `depth_ft` property giving the
/// contour's depth. See assets/bathymetry/README.md for the full schema.
class BathymetryLoader {
  BathymetryLoader._();

  static final Map<String, List<DepthContour>?> _cache = {};

  /// Returns real contours for [lakeId], or null when none are bundled yet
  /// (callers fall back to the stylized overlay).
  static Future<List<DepthContour>?> load(String lakeId) async {
    if (_cache.containsKey(lakeId)) return _cache[lakeId];
    List<DepthContour>? result;
    try {
      final raw =
          await rootBundle.loadString('assets/bathymetry/$lakeId.geojson');
      result = _parse(raw);
    } catch (_) {
      result = null; // not digitized yet
    }
    _cache[lakeId] = result;
    return result;
  }

  static List<DepthContour> _parse(String raw) {
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final features =
        (json['features'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final contours = <DepthContour>[];

    for (final f in features) {
      final props = (f['properties'] as Map?) ?? const {};
      final depth = (props['depth_ft'] as num?)?.toDouble() ?? 0;
      final geom = f['geometry'] as Map<String, dynamic>?;
      if (geom == null) continue;

      final coords = geom['coordinates'] as List?;
      if (coords == null) continue;
      // Normalize Polygon vs MultiPolygon into a list of polygons.
      final polygons =
          geom['type'] == 'MultiPolygon' ? coords : <dynamic>[coords];

      for (final poly in polygons) {
        final rings = <List<LatLng>>[];
        for (final ring in poly as List) {
          rings.add([
            for (final pt in ring as List)
              LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()),
          ]);
        }
        if (rings.isNotEmpty) {
          contours.add(DepthContour(depthFt: depth, rings: rings));
        }
      }
    }

    // Shallow → deep so deeper bands paint on top of shallower ones.
    contours.sort((a, b) => a.depthFt.compareTo(b.depthFt));
    return contours;
  }
}
