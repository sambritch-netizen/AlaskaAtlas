import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/rental_item.dart';
import '../../services/rentals_service.dart';

final rentalsServiceProvider = Provider<RentalsService>(
  (ref) => RentalsService(Supabase.instance.client),
);

final selectedRentalCategoryProvider = StateProvider<String>((ref) => 'All');

final rentalItemsProvider = FutureProvider.family<List<RentalItem>, String>((ref, category) {
  return ref.watch(rentalsServiceProvider).fetchRentalItems(
        category: category == 'All' ? null : category,
      );
});

final filteredRentalsProvider = Provider<AsyncValue<List<RentalItem>>>((ref) {
  final category = ref.watch(selectedRentalCategoryProvider);
  return ref.watch(rentalItemsProvider(category));
});
