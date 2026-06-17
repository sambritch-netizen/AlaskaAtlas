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

  /// One of [HighwayStopCategories.all] — used to filter pins on the map.
  final String category;

  const HighwayStop({
    required this.mile,
    required this.name,
    required this.emoji,
    required this.lat,
    required this.lng,
    required this.description,
    required this.category,
  });
}

/// Filterable categories for highway mile-marker stops.
class HighwayStopCategories {
  HighwayStopCategories._();

  static const String visitorCenter = 'Visitor Center';
  static const String fuel = 'Fuel';
  static const String restArea = 'Pull Off / Rest Area';
  static const String campground = 'Camp Ground';
  static const String scenic = 'Scenic Feature / Attraction';
  static const String food = 'Food';

  static const List<String> all = [
    visitorCenter,
    fuel,
    restArea,
    campground,
    scenic,
    food,
  ];
}
