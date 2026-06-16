import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/gear_data.dart';
import '../models/gear_item.dart';

/// Connects the Rent Gear section to the Turnagain Outfitters app on Base44.
///
/// Base44 apps expose their entities over a REST API:
///   GET https://app.base44.com/api/apps/{appId}/entities/{Entity}
/// with an `api_key` header. Once the Base44 connector is authorized and the
/// API key is filled in below, the catalog switches from the bundled offline
/// list to live inventory automatically. Until then, the bundled catalog —
/// which mirrors the live Base44 `Product` data — keeps the page accurate.
class TurnagainService {
  TurnagainService._();

  static final TurnagainService instance = TurnagainService._();

  static const String _base44AppId = GearData.base44AppId;
  // TODO(base44): paste the Turnagain Outfitters read API key to go live.
  static const String _base44ApiKey = '';
  static const String _productEntity = 'Product';

  static const String websiteUrl = 'https://turnagainoutfitters.com';

  /// Base44 product categories that map into the app's rental catalog.
  /// `merch` (apparel) is intentionally excluded.
  static const Map<String, String> _categoryMap = {
    'fishing': 'Fishing',
    'camping': 'Camping',
    'winter': 'Winter',
    'hunting': 'Hunting',
    'addon': 'Add-Ons',
  };

  static const Map<String, String> _categoryEmoji = {
    'Fishing': '🎣',
    'Camping': '🏕️',
    'Winter': '❄️',
    'Hunting': '🦌',
    'Add-Ons': '🎒',
  };

  bool get isLive => _base44ApiKey.isNotEmpty;

  /// Live inventory from Base44 when configured; bundled catalog otherwise.
  Future<List<GearItem>> fetchCatalog() async {
    if (!isLive) return GearData.items;
    try {
      final res = await http.get(
        Uri.parse(
            'https://app.base44.com/api/apps/$_base44AppId/entities/$_productEntity?limit=500'),
        headers: {'api_key': _base44ApiKey, 'Content-Type': 'application/json'},
      );
      if (res.statusCode != 200) return GearData.items;
      final list = jsonDecode(res.body) as List<dynamic>;
      final items = list
          .map((raw) => _fromBase44(raw as Map<String, dynamic>))
          .whereType<GearItem>()
          .toList();
      _sort(items);
      return items.isEmpty ? GearData.items : items;
    } catch (_) {
      // Offline or API hiccup — the bundled catalog keeps the page useful.
      return GearData.items;
    }
  }

  /// Sort to match the bundled order: by category, featured & packages first,
  /// then price (high→low), then name.
  void _sort(List<GearItem> items) {
    items.sort((a, b) {
      final ca = GearData.categories.indexOf(a.category);
      final cb = GearData.categories.indexOf(b.category);
      if (ca != cb) return ca.compareTo(cb);
      if (a.featured != b.featured) return a.featured ? -1 : 1;
      if (a.isPackage != b.isPackage) return a.isPackage ? -1 : 1;
      if (a.pricePerDay != b.pricePerDay) {
        return b.pricePerDay.compareTo(a.pricePerDay);
      }
      return a.name.compareTo(b.name);
    });
  }

  /// Returns null for products we don't surface (e.g. merch apparel).
  GearItem? _fromBase44(Map<String, dynamic> json) {
    final rawCat = (json['category'] as String?)?.toLowerCase() ?? '';
    final category = _categoryMap[rawCat];
    if (category == null) return null; // skip merch / unknown

    final specsRaw = (json['specifications'] as List<dynamic>?) ?? const [];
    final specs = <GearSpec>[];
    for (final s in specsRaw) {
      if (s is Map<String, dynamic> &&
          s['label'] != null &&
          s['value'] != null) {
        specs.add(GearSpec(
            label: s['label'].toString(), value: s['value'].toString()));
      }
    }

    return GearItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Gear item',
      category: category,
      emoji: _categoryEmoji[category] ?? '🎒',
      description: json['description'] as String? ?? '',
      pricePerDay: (json['rental_price_per_day'] as num?)?.toDouble() ?? 0,
      imageUrl: (json['image_url'] as String?)?.isNotEmpty == true
          ? json['image_url'] as String
          : null,
      isPackage: json['is_package'] as bool? ?? false,
      featured: json['featured'] as bool? ?? false,
      noFly: json['no_fly'] as bool? ?? false,
      includes:
          (json['package_includes'] as List<dynamic>?)?.cast<String>() ??
              const [],
      specs: specs,
    );
  }
}
