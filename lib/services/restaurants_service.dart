import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/restaurant.dart';

class RestaurantsService {
  final SupabaseClient _client;

  RestaurantsService(this._client);

  Future<List<Restaurant>> fetchRestaurants() async {
    final response = await _client
        .from('restaurants')
        .select()
        .order('rating', ascending: false);
    return response.map((json) => Restaurant.fromJson(json)).toList();
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final response = await _client
        .from('restaurants')
        .select()
        .or('name.ilike.%$query%,cuisine_type.ilike.%$query%,description.ilike.%$query%')
        .order('rating', ascending: false);
    return response.map((json) => Restaurant.fromJson(json)).toList();
  }

  Future<Restaurant?> fetchRestaurantById(String id) async {
    final response = await _client
        .from('restaurants')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response == null) return null;
    return Restaurant.fromJson(response);
  }
}
