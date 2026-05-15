import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/place.dart';

class PlacesService {
  final SupabaseClient _client;

  PlacesService(this._client);

  Future<List<Place>> fetchPlaces({String? category}) async {
    var query = _client.from('places').select();
    if (category != null && category.isNotEmpty) {
      query = query.eq('category', category);
    }
    final response = await query.order('rating', ascending: false);
    return response.map((json) => Place.fromJson(json)).toList();
  }

  Future<List<Place>> fetchFeaturedPlaces() async {
    final response = await _client
        .from('places')
        .select()
        .gte('rating', 4.7)
        .order('rating', ascending: false)
        .limit(10);
    return response.map((json) => Place.fromJson(json)).toList();
  }

  Future<List<Place>> fetchNearbyPlaces({
    required double latitude,
    required double longitude,
    double radiusMiles = 100,
  }) async {
    // Order by distance_miles for now; PostGIS ST_DWithin can replace this
    // once the postgis extension is enabled.
    final response = await _client
        .from('places')
        .select()
        .order('distance_miles', ascending: true)
        .limit(8);
    return response.map((json) => Place.fromJson(json)).toList();
  }

  Future<List<Place>> searchPlaces(String query) async {
    final response = await _client
        .from('places')
        .select()
        .or('name.ilike.%$query%,description.ilike.%$query%,category.ilike.%$query%')
        .order('rating', ascending: false);
    return response.map((json) => Place.fromJson(json)).toList();
  }

  Future<Place?> fetchPlaceById(String id) async {
    final response =
        await _client.from('places').select().eq('id', id).maybeSingle();
    if (response == null) return null;
    return Place.fromJson(response);
  }
}
