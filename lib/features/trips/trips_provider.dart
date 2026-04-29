import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/place.dart';

class FavoritesNotifier extends StateNotifier<List<Place>> {
  FavoritesNotifier() : super([]);

  void toggle(Place place) {
    if (isFavorite(place.id)) {
      state = state.where((p) => p.id != place.id).toList();
    } else {
      state = [...state, place];
    }
  }

  bool isFavorite(String placeId) {
    return state.any((p) => p.id == placeId);
  }

  void remove(Place place) {
    state = state.where((p) => p.id != place.id).toList();
  }

  void clear() {
    state = [];
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Place>>(
  (ref) => FavoritesNotifier(),
);

final isFavoriteProvider = Provider.family<bool, String>((ref, placeId) {
  return ref.watch(favoritesProvider).any((p) => p.id == placeId);
});
