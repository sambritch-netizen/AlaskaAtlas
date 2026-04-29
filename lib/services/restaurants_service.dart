import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/restaurant.dart';
import '../data/mock_data.dart';

class RestaurantsService {
  final SupabaseClient _client;

  RestaurantsService(this._client);

  Future<List<Restaurant>> fetchRestaurants() async {
    // TODO: Replace mock with live Supabase query
    // final response = await _client.from('restaurants').select().order('rating', ascending: false);
    // return response.map((json) => Restaurant.fromJson(json)).toList();

    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.restaurants;
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final q = query.toLowerCase();
    return MockData.restaurants.where((r) {
      return r.name.toLowerCase().contains(q) ||
          r.cuisineType.toLowerCase().contains(q) ||
          r.description.toLowerCase().contains(q);
    }).toList();
  }

  Future<Restaurant?> fetchRestaurantById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockData.restaurants.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}
