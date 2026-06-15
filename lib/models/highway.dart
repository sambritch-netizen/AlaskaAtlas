import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// One mapped segment of a highway's centerline, in real WGS84 coordinates
/// sourced from OpenStreetMap.
class HighwaySegment {
  final String slug;
  final String name;
  final String route;
  final Color color;
  final List<LatLng> points;

  const HighwaySegment({
    required this.slug,
    required this.name,
    required this.route,
    required this.color,
    required this.points,
  });
}

/// A named Alaska highway, the basis for a Milepost-style walkthrough.
class Highway {
  final String slug;
  final String name;
  final String route;
  final Color color;

  const Highway({
    required this.slug,
    required this.name,
    required this.route,
    required this.color,
  });
}
