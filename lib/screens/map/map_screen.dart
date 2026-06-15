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

  // Independently toggleable map overlays, switched from the "Map Layers"
  // menu — onX-style category drill-down.
  bool _showHighways = true;
  bool _showLakeCharts = false;

  // Per-category visibility within the Highways group — all on by default,
  // toggled individually from the Map Layers menu.
  final Set<String> _activeHighwayCategories = {...HighwayStopCategories.all};

  // Trip-planning waypoint pins (fishing, wildlife, camping, etc.) — off by
  // default, toggled individually from the Map Layers menu.
  final Set<String> _activeWaypointCategories = {};

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
                  onTap: () => _openMapLayersSheet(context),
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
                        Icon(Icons.layers, size: 15, color: AppColors.pine),
                        SizedBox(width: 6),
                        Text(
                          'Map Layers',
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
        ],
      ),
    );
  }

  /// Opens the onX-style "Map Layers" menu: a category list that drills
  /// down into per-layer toggle switches.
  void _openMapLayersSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, sheetSetState) {
            return _MapLayersSheet(
              showHighways: _showHighways,
              showLakeCharts: _showLakeCharts,
              activeHighwayCategories: _activeHighwayCategories,
              activeWaypointCategories: _activeWaypointCategories,
              onHighwaysChanged: (v) {
                setState(() => _showHighways = v);
                sheetSetState(() {});
              },
              onLakeChartsChanged: (v) {
                setState(() => _showLakeCharts = v);
                if (v) _mapController.move(_anchorageCenter, 9.6);
                sheetSetState(() {});
              },
              onHighwayCategoryChanged: (cat, v) {
                setState(() {
                  if (v) {
                    _activeHighwayCategories.add(cat);
                  } else {
                    _activeHighwayCategories.remove(cat);
                  }
                });
                sheetSetState(() {});
              },
              onWaypointCategoryChanged: (cat, v) {
                setState(() {
                  if (v) {
                    _activeWaypointCategories.add(cat);
                  } else {
                    _activeWaypointCategories.remove(cat);
                  }
                });
                sheetSetState(() {});
              },
            );
          },
        );
      },
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
      WaypointCategories.food => const Color(0xFFFBC02D),
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
  final Set<String> activeHighwayCategories;
  final Set<String> activeWaypointCategories;
  final ValueChanged<bool> onHighwaysChanged;
  final ValueChanged<bool> onLakeChartsChanged;
  final void Function(String category, bool value) onHighwayCategoryChanged;
  final void Function(String category, bool value) onWaypointCategoryChanged;

  const _MapLayersSheet({
    required this.showHighways,
    required this.showLakeCharts,
    required this.activeHighwayCategories,
    required this.activeWaypointCategories,
    required this.onHighwaysChanged,
    required this.onLakeChartsChanged,
    required this.onHighwayCategoryChanged,
    required this.onWaypointCategoryChanged,
  });

  @override
  State<_MapLayersSheet> createState() => _MapLayersSheetState();
}

/// Menu emoji for each highway-stop category (UI only — map pins themselves
/// carry no emoji).
String _highwayCategoryEmoji(String category) => switch (category) {
      HighwayStopCategories.visitorCenter => 'ℹ️',
      HighwayStopCategories.fuel => '⛽',
      HighwayStopCategories.restArea => '🅿️',
      HighwayStopCategories.campground => '🏕️',
      HighwayStopCategories.scenic => '⛰️',
      HighwayStopCategories.food => '🍽️',
      _ => '📍',
    };

enum _LayersDetailPage { highways, lakeCharts, waypoints }

class _MapLayersSheetState extends State<_MapLayersSheet> {
  _LayersDetailPage? _detail;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(
              top: BorderSide(color: AppColors.border),
              left: BorderSide(color: AppColors.border),
              right: BorderSide(color: AppColors.border),
            ),
          ),
          child: _detail == null
              ? _buildList(context, scrollController)
              : _buildDetail(context, scrollController, _detail!),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, ScrollController scrollController) {
    final highwaysOn =
        (widget.showHighways ? 1 : 0) + widget.activeHighwayCategories.length;
    final highwayTotal = HighwayStopCategories.all.length + 1;

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      children: [
        Center(
          child: Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text('Map Layers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              )),
        ),
        const SizedBox(height: 8),
        _CategoryRow(
          emoji: '🛣️',
          title: 'Highways',
          subtitle: '$highwaysOn of $highwayTotal Layers On',
          onTap: () => setState(() => _detail = _LayersDetailPage.highways),
        ),
        _CategoryRow(
          emoji: '💧',
          title: 'Lake Charts',
          subtitle: widget.showLakeCharts ? '1 of 1 Layers On' : '0 of 1 Layers On',
          onTap: () => setState(() => _detail = _LayersDetailPage.lakeCharts),
        ),
        _CategoryRow(
          emoji: '🧭',
          title: 'Trip Waypoints',
          subtitle:
              '${widget.activeWaypointCategories.length} of ${WaypointCategories.all.length} Layers On',
          onTap: () => setState(() => _detail = _LayersDetailPage.waypoints),
        ),
      ],
    );
  }

  Widget _buildDetail(BuildContext context, ScrollController scrollController,
      _LayersDetailPage page) {
    final (title, rows) = switch (page) {
      _LayersDetailPage.highways => (
          'Highways',
          [
            _ToggleRowData(
              emoji: '🛣️',
              label: 'Highway Routes & Pins',
              value: widget.showHighways,
              onChanged: widget.onHighwaysChanged,
            ),
            for (final cat in HighwayStopCategories.all)
              _ToggleRowData(
                emoji: _highwayCategoryEmoji(cat),
                label: cat,
                value: widget.activeHighwayCategories.contains(cat),
                onChanged: (v) => widget.onHighwayCategoryChanged(cat, v),
              ),
          ]
        ),
      _LayersDetailPage.lakeCharts => (
          'Lake Charts',
          [
            _ToggleRowData(
              emoji: '💧',
              label: 'Lake Bathymetry',
              value: widget.showLakeCharts,
              onChanged: widget.onLakeChartsChanged,
            ),
          ]
        ),
      _LayersDetailPage.waypoints => (
          'Trip Waypoints',
          [
            for (final cat in WaypointCategories.all)
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
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      children: [
        Center(
          child: Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => _detail = null),
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
            Text(title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                )),
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
