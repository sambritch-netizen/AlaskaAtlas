import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Temporary, locally-stored corrections to highway-stop pin locations.
///
/// Lets a user drag a pin to its true position from the in-app map and have
/// that correction persist (in the browser's local storage) until the
/// underlying dataset is updated and this override is no longer needed.
class PinOverrides {
  PinOverrides._();

  static const _prefsKey = 'highway_stop_pin_overrides';
  static Map<String, LatLng> _overrides = {};
  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return;
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    _overrides = decoded.map(
      (key, value) => MapEntry(
        key,
        LatLng(
          (value['lat'] as num).toDouble(),
          (value['lng'] as num).toDouble(),
        ),
      ),
    );
  }

  static String keyFor(String highwaySlug, String stopName) =>
      '$highwaySlug|$stopName';

  static LatLng? get(String key) => _overrides[key];

  static Map<String, LatLng> get all => Map.unmodifiable(_overrides);

  static Future<void> set(String key, LatLng point) async {
    _overrides[key] = point;
    await _persist();
  }

  static Future<void> clearAll() async {
    _overrides = {};
    await _persist();
  }

  static Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(toJsonMap()));
  }

  /// All overrides as plain `{lat, lng}` maps, ready for copying out and
  /// baking permanently into `highways_data.dart`.
  static Map<String, dynamic> toJsonMap() => _overrides.map(
        (key, value) =>
            MapEntry(key, {'lat': value.latitude, 'lng': value.longitude}),
      );

  static String exportJson() =>
      const JsonEncoder.withIndent('  ').convert(toJsonMap());
}
