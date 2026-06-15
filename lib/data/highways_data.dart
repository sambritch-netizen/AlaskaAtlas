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
      slug: 'dalton-highway',
      name: 'Dalton Highway',
      route: 'AK-11',
      color: Color(0xFFFFB300),
    ),
    Highway(
      slug: 'steese-highway',
      name: 'Steese Highway',
      route: 'AK-6',
      color: Color(0xFF3949AB),
    ),
    Highway(
      slug: 'taylor-highway',
      name: 'Taylor Highway',
      route: 'AK-5',
      color: Color(0xFF7CB342),
    ),
    Highway(
      slug: 'denali-highway',
      name: 'Denali Highway',
      route: 'AK-8',
      color: Color(0xFF00897B),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Paxson (Richardson Hwy Junction)',
          emoji: '🔀',
          lat: 63.0293,
          lng: -145.4962,
          description:
              'Eastern terminus and Milepost 0 of the Denali Highway, where it meets the Richardson Highway. Paxson Lodge is the last fuel before MacLaren River Lodge, 42 miles west.',
        ),
        HighwayStop(
          mile: 16,
          name: 'Swede Lake Area',
          emoji: '🦌',
          lat: 63.0402,
          lng: -145.8659,
          description:
              'Swede Lake Trailhead on the south side of the highway, within the Tangle Lakes Archaeological District. Rolling tundra and scattered lakes make good spot-and-stalk caribou country when the Nelchina herd is moving through GMU 13.',
        ),
        HighwayStop(
          mile: 20,
          name: 'Tangle Lakes / Tangle River Inn',
          emoji: '⛽',
          lat: 63.0523,
          lng: -145.9835,
          description:
              'A chain of clear lakes straddling the road. Tangle River Inn offers fuel, food, and rooms, and is also a put-in for the Delta Wild and Scenic River canoe route.',
        ),
        HighwayStop(
          mile: 21,
          name: 'Pavement Ends',
          emoji: '🚧',
          lat: 63.0471,
          lng: -146.0104,
          description:
              'The first 21 miles west of Paxson are paved. From here the route is chip-seal and gravel most of the way to Cantwell, with wide views of the Alaska Range opening up.',
        ),
        HighwayStop(
          mile: 25,
          name: 'Tangle Lakes Archaeological District',
          emoji: '🏺',
          lat: 63.0744,
          lng: -146.1120,
          description:
              'One of the densest concentrations of prehistoric sites in Alaska, spanning roughly Milepost 15 to 37 on both sides of the highway. Surface collection and digging are prohibited — respect closure signs.',
        ),
        HighwayStop(
          mile: 37,
          name: 'MacLaren Summit',
          emoji: '⛰️',
          lat: 63.0886,
          lng: -146.4356,
          description:
              'At 4,086 ft, the second-highest highway pass in Alaska. Alpine tundra benches hold caribou; rocky basins above hold Dall sheep. Popular glassing pullouts near the summit.',
        ),
        HighwayStop(
          mile: 42,
          name: 'MacLaren River Lodge',
          emoji: '⛽',
          lat: 63.1189,
          lng: -146.5388,
          description:
              'One of just a handful of fuel, food, and lodging stops on the highway. Fills up fast in caribou season — call ahead for rooms or fuel.',
        ),
        HighwayStop(
          mile: 55,
          name: 'High Tundra & Sheep Country',
          emoji: '🐏',
          lat: 63.0431,
          lng: -146.8637,
          description:
              'The long stretch between MacLaren River Lodge and Alpine Creek Lodge runs through open alpine tundra with eastern Alaska Range peaks to the north. No services for 25+ miles — carry extra fuel.',
        ),
        HighwayStop(
          mile: 80,
          name: 'Susitna River Bridge',
          emoji: '🌉',
          lat: 63.1044,
          lng: -147.5269,
          description:
              'A roughly 1,000-foot bridge carries the highway over the upper Susitna River — a small, clear headwaters stream here, and a handy landmark for orienting on GMU 13 maps.',
        ),
        HighwayStop(
          mile: 82,
          name: 'Clearwater Creek',
          emoji: '🎣',
          lat: 63.1338,
          lng: -147.5389,
          description:
              'Clearwater drainage crossing near Clearwater Mountain Lodge, popular with grayling anglers and a common pull-off for glassing hillsides for caribou movement in late summer.',
        ),
        HighwayStop(
          mile: 104,
          name: 'Brushkana Creek Campground',
          emoji: '🏕️',
          lat: 63.2843,
          lng: -148.0617,
          description:
              'BLM campground right on Brushkana Creek — grayling fishing in reach and a good base for the GMU 13E drainages to the north.',
        ),
        HighwayStop(
          mile: 135,
          name: 'Cantwell (Parks Hwy Junction)',
          emoji: '🔀',
          lat: 63.3905,
          lng: -148.9018,
          description:
              'Western terminus, meeting the Parks Highway. From here it\'s north to Healy/Denali Park or south to Talkeetna and Anchorage.',
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
