import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// A place found by [GeocodeService] — anywhere in the world, not just the
/// places bundled in [SearchIndex].
class GeocodeResult {
  final String name;
  final String displayName;
  final LatLng location;

  const GeocodeResult({
    required this.name,
    required this.displayName,
    required this.location,
  });
}

/// Looks up addresses, towns, and points of interest worldwide using
/// OpenStreetMap's free Nominatim geocoding API, biased toward Alaska.
class GeocodeService {
  GeocodeService._();

  static const _endpoint = 'https://nominatim.openstreetmap.org/search';

  // Roughly bounds Alaska — biases results here without excluding the rest
  // of the world (bounded=0, the default).
  static const _alaskaViewbox = '-170,72,-129,51';

  static Future<List<GeocodeResult>> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return const [];

    final uri = Uri.parse(_endpoint).replace(
      queryParameters: {
        'q': q,
        'format': 'jsonv2',
        'limit': '6',
        'viewbox': _alaskaViewbox,
      },
    );

    final response = await http.get(uri, headers: {'Accept-Language': 'en'});
    if (response.statusCode != 200) return const [];

    final data = jsonDecode(response.body) as List;
    return [
      for (final item in data)
        GeocodeResult(
          name: _shortName(item),
          displayName: item['display_name'] as String,
          location: LatLng(
            double.parse(item['lat'] as String),
            double.parse(item['lon'] as String),
          ),
        ),
    ];
  }

  static String _shortName(dynamic item) {
    final name = item['name'] as String?;
    if (name != null && name.isNotEmpty) return name;
    return (item['display_name'] as String).split(',').first;
  }
}
