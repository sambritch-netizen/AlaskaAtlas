import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../data/alaska_cities_data.dart';
import '../../data/highways_data.dart';
import '../../models/highway.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';
import '../map/basemaps.dart';

const _distance = Distance();

/// Arrange the trip: drag cities into visit order and dial in nights per
/// stop, with a live map showing the numbered route — following the actual
/// highway centerline between stops that share a road, not a straight line
/// drawn through the wilderness — so it's obvious what "two days in Seward,
/// then four in Whittier" actually looks like on the ground.
class TripMapScreen extends ConsumerStatefulWidget {
  const TripMapScreen({super.key});

  @override
  ConsumerState<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends ConsumerState<TripMapScreen> {
  final _mapController = MapController();
  List<HighwaySegment> _highwaySegments = [];

  @override
  void initState() {
    super.initState();
    _loadHighways();
  }

  Future<void> _loadHighways() async {
    final segments = await HighwayLoader.load();
    if (mounted) setState(() => _highwaySegments = segments);
  }

  void _focusCity(AlaskaCity city) {
    _mapController.move(city.location, 8.5);
  }

  /// The road-following path between [a] and [b]: the bundled OSM
  /// centerline for a highway they share, trimmed to the stretch between
  /// the two cities, falling back to a straight line if no shared highway
  /// centerline is loaded yet (or they're fly/ferry only).
  List<LatLng> _routeBetween(AlaskaCity a, AlaskaCity b) {
    final shared = a.highwaySlugs.toSet().intersection(b.highwaySlugs.toSet());
    for (final slug in shared) {
      final segment = _highwaySegments.firstWhere(
        (s) => s.slug == slug,
        orElse: () => const HighwaySegment(slug: '', name: '', route: '', color: Colors.transparent, points: []),
      );
      if (segment.points.length > 1) {
        final trimmed = _trimSegment(segment.points, a.location, b.location);
        if (trimmed.length > 1) return trimmed;
      }
    }
    return [a.location, b.location];
  }

  /// Cuts [points] down to the span between the points nearest [from] and
  /// [to], oriented from [from] to [to].
  List<LatLng> _trimSegment(List<LatLng> points, LatLng from, LatLng to) {
    var fromIndex = 0;
    var toIndex = 0;
    var fromBest = double.infinity;
    var toBest = double.infinity;
    for (var i = 0; i < points.length; i++) {
      final dFrom = _distance.as(LengthUnit.Meter, points[i], from);
      if (dFrom < fromBest) {
        fromBest = dFrom;
        fromIndex = i;
      }
      final dTo = _distance.as(LengthUnit.Meter, points[i], to);
      if (dTo < toBest) {
        toBest = dTo;
        toIndex = i;
      }
    }
    final start = fromIndex < toIndex ? fromIndex : toIndex;
    final end = fromIndex < toIndex ? toIndex : fromIndex;
    final sub = points.sublist(start, end + 1);
    return fromIndex <= toIndex ? sub : sub.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final plan = ref.watch(tripPlanProvider);
    final notifier = ref.read(tripPlanProvider.notifier);
    final cities = plan.cityIds
        .map((id) => AlaskaCitiesData.byId(id))
        .whereType<AlaskaCity>()
        .toList();

    final bounds = cities.length > 1
        ? LatLngBounds.fromPoints([for (final c in cities) c.location])
        : null;

    final polylines = <Polyline>[];
    for (var i = 0; i < cities.length - 1; i++) {
      final a = cities[i];
      final b = cities[i + 1];
      final shared = a.highwaySlugs.toSet().intersection(b.highwaySlugs.toSet());
      final isRoadConnected = a.accessibleByRoad && b.accessibleByRoad && shared.isNotEmpty;
      polylines.add(
        isRoadConnected
            ? Polyline(
                points: _routeBetween(a, b),
                color: AppColors.rust.withValues(alpha: 0.9),
                strokeWidth: 4,
                borderColor: Colors.black.withValues(alpha: 0.3),
                borderStrokeWidth: 1.5,
              )
            : Polyline(
                points: [a.location, b.location],
                color: AppColors.rust.withValues(alpha: 0.7),
                strokeWidth: 3,
                pattern: const StrokePattern.dotted(),
              ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Arrange Your Route')),
      body: Column(
        children: [
          SizedBox(
            height: 260,
            child: cities.isEmpty
                ? const Center(
                    child: Text('Add cities first.',
                        style: TextStyle(color: AppColors.textMuted)),
                  )
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: cities.first.location,
                      initialZoom: 6,
                      initialCameraFit: bounds != null
                          ? CameraFit.bounds(
                              bounds: bounds,
                              padding: const EdgeInsets.all(48),
                            )
                          : null,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: Basemaps.dark.urlTemplate,
                        userAgentPackageName: 'com.alaskaatlas.alaska_atlas',
                        maxNativeZoom: Basemaps.dark.maxNativeZoom,
                      ),
                      if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
                      MarkerLayer(
                        markers: [
                          for (var i = 0; i < cities.length; i++)
                            Marker(
                              point: cities[i].location,
                              width: 36,
                              height: 36,
                              child: GestureDetector(
                                onTap: () => _focusCity(cities[i]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.pine,
                                    border: Border.all(color: Colors.white, width: 2),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black54, blurRadius: 4),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Drag to reorder · use +/– to set nights per stop',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Text(
                  '${plan.totalPlannedNights} nights planned',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              itemCount: cities.length,
              onReorder: notifier.reorderCities,
              itemBuilder: (context, i) {
                final city = cities[i];
                final isEndpoint =
                    city.id == plan.arrivalCityId || city.id == plan.departureCityId;
                final nights = plan.nightsFor(city.id);
                return Container(
                  key: ValueKey(city.id),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.pine.withValues(alpha: 0.18),
                            border: Border.all(color: AppColors.pine),
                          ),
                          child: Center(
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    color: AppColors.pine,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(city.emoji, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _focusCity(city),
                            child: Text(city.name,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, size: 20),
                          color: AppColors.textSecondary,
                          onPressed: nights > 1
                              ? () => notifier.setNights(city.id, nights - 1)
                              : null,
                        ),
                        SizedBox(
                          width: 64,
                          child: Text(
                            '$nights night${nights == 1 ? "" : "s"}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, size: 20),
                          color: AppColors.pine,
                          onPressed: () => notifier.setNights(city.id, nights + 1),
                        ),
                        if (!isEndpoint)
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: AppColors.textMuted,
                            onPressed: () => notifier.toggleCity(city.id),
                          )
                        else
                          const SizedBox(width: 8),
                        const Icon(Icons.drag_handle, color: AppColors.textMuted),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: cities.isEmpty ? null : () => context.go('/trip/itinerary'),
                  child: const Text('Build Full Itinerary'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
