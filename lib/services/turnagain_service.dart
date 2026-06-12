import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/gear_data.dart';
import '../models/gear_item.dart';

/// Connects the Rent Gear section to the Turnagain Outfitters app on Base44.
///
/// Base44 apps expose their entities over a REST API:
///   GET https://app.base44.com/api/apps/{appId}/entities/{Entity}
/// with an `api_key` header. Once the Base44 connector is authorized and the
/// app id / API key are filled in below, the catalog switches from the
/// bundled offline list to live inventory automatically.
class TurnagainService {
  TurnagainService._();

  static final TurnagainService instance = TurnagainService._();

  // TODO(base44): set from the Turnagain Outfitters Base44 app once the
  // connector handshake is complete.
  static const String _base44AppId = '';
  static const String _base44ApiKey = '';
  static const String _gearEntity = 'GearItem';

  static const String websiteUrl = 'https://turnagainoutfitters.com';

  bool get isLive => _base44AppId.isNotEmpty && _base44ApiKey.isNotEmpty;

  /// Live inventory from Base44 when configured; bundled catalog otherwise.
  Future<List<GearItem>> fetchCatalog() async {
    if (!isLive) return GearData.items;
    try {
      final res = await http.get(
        Uri.parse(
            'https://app.base44.com/api/apps/$_base44AppId/entities/$_gearEntity'),
        headers: {'api_key': _base44ApiKey, 'Content-Type': 'application/json'},
      );
      if (res.statusCode != 200) return GearData.items;
      final list = jsonDecode(res.body) as List<dynamic>;
      return list
          .map((raw) => _fromBase44(raw as Map<String, dynamic>))
          .toList();
    } catch (_) {
      // Offline or API hiccup — the bundled catalog keeps the page useful.
      return GearData.items;
    }
  }

  GearItem _fromBase44(Map<String, dynamic> json) {
    return GearItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Gear item',
      category: json['category'] as String? ?? 'Camping',
      emoji: json['emoji'] as String? ?? '🎒',
      description: json['description'] as String? ?? '',
      pricePerDay: (json['price_per_day'] as num?)?.toDouble() ?? 0,
      includes: (json['includes'] as List<dynamic>?)?.cast<String>() ?? const [],
      goodFor: (json['good_for'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }
}
