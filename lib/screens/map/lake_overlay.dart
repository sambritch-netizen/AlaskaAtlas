import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../models/lake.dart';

/// Renders each lake's bathymetry directly on the map, onX-style:
/// nested depth-contour polygons in geographic coordinates, scaled so the
/// drawn lake covers its real surface acreage at its real location.
class LakeOverlay {
  LakeOverlay._();

  static const _shore = Color(0xFFA9D7E8);
  static const _deep = Color(0xFF11425E);
  static const _contourLine = Color(0xFF2F7795);

  static final Map<String, List<Polygon>> _cache = {};

  static List<Polygon> polygonsFor(Lake lake) =>
      _cache.putIfAbsent(lake.id, () => _build(lake));

  static List<Polygon> _build(Lake lake) {
    // Centroid of the normalized outline.
    var cx = 0.0, cy = 0.0;
    for (final p in lake.outline) {
      cx += p[0];
      cy += p[1];
    }
    cx /= lake.outline.length;
    cy /= lake.outline.length;

    // Scale: unit-outline area → real surface area in square meters.
    final unitArea = _shoelace(lake.outline);
    final targetM2 = lake.surfaceAcres * 4046.86;
    final metersPerUnit = math.sqrt(targetM2 / unitArea);

    // Meters → degrees at this latitude.
    final mPerDegLat = 111132.0;
    final mPerDegLng = 111320.0 * math.cos(lake.lat * math.pi / 180);

    LatLng toGeo(double x, double y) => LatLng(
          lake.lat - (y - cy) * metersPerUnit / mPerDegLat,
          lake.lng + (x - cx) * metersPerUnit / mPerDegLng,
        );

    final ringCount = (lake.maxDepthFt / 5).round().clamp(3, 6);
    final polygons = <Polygon>[];

    for (var r = 0; r < ringCount; r++) {
      final t = r / ringCount;
      // Shrink the shoreline toward the deep point for each isobath,
      // then smooth so the rings read as natural contour lines.
      final ring = lake.outline
          .map((p) => [
                p[0] + (lake.deepPoint[0] - p[0]) * t * 0.92,
                p[1] + (lake.deepPoint[1] - p[1]) * t * 0.92,
              ])
          .toList(growable: false);
      final smooth = _catmullRomClosed(ring, 5);

      polygons.add(Polygon(
        points: [for (final p in smooth) toGeo(p[0], p[1])],
        color: Color.lerp(_shore, _deep, t)!.withValues(alpha: 0.88),
        borderColor:
            r == 0 ? _contourLine : _contourLine.withValues(alpha: 0.6),
        borderStrokeWidth: r == 0 ? 1.6 : 0.9,
      ));
    }
    return polygons;
  }

  /// Polygon area via the shoelace formula (unit coordinates).
  static double _shoelace(List<List<double>> pts) {
    var sum = 0.0;
    for (var i = 0; i < pts.length; i++) {
      final a = pts[i];
      final b = pts[(i + 1) % pts.length];
      sum += a[0] * b[1] - b[0] * a[1];
    }
    return sum.abs() / 2;
  }

  /// Closed Catmull-Rom interpolation, [steps] samples per segment.
  static List<List<double>> _catmullRomClosed(
      List<List<double>> pts, int steps) {
    final out = <List<double>>[];
    final n = pts.length;
    for (var i = 0; i < n; i++) {
      final p0 = pts[(i - 1 + n) % n];
      final p1 = pts[i];
      final p2 = pts[(i + 1) % n];
      final p3 = pts[(i + 2) % n];
      for (var s = 0; s < steps; s++) {
        final t = s / steps;
        final t2 = t * t;
        final t3 = t2 * t;
        out.add([
          0.5 *
              (2 * p1[0] +
                  (-p0[0] + p2[0]) * t +
                  (2 * p0[0] - 5 * p1[0] + 4 * p2[0] - p3[0]) * t2 +
                  (-p0[0] + 3 * p1[0] - 3 * p2[0] + p3[0]) * t3),
          0.5 *
              (2 * p1[1] +
                  (-p0[1] + p2[1]) * t +
                  (2 * p0[1] - 5 * p1[1] + 4 * p2[1] - p3[1]) * t2 +
                  (-p0[1] + 3 * p1[1] - 3 * p2[1] + p3[1]) * t3),
        ]);
      }
    }
    return out;
  }
}
