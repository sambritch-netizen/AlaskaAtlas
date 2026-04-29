import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/rental_item.dart';
import '../data/mock_data.dart';

class RentalsService {
  final SupabaseClient _client;

  RentalsService(this._client);

  Future<List<RentalItem>> fetchRentalItems({String? category}) async {
    // TODO: Replace mock with live Supabase query
    // final query = _client.from('rental_items').select();
    // if (category != null && category != 'All') query.eq('category', category);
    // final response = await query.order('name');
    // return response.map((json) => RentalItem.fromJson(json)).toList();

    await Future.delayed(const Duration(milliseconds: 500));
    final all = MockData.rentalItems;
    if (category == null || category == 'All') return all;
    return all.where((r) => r.category == category).toList();
  }

  Future<RentalItem?> fetchRentalById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockData.rentalItems.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}
