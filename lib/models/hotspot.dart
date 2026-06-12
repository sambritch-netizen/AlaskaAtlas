import 'package:latlong2/latlong.dart';

/// A point of interest somewhere in Alaska.
class Hotspot {
  final String id;
  final String name;
  final String category;
  final String region;
  final double lat;
  final double lng;
  final String emoji;
  final String blurb;
  final String description;
  final String bestSeason;
  final double rating;
  final bool featured;
  final List<String> tips;

  const Hotspot({
    required this.id,
    required this.name,
    required this.category,
    required this.region,
    required this.lat,
    required this.lng,
    required this.emoji,
    required this.blurb,
    required this.description,
    required this.bestSeason,
    required this.rating,
    this.featured = false,
    this.tips = const [],
  });

  LatLng get location => LatLng(lat, lng);
}

/// A curated recommendation that isn't a map pin — local food, lodging,
/// experiences worth planning around.
class LocalPick {
  final String name;
  final String town;
  final String kind;
  final String emoji;
  final String blurb;

  const LocalPick({
    required this.name,
    required this.town,
    required this.kind,
    required this.emoji,
    required this.blurb,
  });
}
