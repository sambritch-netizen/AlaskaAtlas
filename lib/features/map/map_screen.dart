import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock_data.dart';
import '../../models/place.dart';
import '../../models/restaurant.dart';
import '../../widgets/place_card.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  Place? _selectedPlace;
  Restaurant? _selectedRestaurant;
  bool _showPlaces = true;
  bool _showFood = true;

  // Anchorage, AK
  static const double _initLat = 61.2181;
  static const double _initLng = -149.9003;
  static const double _initZoom = 6.0;

  void _onMapCreated(MapboxMap map) {
    _mapboxMap = map;
    _setupMap();
  }

  Future<void> _setupMap() async {
    await _mapboxMap?.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    _pointAnnotationManager =
        await _mapboxMap?.annotations.createPointAnnotationManager();

    _addAnnotations();
  }

  Future<void> _addAnnotations() async {
    if (_pointAnnotationManager == null) return;
    await _pointAnnotationManager!.deleteAll();

    if (_showPlaces) {
      for (final place in MockData.places) {
        await _pointAnnotationManager!.create(
          PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(place.longitude, place.latitude),
            ),
            textField: MockDataIcon.forCategory(place.category),
            textSize: 24,
            iconSize: 1.2,
          ),
        );
      }
    }

    if (_showFood) {
      for (final r in MockData.restaurants) {
        await _pointAnnotationManager!.create(
          PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(r.longitude, r.latitude),
            ),
            textField: '🍽️',
            textSize: 22,
            iconSize: 1.0,
          ),
        );
      }
    }
  }

  void _dismissBottomSheet() {
    setState(() {
      _selectedPlace = null;
      _selectedRestaurant = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 16, color: AppColors.textMuted),
              SizedBox(width: 6),
              Text(
                'Search the map…',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // ── Map ────────────────────────────────────────────────────────────
          MapWidget(
            key: const ValueKey('alaska_atlas_map'),
            onMapCreated: _onMapCreated,
            styleUri: MapboxStyles.DARK,
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(_initLng, _initLat)),
              zoom: _initZoom,
            ),
          ),

          // ── Layer toggles ──────────────────────────────────────────────────
          Positioned(
            top: 110,
            right: 12,
            child: Column(
              children: [
                _MapToggleButton(
                  label: 'Places',
                  icon: '📍',
                  active: _showPlaces,
                  onTap: () {
                    setState(() => _showPlaces = !_showPlaces);
                    _addAnnotations();
                  },
                ),
                const SizedBox(height: 8),
                _MapToggleButton(
                  label: 'Food',
                  icon: '🍽️',
                  active: _showFood,
                  onTap: () {
                    setState(() => _showFood = !_showFood);
                    _addAnnotations();
                  },
                ),
              ],
            ),
          ),

          // ── Offline maps button ────────────────────────────────────────────
          Positioned(
            bottom: 24 + MediaQuery.of(context).padding.bottom,
            left: 16,
            child: _OfflineMapsButton(),
          ),

          // ── Place preview bottom sheet ─────────────────────────────────────
          if (_selectedPlace != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _PlacePreviewSheet(
                place: _selectedPlace!,
                onClose: _dismissBottomSheet,
              ),
            ),
        ],
      ),
    );
  }
}

class _MapToggleButton extends StatelessWidget {
  final String label;
  final String icon;
  final bool active;
  final VoidCallback onTap;

  const _MapToggleButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? AppColors.accent.withValues(alpha: 0.2)
              : AppColors.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? AppColors.accent : AppColors.borderColor,
          ),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: active ? AppColors.accent : AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineMapsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Offline maps coming soon'),
            backgroundColor: AppColors.surfaceElevated,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download_outlined, size: 16, color: AppColors.textSecondary),
            SizedBox(width: 6),
            Text(
              'Offline Maps',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacePreviewSheet extends StatelessWidget {
  final Place place;
  final VoidCallback onClose;

  const _PlacePreviewSheet({required this.place, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: AppColors.textMuted),
                onPressed: onClose,
              ),
            ],
          ),
          Text(
            '${place.category} · ${place.bestSeason}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (place.difficulty != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      place.difficulty!,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ),
                ),
              const Spacer(),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('View Details', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
