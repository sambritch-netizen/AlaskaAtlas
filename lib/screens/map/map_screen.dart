import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../data/bathymetry_loader.dart';
import '../../data/highways_data.dart';
import '../../data/hotspots_data.dart';
import '../../data/lakes_data.dart';
import '../../models/highway.dart';
import '../../models/hotspot.dart';
import '../../models/lake.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import 'basemaps.dart';
import 'hotspot_sheet.dart';
import 'lake_overlay.dart';

/// Statewide hot-spot map with switchable high-res base layers (satellite,
/// USGS imagery & topo, dark atlas), category-filterable pins, and onX-style
/// in-map lake bathymetry.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  Basemap _basemap = Basemaps.satellite;
  String? _category;
  // In-map bathymetry only makes sense once lakes occupy real screen space.
  bool _showContours = false;
  static const _contourZoom = 9.0;

  static const _alaskaCenter = LatLng(62.8, -152.5);
  static const _anchorageCenter = LatLng(61.23, -149.78);
  static const _lakesFilter = 'Lake Charts';
  static const _highwaysFilter = 'Highways';

  // Survey-accurate ADF&G contours, by lake id, once digitized and bundled.
  final Map<String, List<DepthContour>> _realContours = {};

  // Highway centerline segments, loaded from bundled OSM-derived GeoJSON.
  List<HighwaySegment> _highwaySegments = [];

  @override
  void initState() {
    super.initState();
    _loadRealContours();
    _loadHighways();
  }

  Future<void> _loadRealContours() async {
    for (final lake in LakesData.lakes) {
      final contours = await BathymetryLoader.load(lake.id);
      if (contours != null && contours.isNotEmpty && mounted) {
        setState(() => _realContours[lake.id] = contours);
      }
    }
  }

  Future<void> _loadHighways() async {
    final segments = await HighwayLoader.load();
    if (mounted) setState(() => _highwaySegments = segments);
  }

  @override
  Widget build(BuildContext context) {
    final lakesOnly = _category == _lakesFilter;
    final highwaysOnly = _category == _highwaysFilter;
    final spots = (lakesOnly || highwaysOnly)
        ? <Hotspot>[]
        : HotspotsData.byCategory(_category);
    // Lake pins ride along in the unfiltered view and stand alone in
    // Lake Charts mode.
    final showLakes = lakesOnly || _category == null;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _alaskaCenter,
              initialZoom: 4.3,
              minZoom: 3,
              maxZoom: 18,
              backgroundColor: AppColors.background,
              onPositionChanged: (camera, _) {
                final show = camera.zoom >= _contourZoom;
                if (show != _showContours) {
                  setState(() => _showContours = show);
                }
              },
            ),
            children: [
              TileLayer(
                key: ValueKey(_basemap.id),
                urlTemplate: _basemap.urlTemplate,
                userAgentPackageName: 'com.alaskaatlas.alaska_atlas',
                maxNativeZoom: _basemap.maxNativeZoom,
                retinaMode: _basemap.id == 'dark'
                    ? RetinaMode.isHighDensity(context)
                    : false,
              ),
              if (showLakes && _showContours)
                PolygonLayer(
                  polygons: [
                    for (final lake in LakesData.lakes)
                      // Prefer real ADF&G contours; fall back to stylized.
                      if (_realContours[lake.id] case final real?)
                        ...LakeOverlay.realPolygons(lake, real)
                      else
                        ...LakeOverlay.polygonsFor(lake),
                  ],
                ),
              if (highwaysOnly)
                PolylineLayer(
                  polylines: [
                    for (final seg in _highwaySegments)
                      Polyline(
                        points: seg.points,
                        color: seg.color,
                        strokeWidth: 4,
                        borderColor: Colors.black.withValues(alpha: 0.35),
                        borderStrokeWidth: 1.5,
                      ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  for (final spot in spots)
                    Marker(
                      point: spot.location,
                      width: 46,
                      height: 52,
                      alignment: Alignment.topCenter,
                      child: _SpotMarker(
                        spot: spot,
                        onTap: () {
                          _mapController.move(spot.location, 7.5);
                          showHotspotSheet(context, spot);
                        },
                      ),
                    ),
                  if (showLakes)
                    for (final lake in LakesData.lakes)
                      Marker(
                        point: lake.location,
                        width: _showContours ? 150 : 40,
                        height: _showContours ? 46 : 46,
                        alignment: _showContours
                            ? Alignment.center
                            : Alignment.topCenter,
                        child: _showContours
                            ? _LakeLabel(
                                lake: lake,
                                onTap: () =>
                                    context.go('/map/lake', extra: lake),
                              )
                            : _LakeMarker(
                                lake: lake,
                                onTap: () =>
                                    context.go('/map/lake', extra: lake),
                              ),
                      ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    _basemap.attribution,
                    style: const TextStyle(
                        fontSize: 9, color: AppColors.textMuted),
                  ),
                ),
              ),
            ],
          ),

          // ── Top overlay: title + filters ───────────────────────────
          SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Text('Hot Spot Map',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const Spacer(),
                      _LayerButton(
                        basemap: _basemap,
                        onSelected: (b) => setState(() => _basemap = b),
                      ),
                    ],
                  ),
                ),
                FilterChipsRow(
                  options: const [
                    _lakesFilter,
                    _highwaysFilter,
                    ...HotspotsData.categories,
                  ],
                  selected: _category,
                  emojiFor: (c) => switch (c) {
                    _lakesFilter => '💧',
                    _highwaysFilter => '🛣️',
                    _ => HotspotsData.categoryEmoji(c),
                  },
                  onSelected: (c) {
                    setState(() => _category = c);
                    if (c == _lakesFilter) {
                      // The lake charts cluster around Anchorage.
                      _mapController.move(_anchorageCenter, 9.6);
                    } else if (c == _highwaysFilter) {
                      _mapController.move(_alaskaCenter, 4.3);
                    }
                  },
                ),
              ],
            ),
          ),

          // ── Recenter button ────────────────────────────────────────
          Positioned(
            right: 16,
            bottom: 24,
            child: FloatingActionButton.small(
              backgroundColor: AppColors.surfaceElevated,
              foregroundColor: AppColors.pine,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.border),
              ),
              onPressed: () => _mapController.move(_alaskaCenter, 4.3),
              child: const Icon(Icons.zoom_out_map),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpotMarker extends StatelessWidget {
  final Hotspot spot;
  final VoidCallback onTap;

  const _SpotMarker({required this.spot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: spot.featured ? AppColors.pine : AppColors.surfaceElevated,
              shape: BoxShape.circle,
              border: Border.all(
                color: spot.featured ? AppColors.textPrimary : AppColors.pine,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 6),
              ],
            ),
            child: Center(
              child: Text(spot.emoji, style: const TextStyle(fontSize: 16)),
            ),
          ),
          // Pin tail
          Container(
            width: 3,
            height: 9,
            decoration: BoxDecoration(
              color: AppColors.pine,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _LakeMarker extends StatelessWidget {
  final Lake lake;
  final VoidCallback onTap;

  const _LakeMarker({required this.lake, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF13384C),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.info, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 6),
              ],
            ),
            child: const Center(
              child: Text('💧', style: TextStyle(fontSize: 14)),
            ),
          ),
          Container(
            width: 3,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.info,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

/// onX-style label shown once the bathymetry is visible: a small marker dot
/// with the lake name beneath it.
class _LakeLabel extends StatelessWidget {
  final Lake lake;
  final VoidCallback onTap;

  const _LakeLabel({required this.lake, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: const Color(0xFF1B5E83),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black38, blurRadius: 3),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            lake.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: Color(0xFF14537A),
              shadows: [
                Shadow(color: Colors.white, blurRadius: 3),
                Shadow(color: Colors.white, blurRadius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact layer switcher: tap to pop a menu of base layers.
class _LayerButton extends StatelessWidget {
  final Basemap basemap;
  final ValueChanged<Basemap> onSelected;

  const _LayerButton({required this.basemap, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Basemap>(
      tooltip: 'Map layer',
      color: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final b in Basemaps.all)
          PopupMenuItem(
            value: b,
            child: Row(
              children: [
                Icon(b.icon,
                    size: 18,
                    color: b.id == basemap.id
                        ? AppColors.pine
                        : AppColors.textSecondary),
                const SizedBox(width: 10),
                Text(
                  b.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        b.id == basemap.id ? FontWeight.w700 : FontWeight.w500,
                    color: b.id == basemap.id
                        ? AppColors.pine
                        : AppColors.textPrimary,
                  ),
                ),
                if (b.id == basemap.id) ...[
                  const Spacer(),
                  const Icon(Icons.check, size: 16, color: AppColors.pine),
                ],
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(basemap.icon, size: 15, color: AppColors.pine),
            const SizedBox(width: 6),
            Text(
              basemap.label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const Icon(Icons.arrow_drop_down,
                size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
