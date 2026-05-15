import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/rental_item.dart';

// Reads from `rental_packages` — the user-facing catalog with pricing.
class RentalsService {
  final SupabaseClient _client;

  RentalsService(this._client);

  Future<List<RentalItem>> fetchRentalItems({String? category}) async {
    var query = _client.from('rental_packages').select().eq('active', true);
    if (category != null && category.isNotEmpty) {
      query = query.eq('category', category.toLowerCase());
    }
    final response = await query.order('price_per_day', ascending: true);
    return response.map((json) => RentalItem.fromJson(json)).toList();
  }

  Future<RentalItem?> fetchRentalById(String id) async {
    final response = await _client
        .from('rental_packages')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response == null) return null;
    return RentalItem.fromJson(response);
  }
}
