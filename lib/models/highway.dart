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
  final List<HighwayStop> stops;

  const Highway({
    required this.slug,
    required this.name,
    required this.route,
    required this.color,
    this.stops = const [],
  });
}

/// A single mile-marker stop along a highway — a campground, viewpoint,
/// lodge, or other point of interest shown on the map.
class HighwayStop {
  final double mile;
  final String name;
  final String emoji;
  final double lat;
  final double lng;
  final String description;

  const HighwayStop({
    required this.mile,
    required this.name,
    required this.emoji,
    required this.lat,
    required this.lng,
    required this.description,
  });
}
