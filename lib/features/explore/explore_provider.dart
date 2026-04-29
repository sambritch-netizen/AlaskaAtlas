import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/place.dart';
import '../../models/restaurant.dart';
import '../../services/places_service.dart';
import '../../services/restaurants_service.dart';

// ── Service providers ────────────────────────────────────────────────────────

final _supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);

final placesServiceProvider = Provider<PlacesService>(
  (ref) => PlacesService(ref.watch(_supabaseClientProvider)),
);

final restaurantsServiceProvider = Provider<RestaurantsService>(
  (ref) => RestaurantsService(ref.watch(_supabaseClientProvider)),
);

// ── State providers ──────────────────────────────────────────────────────────

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');

// ── Data providers ───────────────────────────────────────────────────────────

final featuredPlacesProvider = FutureProvider<List<Place>>((ref) async {
  return ref.watch(placesServiceProvider).fetchFeaturedPlaces();
});

final nearbyPlacesProvider = FutureProvider<List<Place>>((ref) async {
  return ref.watch(placesServiceProvider).fetchNearbyPlaces(
        latitude: 61.2181,
        longitude: -149.9003,
      );
});

final allPlacesProvider = FutureProvider.family<List<Place>, String?>((ref, category) async {
  return ref.watch(placesServiceProvider).fetchPlaces(category: category);
});

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  return ref.watch(restaurantsServiceProvider).fetchRestaurants();
});

final searchResultsProvider = FutureProvider<List<Place>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  return ref.watch(placesServiceProvider).searchPlaces(query);
});

// ── Derived filtered provider ─────────────────────────────────────────────────

final filteredPlacesProvider = Provider<AsyncValue<List<Place>>>((ref) {
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isNotEmpty) {
    return ref.watch(searchResultsProvider);
  }
  return ref.watch(allPlacesProvider(category));
});
