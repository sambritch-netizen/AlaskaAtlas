import 'package:flutter/material.dart';

/// A selectable map base layer.
class Basemap {
  final String id;
  final String label;
  final IconData icon;
  final String urlTemplate;
  final String attribution;

  /// Highest zoom the tile server actually has imagery for; flutter_map
  /// upscales beyond this so the map stays usable when you zoom in further.
  final int maxNativeZoom;

  /// True when the source is public-domain / freely usable in a commercial
  /// app. Esri World Imagery is gorgeous but its free tier excludes
  /// revenue-generating apps, so it's flagged for launch review.
  final bool commercialSafe;

  const Basemap({
    required this.id,
    required this.label,
    required this.icon,
    required this.urlTemplate,
    required this.attribution,
    required this.maxNativeZoom,
    required this.commercialSafe,
  });
}

/// The map's base-layer catalog, ordered as shown in the layer switcher.
///
/// ArcGIS/USGS tile services use {z}/{y}/{x} order (note y before x).
class Basemaps {
  Basemaps._();

  /// High-res aerial imagery — the "HIGH res" satellite view.
  static const satellite = Basemap(
    id: 'satellite',
    label: 'Satellite',
    icon: Icons.satellite_alt,
    urlTemplate:
        'https://services.arcgisonline.com/arcgis/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    attribution: 'Imagery © Esri, Maxar, Earthstar Geographics',
    maxNativeZoom: 19,
    commercialSafe: false,
  );

  /// USGS aerial imagery with place labels — public domain, commercial-safe,
  /// strong Alaska coverage.
  static const imageryTopo = Basemap(
    id: 'imagery_topo',
    label: 'Imagery',
    icon: Icons.terrain,
    urlTemplate:
        'https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/tile/{z}/{y}/{x}',
    attribution: 'USGS The National Map (public domain)',
    maxNativeZoom: 16,
    commercialSafe: true,
  );

  /// USGS topographic — public domain, the rugged contour look with lake
  /// names, commercial-safe.
  static const topo = Basemap(
    id: 'topo',
    label: 'Topo',
    icon: Icons.landscape,
    urlTemplate:
        'https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/tile/{z}/{y}/{x}',
    attribution: 'USGS The National Map (public domain)',
    maxNativeZoom: 16,
    commercialSafe: true,
  );

  /// Dark atlas style that matches the app's forest-green chrome.
  static const dark = Basemap(
    id: 'dark',
    label: 'Dark',
    icon: Icons.dark_mode,
    urlTemplate: 'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
    attribution: '© OpenStreetMap, © CARTO',
    maxNativeZoom: 20,
    commercialSafe: true,
  );

  static const List<Basemap> all = [satellite, imageryTopo, topo, dark];
}
