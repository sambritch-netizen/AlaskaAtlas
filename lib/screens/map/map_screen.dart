import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../data/bathymetry_loader.dart';
import '../../data/highways_data.dart';
import '../../data/lakes_data.dart';
import '../../data/waypoints_data.dart';
import '../../models/highway.dart';
import '../../models/lake.dart';
import '../../models/waypoint.dart';
import '../../theme/app_colors.dart';
import 'basemaps.dart';
import 'highway_stop_sheet.dart';
import 'lake_overlay.dart';
import 'waypoint_sheet.dart';

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

  // In-map bathymetry only makes sense once lakes occupy real screen space.
  bool _showContours = false;
  static const _contourZoom = 9.0;

  // Mile-marker pins are spaced every 10 real miles, so they overlap into an
  // unreadable stack until zoomed in far enough for that spacing to spread
  // out on screen.
  bool _zoomedForMileMarkers = false;
  static const _mileMarkerZoom = 8.0;

  // Independently toggleable map overlays, switched from the "Map Layers"
  // menu — onX-style category drill-down.
  bool _showHighways = true;
  bool _showLakeCharts = false;
  bool _showMileMarkers = false;

  // Official milepost numbering doesn't always start at zero where the
  // bundled route geometry begins (e.g. the Parks Highway geometry starts
  // at its junction with the Glenn, which is official MP 35). These offsets
  // are added to the distance traveled along each segment's geometry to
  // recover the real-world milepost.
  static const Map<String, int> _mileMarkerOffsets = {
    'parks-highway': 35,
    'sterling-highway': 37,
  };

  // Per-category visibility within the Highways group — off by default,
  // toggled individually from the Map Layers menu.
  final Set<String> _activeHighwayCategories = {};

  // Trip-planning waypoint pins (fishing, wildlife, camping, etc.) — off by
  // default, toggled individually from the Map Layers menu.
  final Set<String> _activeWaypointCategories = {};

  // Whether the left-side "Map Layers" panel is open.
  bool _layersPanelOpen = false;

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

  /// Builds "MP" pins at every 10-mile interval along each highway's real
  /// route geometry, walking the cumulative distance between points and
  /// applying the per-highway official-milepost offset.
  List<Marker> _mileMarkerPins() {
    const distance = Distance(roundResult: false);
    final markers = <Marker>[];

    for (final seg in _highwaySegments) {
      final points = seg.points;
      if (points.length < 2) continue;
      final offset = _mileMarkerOffsets[seg.slug] ?? 0;

      final cumulative = List<double>.filled(points.length, 0);
      for (var i = 1; i < points.length; i++) {
        cumulative[i] = cumulative[i - 1] +
            distance.as(LengthUnit.Mile, points[i - 1], points[i]);
      }
      final total = cumulative.last;

      final startMile = ((offset + 9) ~/ 10) * 10;
      for (var mile = startMile; mile <= offset + total; mile += 10) {
        // Skip MP 0: it sits at the highway's terminus and a lone "0" pin
        // adds clutter without conveying useful information.
        if (mile == 0) continue;
        final target = (mile - offset).toDouble();
        if (target < 0) continue;

        var idx = 0;
        while (idx < cumulative.length - 2 && cumulative[idx + 1] < target) {
          idx++;
        }
        final segStart = cumulative[idx];
        final segEnd = cumulative[idx + 1];
        final t =
            segEnd == segStart ? 0.0 : (target - segStart) / (segEnd - segStart);
        final a = points[idx];
        final b = points[idx + 1];
        final point = LatLng(
          a.latitude + (b.latitude - a.latitude) * t,
          a.longitude + (b.longitude - a.longitude) * t,
        );

        markers.add(
          Marker(
            point: point,
            width: 56,
            height: 24,
            alignment: Alignment.center,
            child: _MileMarkerPin(mile: mile, color: seg.color),
          ),
        );
      }
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
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
                final zoomedIn = camera.zoom >= _mileMarkerZoom;
                if (zoomedIn != _zoomedForMileMarkers) {
                  setState(() => _zoomedForMileMarkers = zoomedIn);
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
              if (_activeHighwayCategories.isNotEmpty)
                MarkerLayer(
                  markers: [
                    for (final highway in HighwaysData.highways)
                      for (final stop in highway.stops)
                        if (_activeHighwayCategories.contains(stop.category))
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
              if (_showHighways && _showMileMarkers && _zoomedForMileMarkers)
                MarkerLayer(markers: _mileMarkerPins()),
              if (_activeWaypointCategories.isNotEmpty)
                MarkerLayer(
                  markers: [
                    for (final wp in WaypointsData.all)
                      if (_activeWaypointCategories.contains(wp.category))
                        Marker(
                          point: LatLng(wp.lat, wp.lng),
                          width: 30,
                          height: 36,
                          alignment: Alignment.topCenter,
                          child: _WaypointMarker(
                            waypoint: wp,
                            color: _waypointCategoryColor(wp.category),
                            onTap: () => showWaypointSheet(context, wp,
                                _waypointCategoryColor(wp.category)),
                          ),
                        ),
                  ],
                ),
              MarkerLayer(
                markers: [
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
                      Text('Alaska Atlas',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const Spacer(),
                      _LayerButton(
                        basemap: _basemap,
                        onSelected: (b) => setState(() => _basemap = b),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Left-side "Map Layers" menu button ─────────────────────
          Positioned(
            left: 20,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 132),
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _layersPanelOpen = !_layersPanelOpen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_alt, size: 15, color: AppColors.pine),
                        SizedBox(width: 6),
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.chevron_right,
                            size: 16, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
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

          // ── Backdrop to dismiss the Map Layers panel ───────────────
          if (_layersPanelOpen)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _layersPanelOpen = false),
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),
            ),

          // ── Left-side "Map Layers" panel ───────────────────────────
          AnimatedPositioned(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            top: 0,
            bottom: 0,
            left: _layersPanelOpen ? 0 : -300,
            width: 300,
            child: _MapLayersSheet(
              showHighways: _showHighways,
              showLakeCharts: _showLakeCharts,
              showMileMarkers: _showMileMarkers,
              activeHighwayCategories: _activeHighwayCategories,
              activeWaypointCategories: _activeWaypointCategories,
              onClose: () => setState(() => _layersPanelOpen = false),
              onHighwaysChanged: (v) => setState(() => _showHighways = v),
              onMileMarkersChanged: (v) =>
                  setState(() => _showMileMarkers = v),
              onLakeChartsChanged: (v) {
                setState(() => _showLakeCharts = v);
                if (v) _mapController.move(_anchorageCenter, 9.6);
              },
              onHighwayCategoryChanged: (cat, v) {
                setState(() {
                  if (v) {
                    _activeHighwayCategories.add(cat);
                  } else {
                    _activeHighwayCategories.remove(cat);
                  }
                });
              },
              onWaypointCategoryChanged: (cat, v) {
                setState(() {
                  if (v) {
                    _activeWaypointCategories.add(cat);
                  } else {
                    _activeWaypointCategories.remove(cat);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Small circular pin for a highway mile-marker stop (visitor center, fuel,
/// rest area, campground, scenic feature, or food), colored to match its
/// highway. No emoji — just a small dot.
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
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceElevated, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 4),
              ],
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

/// Small "MP n" pill marking an official milepost along a highway,
/// colored to match the highway's route line.
class _MileMarkerPin extends StatelessWidget {
  final int mile;
  final Color color;

  const _MileMarkerPin({required this.mile, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color, width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 3),
        ],
      ),
      child: Text(
        'MP $mile',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

/// Color for a [Waypoint] pin, by category — mirrors the Field Guide
/// category colors so the map and guides stay visually in sync.
Color _waypointCategoryColor(String category) => switch (category) {
      WaypointCategories.fishing => const Color(0xFF1E88E5),
      WaypointCategories.wildlife => const Color(0xFF8D6E63),
      WaypointCategories.camping => const Color(0xFFFB8C00),
      WaypointCategories.hiking => const Color(0xFF43A047),
      WaypointCategories.survival => const Color(0xFFE53935),
      WaypointCategories.aurora => const Color(0xFF7E57C2),
      WaypointCategories.harvesting => const Color(0xFF5C6BC0),
      WaypointCategories.food => const Color(0xFFE53935),
      _ => AppColors.pine,
    };

/// Menu emoji for each [Waypoint] category — matches the Field Guide icons.
String _waypointCategoryEmoji(String category) => switch (category) {
      WaypointCategories.fishing => '🎣',
      WaypointCategories.wildlife => '🐻',
      WaypointCategories.camping => '⛺',
      WaypointCategories.hiking => '🥾',
      WaypointCategories.survival => '🧭',
      WaypointCategories.aurora => '🌌',
      WaypointCategories.harvesting => '🫐',
      WaypointCategories.food => '🍲',
      _ => '📍',
    };

/// Small pin for a themed trip-planning waypoint, colored by category and
/// labeled with its activity emoji.
class _WaypointMarker extends StatelessWidget {
  final Waypoint waypoint;
  final Color color;
  final VoidCallback onTap;

  const _WaypointMarker(
      {required this.waypoint, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceElevated, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 4),
              ],
            ),
            child: Center(
              child: Text(_waypointCategoryEmoji(waypoint.category),
                  style: const TextStyle(fontSize: 13)),
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

/// onX-style "Map Layers" menu: a top-level list of layer categories, each
/// showing how many of its sub-layers are on, drilling down into a detail
/// page of individual toggle switches.
class _MapLayersSheet extends StatefulWidget {
  final bool showHighways;
  final bool showLakeCharts;
  final bool showMileMarkers;
  final Set<String> activeHighwayCategories;
  final Set<String> activeWaypointCategories;
  final ValueChanged<bool> onHighwaysChanged;
  final ValueChanged<bool> onLakeChartsChanged;
  final ValueChanged<bool> onMileMarkersChanged;
  final void Function(String category, bool value) onHighwayCategoryChanged;
  final void Function(String category, bool value) onWaypointCategoryChanged;
  final VoidCallback onClose;

  const _MapLayersSheet({
    required this.showHighways,
    required this.showLakeCharts,
    required this.showMileMarkers,
    required this.activeHighwayCategories,
    required this.activeWaypointCategories,
    required this.onHighwaysChanged,
    required this.onLakeChartsChanged,
    required this.onMileMarkersChanged,
    required this.onHighwayCategoryChanged,
    required this.onWaypointCategoryChanged,
    required this.onClose,
  });

  @override
  State<_MapLayersSheet> createState() => _MapLayersSheetState();
}

/// The Map Filters categories shown in the side panel — fishing, wildlife,
/// camping, hiking, harvesting, and food.
const List<String> _mapFilterCategories = [
  WaypointCategories.fishing,
  WaypointCategories.wildlife,
  WaypointCategories.camping,
  WaypointCategories.hiking,
  WaypointCategories.harvesting,
  WaypointCategories.food,
];

enum _LayersDetailPage { mapFilters }

class _MapLayersSheetState extends State<_MapLayersSheet> {
  _LayersDetailPage? _detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: AppColors.border),
          right: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 12),
        ],
      ),
      child: SafeArea(
        child: _detail == null
            ? _buildList(context)
            : _buildDetail(context, _detail!),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final filtersOn = widget.activeWaypointCategories.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      children: [
        Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    )),
              ),
            ),
            IconButton(
              onPressed: widget.onClose,
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🛣️',
            label: 'Road System',
            value: widget.showHighways,
            onChanged: widget.onHighwaysChanged,
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '💧',
            label: 'Lake Charts',
            value: widget.showLakeCharts,
            onChanged: widget.onLakeChartsChanged,
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '⛽',
            label: 'Fuel',
            value: widget.activeHighwayCategories
                .contains(HighwayStopCategories.fuel),
            onChanged: (v) =>
                widget.onHighwayCategoryChanged(HighwayStopCategories.fuel, v),
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🅿️',
            label: 'Rest Stops',
            value: widget.activeHighwayCategories
                .contains(HighwayStopCategories.restArea),
            onChanged: (v) => widget.onHighwayCategoryChanged(
                HighwayStopCategories.restArea, v),
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🔢',
            label: 'Mile Markers',
            value: widget.showMileMarkers,
            onChanged: widget.onMileMarkersChanged,
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🏞️',
            label: 'Scenic Stops',
            value: widget.activeHighwayCategories
                .contains(HighwayStopCategories.scenic),
            onChanged: (v) => widget.onHighwayCategoryChanged(
                HighwayStopCategories.scenic, v),
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🏕️',
            label: 'Campgrounds',
            value: widget.activeHighwayCategories
                .contains(HighwayStopCategories.campground),
            onChanged: (v) => widget.onHighwayCategoryChanged(
                HighwayStopCategories.campground, v),
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🍽️',
            label: 'Food & Lodging',
            value: widget.activeHighwayCategories
                .contains(HighwayStopCategories.food),
            onChanged: (v) => widget.onHighwayCategoryChanged(
                HighwayStopCategories.food, v),
          ),
        ),
        _ToggleRow(
          data: _ToggleRowData(
            emoji: '🛈',
            label: 'Visitor Centers',
            value: widget.activeHighwayCategories
                .contains(HighwayStopCategories.visitorCenter),
            onChanged: (v) => widget.onHighwayCategoryChanged(
                HighwayStopCategories.visitorCenter, v),
          ),
        ),
        _CategoryRow(
          emoji: '🧭',
          title: 'Map Filters',
          subtitle: '$filtersOn of ${_mapFilterCategories.length} Layers On',
          onTap: () => setState(() => _detail = _LayersDetailPage.mapFilters),
        ),
      ],
    );
  }

  Widget _buildDetail(BuildContext context, _LayersDetailPage page) {
    final (title, rows) = switch (page) {
      _LayersDetailPage.mapFilters => (
          'Map Filters',
          [
            for (final cat in _mapFilterCategories)
              _ToggleRowData(
                emoji: _waypointCategoryEmoji(cat),
                label: cat,
                value: widget.activeWaypointCategories.contains(cat),
                onChanged: (v) => widget.onWaypointCategoryChanged(cat, v),
              ),
          ]
        ),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => _detail = null),
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  )),
            ),
            IconButton(
              onPressed: widget.onClose,
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 4),
        for (final row in rows) _ToggleRow(data: row),
      ],
    );
  }
}

/// A top-level "Map Layers" category row showing how many of its sub-layers
/// are currently on, with a chevron to drill into the detail page.
class _CategoryRow extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _CategoryRow({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      )),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _ToggleRowData {
  final String emoji;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRowData({
    required this.emoji,
    required this.label,
    required this.value,
    required this.onChanged,
  });
}

/// A single labeled on/off switch row within a Map Layers detail page.
class _ToggleRow extends StatelessWidget {
  final _ToggleRowData data;

  const _ToggleRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(data.emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              data.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Switch(
            value: data.value,
            onChanged: data.onChanged,
            activeColor: AppColors.pine,
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
