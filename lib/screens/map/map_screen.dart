import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../data/hotspots_data.dart';
import '../../data/lakes_data.dart';
import '../../models/hotspot.dart';
import '../../models/lake.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import 'hotspot_sheet.dart';
import 'lake_overlay.dart';

enum _BaseLayer { dark, topo }

/// Statewide hot-spot map. Two base layers — a dark atlas style that matches
/// the app, and OpenTopoMap for the rugged contour look — with
/// category-filterable pins.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  _BaseLayer _layer = _BaseLayer.topo;
  String? _category;
  // In-map bathymetry only makes sense once lakes occupy real screen space.
  bool _showContours = false;
  static const _contourZoom = 9.0;

  static const _alaskaCenter = LatLng(62.8, -152.5);
  static const _anchorageCenter = LatLng(61.23, -149.78);
  static const _lakesFilter = 'Lake Charts';

  String get _tileUrl => switch (_layer) {
        _BaseLayer.dark =>
          'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
        _BaseLayer.topo => 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
      };

  String get _attribution => switch (_layer) {
        _BaseLayer.dark => '© OpenStreetMap, © CARTO',
        _BaseLayer.topo => '© OpenStreetMap, © OpenTopoMap (CC-BY-SA)',
      };

  @override
  Widget build(BuildContext context) {
    final lakesOnly = _category == _lakesFilter;
    final spots =
        lakesOnly ? <Hotspot>[] : HotspotsData.byCategory(_category);
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
              maxZoom: 17,
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
                urlTemplate: _tileUrl,
                userAgentPackageName: 'com.alaskaatlas.alaska_atlas',
                retinaMode: _layer == _BaseLayer.dark
                    ? RetinaMode.isHighDensity(context)
                    : false,
              ),
              if (showLakes && _showContours)
                PolygonLayer(
                  polygons: [
                    for (final lake in LakesData.lakes)
                      ...LakeOverlay.polygonsFor(lake),
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
                    _attribution,
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
                      _LayerToggle(
                        layer: _layer,
                        onChanged: (l) => setState(() => _layer = l),
                      ),
                    ],
                  ),
                ),
                FilterChipsRow(
                  options: const [_lakesFilter, ...HotspotsData.categories],
                  selected: _category,
                  emojiFor: (c) => c == _lakesFilter
                      ? '💧'
                      : HotspotsData.categoryEmoji(c),
                  onSelected: (c) {
                    setState(() => _category = c);
                    if (c == _lakesFilter) {
                      // The lake charts cluster around Anchorage.
                      _mapController.move(_anchorageCenter, 9.6);
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

class _LayerToggle extends StatelessWidget {
  final _BaseLayer layer;
  final ValueChanged<_BaseLayer> onChanged;

  const _LayerToggle({required this.layer, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _option('Dark', _BaseLayer.dark),
          _option('Topo', _BaseLayer.topo),
        ],
      ),
    );
  }

  Widget _option(String label, _BaseLayer value) {
    final selected = layer == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.pine : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.background : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
