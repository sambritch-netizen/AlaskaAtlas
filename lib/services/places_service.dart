import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/place.dart';
import '../data/mock_data.dart';

class PlacesService {
  final SupabaseClient _client;

  PlacesService(this._client);

  Future<List<Place>> fetchPlaces({String? category}) async {
    // TODO: Replace mock with live query once Supabase table is populated
    // final response = await _client
    //     .from('places')
    //     .select()
    //     .eq('category', category ?? '')
    //     .order('name');
    // return response.map((json) => Place.fromJson(json)).toList();

    await Future.delayed(const Duration(milliseconds: 600));
    final all = MockData.places;
    if (category == null || category.isEmpty) return all;
    return all.where((p) => p.category == category).toList();
  }

  Future<List<Place>> fetchFeaturedPlaces() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockData.places.where((p) => (p.rating ?? 0) >= 4.7).toList();
  }

  Future<List<Place>> fetchNearbyPlaces({
    required double latitude,
    required double longitude,
    double radiusMiles = 100,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Use PostGIS ST_DWithin for real proximity queries
    final sorted = [...MockData.places];
    sorted.sort((a, b) => (a.distanceMiles ?? 999).compareTo(b.distanceMiles ?? 999));
    return sorted.take(5).toList();
  }

  Future<List<Place>> searchPlaces(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final q = query.toLowerCase();
    return MockData.places.where((p) {
      return p.name.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  Future<Place?> fetchPlaceById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockData.places.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
