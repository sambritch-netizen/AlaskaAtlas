import 'package:latlong2/latlong.dart';

/// An Anchorage-area fishing lake with a stylized bathymetric profile.
class Lake {
  final String id;
  final String name;
  final String area;
  final double lat;
  final double lng;
  final double surfaceAcres;
  final int maxDepthFt;
  final String blurb;
  final String access;
  final String? accessNote;
  final List<LakeSpecies> species;
  final List<String> tactics;

  /// Normalized shoreline outline (x, y in 0–1) used to draw the depth chart.
  /// Stylized — approximates the real shape, not survey data.
  final List<List<double>> outline;

  /// Normalized location (0–1) of the deepest point inside [outline].
  final List<double> deepPoint;

  const Lake({
    required this.id,
    required this.name,
    required this.area,
    required this.lat,
    required this.lng,
    required this.surfaceAcres,
    required this.maxDepthFt,
    required this.blurb,
    required this.access,
    this.accessNote,
    required this.species,
    required this.tactics,
    required this.outline,
    required this.deepPoint,
  });

  LatLng get location => LatLng(lat, lng);
}

/// A fish species present in a lake, with what actually catches it.
class LakeSpecies {
  final String name;
  final String emoji;
  final bool stocked;
  final List<String> baits;
  final String tip;

  const LakeSpecies({
    required this.name,
    required this.emoji,
    required this.stocked,
    required this.baits,
    required this.tip,
  });
}
