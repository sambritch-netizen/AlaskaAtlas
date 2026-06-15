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
import 'highway_stop_sheet.dart';
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
  String? _highwayStopCategory;
  // In-map bathymetry only makes sense once lakes occupy real screen space.
  bool _showContours = false;
  static const _contourZoom = 9.0;

  // Independently toggleable map overlays, switched from the left-side
  // layers panel — onX-style.
  bool _showHighways = true;
  bool _showLakeCharts = false;
  bool _showHotspots = true;

  static const _alaskaCenter = LatLng(62.8, -152.5);
  static const _anchorageCenter = LatLng(61.23, -149.78);

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
    final spots = _showHotspots ? HotspotsData.byCategory(_category) : <Hotspot>[];
    final showLakes = _showLakeCharts;

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
              if (_showHighways)
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
              if (_showHighways)
                MarkerLayer(
                  markers: [
                    for (final highway in HighwaysData.highways)
                      for (final stop in highway.stops)
                        if (_highwayStopCategory == null ||
                            stop.category == _highwayStopCategory)
                        Marker(
                          point: LatLng(stop.lat, stop.lng),
                          width: 34,
                          height: 40,
                          alignment: Alignment.topCenter,
                          child: _HighwayStopMarker(
                            stop: stop,
                            color: highway.color,
                            onTap: () =>
                                showHighwayStopSheet(context, highway, stop),
                          ),
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
                if (_showHotspots)
                  FilterChipsRow(
                    options: HotspotsData.categories,
                    selected: _category,
                    emojiFor: HotspotsData.categoryEmoji,
                    onSelected: (c) => setState(() => _category = c),
                  ),
                if (_showHighways)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: FilterChipsRow(
                      options: HighwayStopCategories.all,
                      selected: _highwayStopCategory,
                      emojiFor: HighwayStopCategories.emojiFor,
                      onSelected: (c) =>
                          setState(() => _highwayStopCategory = c),
                    ),
                  ),
              ],
            ),
          ),

          // ── Left-side layers panel ─────────────────────────────────
          Positioned(
            left: 20,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 188),
                child: _LayersPanel(
                  showHighways: _showHighways,
                  showLakeCharts: _showLakeCharts,
                  showHotspots: _showHotspots,
                  onHighwaysChanged: (v) =>
                      setState(() => _showHighways = v),
                  onLakeChartsChanged: (v) {
                    setState(() => _showLakeCharts = v);
                    if (v) _mapController.move(_anchorageCenter, 9.6);
                  },
                  onHotspotsChanged: (v) =>
                      setState(() => _showHotspots = v),
                ),
              ),
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

/// Small circular marker for a highway mile-marker stop (campground,
/// viewpoint, lodge, etc.), colored to match its highway.
class _HighwayStopMarker extends StatelessWidget {
  final HighwayStop stop;
  final Color color;
  final VoidCallback onTap;

  const _HighwayStopMarker(
      {required this.stop, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 4),
              ],
            ),
            child: Center(
              child: Text(stop.emoji, style: const TextStyle(fontSize: 13)),
            ),
          ),
          Container(
            width: 3,
            height: 8,
            decoration: BoxDecoration(
              color: color,
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

/// onX-style left-side overlay panel: tap "Layers" to expand a card of
/// toggle switches that turn map overlays on and off independently.
class _LayersPanel extends StatefulWidget {
  final bool showHighways;
  final bool showLakeCharts;
  final bool showHotspots;
  final ValueChanged<bool> onHighwaysChanged;
  final ValueChanged<bool> onLakeChartsChanged;
  final ValueChanged<bool> onHotspotsChanged;

  const _LayersPanel({
    required this.showHighways,
    required this.showLakeCharts,
    required this.showHotspots,
    required this.onHighwaysChanged,
    required this.onLakeChartsChanged,
    required this.onHotspotsChanged,
  });

  @override
  State<_LayersPanel> createState() => _LayersPanelState();
}

class _LayersPanelState extends State<_LayersPanel> {
  bool _open = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
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
                const Icon(Icons.layers, size: 15, color: AppColors.pine),
                const SizedBox(width: 6),
                const Text(
                  'Layers',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Icon(
                  _open ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_open)
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 184,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LayerToggle(
                  emoji: '🛣️',
                  label: 'Highways',
                  value: widget.showHighways,
                  onChanged: widget.onHighwaysChanged,
                ),
                _LayerToggle(
                  emoji: '💧',
                  label: 'Lake Charts',
                  value: widget.showLakeCharts,
                  onChanged: widget.onLakeChartsChanged,
                ),
                _LayerToggle(
                  emoji: '📍',
                  label: 'Hot Spots',
                  value: widget.showHotspots,
                  onChanged: widget.onHotspotsChanged,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// A single labeled on/off switch row within the layers panel.
class _LayerToggle extends StatelessWidget {
  final String emoji;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _LayerToggle({
    required this.emoji,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.pine,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
