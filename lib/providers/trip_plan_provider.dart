import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/trip_plan.dart';

const _storageKey = 'trip_plan_v1';

final tripPlanProvider =
    NotifierProvider<TripPlanNotifier, TripPlan>(TripPlanNotifier.new);

class TripPlanNotifier extends Notifier<TripPlan> {
  @override
  TripPlan build() {
    _load();
    return TripPlan.empty;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;
    try {
      state = TripPlan.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Corrupt or outdated payload — fall back to a blank trip.
    }
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(state.toJson()));
  }

  void setDates(DateTime start, DateTime end) {
    state = state.copyWith(startDate: start, endDate: end);
    _persist();
  }

  void setArrivalDeparture({String? arrivalCityId, String? departureCityId}) {
    final cities = [...state.cityIds];
    if (arrivalCityId != null && !cities.contains(arrivalCityId)) {
      cities.insert(0, arrivalCityId);
    }
    if (departureCityId != null &&
        departureCityId != arrivalCityId &&
        !cities.contains(departureCityId)) {
      cities.add(departureCityId);
    }
    state = state.copyWith(
      arrivalCityId: arrivalCityId,
      departureCityId: departureCityId,
      cityIds: cities,
    );
    _persist();
  }

  void toggleCity(String cityId) {
    final cities = [...state.cityIds];
    if (cities.contains(cityId)) {
      if (cityId == state.arrivalCityId || cityId == state.departureCityId) {
        return;
      }
      cities.remove(cityId);
    } else {
      cities.add(cityId);
    }
    state = state.copyWith(cityIds: cities);
    _persist();
  }

  void reorderCities(int oldIndex, int newIndex) {
    final cities = [...state.cityIds];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = cities.removeAt(oldIndex);
    cities.insert(newIndex, item);
    state = state.copyWith(cityIds: cities);
    _persist();
  }

  void setNights(String cityId, int nights) {
    final map = {...state.nightsByCity};
    map[cityId] = nights.clamp(1, 30);
    state = state.copyWith(nightsByCity: map);
    _persist();
  }

  void toggleActivity(String cityId, String activityRef) {
    final map = {
      for (final entry in state.savedActivitiesByCity.entries)
        entry.key: [...entry.value],
    };
    final list = map.putIfAbsent(cityId, () => []);
    if (list.contains(activityRef)) {
      list.remove(activityRef);
    } else {
      list.add(activityRef);
    }
    state = state.copyWith(savedActivitiesByCity: map);
    _persist();
  }

  bool isActivitySaved(String cityId, String activityRef) =>
      state.savedActivitiesByCity[cityId]?.contains(activityRef) ?? false;

  void reset() {
    state = TripPlan.empty;
    _persist();
  }
}
