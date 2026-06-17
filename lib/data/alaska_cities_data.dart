import 'package:latlong2/latlong.dart';

/// A town or city usable as a trip-planning anchor — arrival/departure
/// point, an itinerary stop, or an endpoint for route-based suggestions.
class AlaskaCity {
  final String id;
  final String name;
  final String region;
  final double lat;
  final double lng;
  final String emoji;
  final String blurb;
  final bool hasAirport;
  final bool accessibleByRoad;

  /// Highway slugs (matching [HighwaysData]) that pass through or connect
  /// to this city — used to find road-trip stops between two cities.
  final List<String> highwaySlugs;

  const AlaskaCity({
    required this.id,
    required this.name,
    required this.region,
    required this.lat,
    required this.lng,
    required this.emoji,
    required this.blurb,
    required this.hasAirport,
    required this.accessibleByRoad,
    this.highwaySlugs = const [],
  });

  LatLng get location => LatLng(lat, lng);
}

class AlaskaCitiesData {
  AlaskaCitiesData._();

  static const List<AlaskaCity> cities = [
    AlaskaCity(
      id: 'anchorage',
      name: 'Anchorage',
      region: 'Southcentral',
      lat: 61.2181,
      lng: -149.9003,
      emoji: '🏙️',
      blurb: 'The state\'s air hub and the start of most road trips.',
      hasAirport: true,
      accessibleByRoad: true,
      highwaySlugs: ['seward-highway', 'glenn-highway', 'parks-highway'],
    ),
    AlaskaCity(
      id: 'fairbanks',
      name: 'Fairbanks',
      region: 'Interior',
      lat: 64.8378,
      lng: -147.7164,
      emoji: '🌌',
      blurb: 'Aurora capital, gateway to the Arctic on the Dalton Highway.',
      hasAirport: true,
      accessibleByRoad: true,
      highwaySlugs: [
        'parks-highway',
        'richardson-highway',
        'steese-highway',
        'elliott-highway',
        'dalton-highway',
      ],
    ),
    AlaskaCity(
      id: 'juneau',
      name: 'Juneau',
      region: 'Southeast',
      lat: 58.3019,
      lng: -134.4197,
      emoji: '🏔️',
      blurb: 'The capital — no roads in or out, just ferry and float planes.',
      hasAirport: true,
      accessibleByRoad: false,
    ),
    AlaskaCity(
      id: 'seward',
      name: 'Seward',
      region: 'Southcentral',
      lat: 60.1042,
      lng: -149.4423,
      emoji: '🐋',
      blurb: 'Glacier cruises and the end of the Seward Highway.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['seward-highway'],
    ),
    AlaskaCity(
      id: 'whittier',
      name: 'Whittier',
      region: 'Southcentral',
      lat: 60.7728,
      lng: -148.6864,
      emoji: '🚇',
      blurb: 'A one-tunnel town on Prince William Sound — glacier cruises and tidewater ice.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['seward-highway'],
    ),
    AlaskaCity(
      id: 'homer',
      name: 'Homer',
      region: 'Southcentral',
      lat: 59.6425,
      lng: -151.5483,
      emoji: '🚤',
      blurb: 'Halibut capital, at the literal end of the road system.',
      hasAirport: true,
      accessibleByRoad: true,
      highwaySlugs: ['sterling-highway'],
    ),
    AlaskaCity(
      id: 'soldotna',
      name: 'Soldotna / Kenai',
      region: 'Southcentral',
      lat: 60.4877,
      lng: -151.0581,
      emoji: '🎣',
      blurb: 'Kenai River salmon country, halfway down the peninsula.',
      hasAirport: true,
      accessibleByRoad: true,
      highwaySlugs: ['sterling-highway'],
    ),
    AlaskaCity(
      id: 'talkeetna',
      name: 'Talkeetna',
      region: 'Interior',
      lat: 62.3209,
      lng: -150.1066,
      emoji: '🛩️',
      blurb: 'Denali flightseeing staging town, log cabins and pie.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['parks-highway'],
    ),
    AlaskaCity(
      id: 'denali-park',
      name: 'Denali Park / Healy',
      region: 'Interior',
      lat: 63.7280,
      lng: -148.9133,
      emoji: '🏔️',
      blurb: 'The entrance to Denali National Park.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['parks-highway'],
    ),
    AlaskaCity(
      id: 'girdwood',
      name: 'Girdwood',
      region: 'Southcentral',
      lat: 60.9620,
      lng: -149.1101,
      emoji: '🚡',
      blurb: 'Alyeska Resort and the Turnagain Arm scenic drive.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['seward-highway'],
    ),
    AlaskaCity(
      id: 'valdez',
      name: 'Valdez',
      region: 'Southcentral',
      lat: 61.1308,
      lng: -146.3483,
      emoji: '🏂',
      blurb: 'Waterfall-lined fjord town beneath Thompson Pass.',
      hasAirport: true,
      accessibleByRoad: true,
      highwaySlugs: ['richardson-highway'],
    ),
    AlaskaCity(
      id: 'palmer-wasilla',
      name: 'Palmer / Wasilla',
      region: 'Southcentral',
      lat: 61.5994,
      lng: -149.1142,
      emoji: '🚜',
      blurb: 'Mat-Su Valley farms, glacier views, and Hatcher Pass.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['glenn-highway', 'parks-highway'],
    ),
    AlaskaCity(
      id: 'tok',
      name: 'Tok',
      region: 'Interior',
      lat: 63.3367,
      lng: -142.9856,
      emoji: '🛣️',
      blurb: 'Highway junction town at the Canadian border crossing.',
      hasAirport: false,
      accessibleByRoad: true,
      highwaySlugs: ['alaska-highway', 'tok-cutoff', 'taylor-highway'],
    ),
    AlaskaCity(
      id: 'ketchikan',
      name: 'Ketchikan',
      region: 'Southeast',
      lat: 55.3422,
      lng: -131.6461,
      emoji: '🐟',
      blurb: 'Southeast\'s gateway — totem poles and salmon, ferry/air only.',
      hasAirport: true,
      accessibleByRoad: false,
    ),
    AlaskaCity(
      id: 'sitka',
      name: 'Sitka',
      region: 'Southeast',
      lat: 57.0531,
      lng: -135.3300,
      emoji: '🦅',
      blurb: 'Russian-American history on the outer coast, ferry/air only.',
      hasAirport: true,
      accessibleByRoad: false,
    ),
    AlaskaCity(
      id: 'skagway',
      name: 'Skagway',
      region: 'Southeast',
      lat: 59.4583,
      lng: -135.3139,
      emoji: '⛏️',
      blurb: 'Gold Rush boomtown at the head of the Inside Passage.',
      hasAirport: false,
      accessibleByRoad: false,
    ),
    AlaskaCity(
      id: 'kodiak',
      name: 'Kodiak',
      region: 'Southwest',
      lat: 57.7900,
      lng: -152.4072,
      emoji: '🐻',
      blurb: 'Giant bears and a major fishing fleet, ferry/air only.',
      hasAirport: true,
      accessibleByRoad: false,
    ),
    AlaskaCity(
      id: 'cordova',
      name: 'Cordova',
      region: 'Southcentral',
      lat: 60.5430,
      lng: -145.7567,
      emoji: '🦢',
      blurb: 'No road to the outside — ferry or fly into the Copper River delta.',
      hasAirport: true,
      accessibleByRoad: false,
    ),
    AlaskaCity(
      id: 'utqiagvik',
      name: 'Utqiaġvik (Barrow)',
      region: 'Arctic',
      lat: 71.2906,
      lng: -156.7886,
      emoji: '🧊',
      blurb: 'The northernmost town in the U.S. — fly-in only.',
      hasAirport: true,
      accessibleByRoad: false,
    ),
  ];

  static AlaskaCity? byId(String id) {
    for (final c in cities) {
      if (c.id == id) return c;
    }
    return null;
  }

  static List<AlaskaCity> get airportCities =>
      cities.where((c) => c.hasAirport).toList();
}
