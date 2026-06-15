import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

import '../models/highway.dart';

/// The major named Alaska highways, in Milepost order of appearance — the
/// basis for a highway-by-highway walkthrough.
class HighwaysData {
  HighwaysData._();

  static const List<Highway> highways = [
    Highway(
      slug: 'seward-highway',
      name: 'Seward Highway',
      route: 'AK-1 / AK-9',
      color: Color(0xFFE53935),
    ),
    Highway(
      slug: 'glenn-highway',
      name: 'Glenn Highway',
      route: 'AK-1',
      color: Color(0xFFFB8C00),
    ),
    Highway(
      slug: 'parks-highway',
      name: 'George Parks Highway',
      route: 'AK-3',
      color: Color(0xFF8E24AA),
    ),
    Highway(
      slug: 'sterling-highway',
      name: 'Sterling Highway',
      route: 'AK-1',
      color: Color(0xFF43A047),
    ),
    Highway(
      slug: 'richardson-highway',
      name: 'Richardson Highway',
      route: 'AK-2 / AK-4',
      color: Color(0xFF1E88E5),
    ),
    Highway(
      slug: 'alaska-highway',
      name: 'Alaska Highway',
      route: 'AK-2',
      color: Color(0xFFD81B60),
    ),
    Highway(
      slug: 'tok-cutoff',
      name: 'Tok Cutoff',
      route: 'AK-1',
      color: Color(0xFF6D4C41),
    ),
    Highway(
      slug: 'denali-highway',
      name: 'Denali Highway',
      route: 'AK-8',
      color: Color(0xFF00897B),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Cantwell (Parks Hwy Junction)',
          emoji: '🔀',
          lat: 63.3925,
          lng: -148.9072,
          description:
              'Western end of the Denali Highway. Last reliable fuel and groceries before MacLaren River Lodge, 43 miles out.',
        ),
        HighwayStop(
          mile: 13,
          name: 'Brushkana Creek Campground',
          emoji: '🏕️',
          lat: 63.3485,
          lng: -148.3842,
          description:
              'Small BLM campground right on Brushkana Creek — grayling fishing in reach and a good base for the GMU 13E drainages to the north.',
        ),
        HighwayStop(
          mile: 21,
          name: 'Pavement Ends',
          emoji: '🚧',
          lat: 63.3214,
          lng: -148.0625,
          description:
              'Maintained gravel begins here for the rest of the route. Wide views of the Alaska Range open up, with Denali visible from pullouts on clear days.',
        ),
        HighwayStop(
          mile: 36,
          name: 'Clearwater Creek',
          emoji: '🎣',
          lat: 63.2706,
          lng: -147.4591,
          description:
              'Clearwater drainage crossing popular with grayling anglers, and a common pull-off for glassing hillsides for caribou movement in late summer.',
        ),
        HighwayStop(
          mile: 42,
          name: 'Susitna River Bridge',
          emoji: '🌉',
          lat: 63.2503,
          lng: -147.2180,
          description:
              'The road crosses the upper Susitna River — a small, clear headwaters stream here, and a handy landmark for orienting on GMU 13 maps.',
        ),
        HighwayStop(
          mile: 43,
          name: 'MacLaren River Lodge',
          emoji: '⛽',
          lat: 63.2469,
          lng: -147.1774,
          description:
              'The only fuel, food, and lodging between Cantwell and Paxson. Fills up fast in caribou season — call ahead for rooms or fuel.',
        ),
        HighwayStop(
          mile: 47,
          name: 'MacLaren Summit',
          emoji: '⛰️',
          lat: 63.2333,
          lng: -147.0167,
          description:
              'At 4,086 ft, the highest point on the Alaska highway system. Alpine tundra benches hold caribou; rocky basins above hold Dall sheep. Popular glassing pullouts near the summit.',
        ),
        HighwayStop(
          mile: 55,
          name: 'Tangle Lakes / Tangle River Inn',
          emoji: '⛽',
          lat: 63.2136,
          lng: -146.8782,
          description:
              'A chain of clear lakes straddling the road. Tangle River Inn offers fuel, food, and rooms — the last services on the highway. Also a put-in for the Delta Wild and Scenic River canoe route.',
        ),
        HighwayStop(
          mile: 65,
          name: 'Tangle Lakes Archaeological District',
          emoji: '🏺',
          lat: 63.1890,
          lng: -146.7051,
          description:
              'One of the densest concentrations of prehistoric sites in Alaska. Surface collection and digging are prohibited — respect closure signs.',
        ),
        HighwayStop(
          mile: 79,
          name: 'Swede Lake Area',
          emoji: '🦌',
          lat: 63.1545,
          lng: -146.4628,
          description:
              'Rolling tundra and scattered lakes. Good spot-and-stalk caribou country when the Nelchina herd is moving through GMU 13 — glass before committing to the walk.',
        ),
        HighwayStop(
          mile: 97,
          name: 'High Tundra & Sheep Country',
          emoji: '🐏',
          lat: 63.1102,
          lng: -146.1509,
          description:
              'The longest stretch of true alpine tundra on the highway, with eastern Alaska Range peaks to the north. No services for 25+ miles either direction — carry extra fuel.',
        ),
        HighwayStop(
          mile: 135,
          name: 'Paxson (Richardson Hwy Junction)',
          emoji: '🔀',
          lat: 63.0167,
          lng: -145.4933,
          description:
              'Eastern terminus, meeting the Richardson Highway. From here it\'s north to Delta Junction/Fairbanks or south to Glennallen and the Glenn Highway.',
        ),
      ],
    ),
  ];
}

/// Loads highway routes from bundled GeoJSON
/// (`assets/highways/highways.geojson`).
///
/// Each route is traced from the Alaska DOT&PF Highway System centerlines
/// (AHS_AKDOT, gis.data.alaska.gov), simplified to one continuous line per
/// highway, so the path follows the actual roadway end-to-end.
class HighwayLoader {
  HighwayLoader._();

  static List<HighwaySegment>? _cache;

  static Future<List<HighwaySegment>> load() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/highways/highways.geojson');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final features =
        (json['features'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

    final segments = <HighwaySegment>[];
    for (final f in features) {
      final props = (f['properties'] as Map?) ?? const {};
      final geom = f['geometry'] as Map<String, dynamic>?;
      if (geom == null || geom['type'] != 'LineString') continue;
      final coords = (geom['coordinates'] as List?) ?? const [];

      final colorHex = props['color'] as String?;
      final color = colorHex != null
          ? Color(int.parse(colorHex, radix: 16))
          : const Color(0xFFE53935);

      segments.add(HighwaySegment(
        slug: props['slug'] as String? ?? '',
        name: props['name'] as String? ?? '',
        route: props['route'] as String? ?? '',
        color: color,
        points: [
          for (final pt in coords)
            LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()),
        ],
      ));
    }
    _cache = segments;
    return segments;
  }
}
