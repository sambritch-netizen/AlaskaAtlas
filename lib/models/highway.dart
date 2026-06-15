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

  static const String junction = 'Junctions';
  static const String fuel = 'Fuel & Lodging';
  static const String camping = 'Camping';
  static const String viewpoint = 'Viewpoints';
  static const String wildlife = 'Wildlife';
  static const String fishing = 'Fishing';
  static const String historic = 'Historic';
  static const String roadNotes = 'Road Notes';

  static const List<String> all = [
    junction,
    fuel,
    camping,
    viewpoint,
    wildlife,
    fishing,
    historic,
    roadNotes,
  ];

  static String emojiFor(String category) => switch (category) {
        junction => '🔀',
        fuel => '⛽',
        camping => '🏕️',
        viewpoint => '⛰️',
        wildlife => '🦌',
        fishing => '🎣',
        historic => '🏺',
        roadNotes => '🚧',
        _ => '📍',
      };
}
