import '../models/lake.dart';

/// Anchorage-bowl fishing lakes. Species lists follow the ADF&G stocking
/// program; depths and chart shapes are approximate — check current ADF&G
/// regulations and stocking reports before you fish.
class LakesData {
  LakesData._();

  // Shared bait kits — these lakes are stocked with the same core species.
  static const List<String> _rainbowBaits = [
    'Mepps #2 spinner',
    'Bead-head nymphs',
    'Salmon eggs',
    'Dough bait (check bait regs)',
  ];
  static const List<String> _kingBaits = [
    'Small silver spoons',
    'Smolt-pattern streamers',
    'Ice jigs tipped w/ shrimp',
  ];
  static const List<String> _charBaits = [
    'Small white jigs',
    'Egg patterns',
    'Shrimp under a bobber',
  ];
  static const List<String> _graylingBaits = [
    'Parachute Adams #14',
    'Elk Hair Caddis #14–16',
    'Micro spinners',
  ];

  static const LakeSpecies _rainbow = LakeSpecies(
    name: 'Rainbow Trout',
    emoji: '🌈',
    stocked: true,
    baits: _rainbowBaits,
    tip: 'Cruise the drop-off edges morning and evening; slow-retrieve spinners just off the weedline.',
  );
  static const LakeSpecies _king = LakeSpecies(
    name: 'Landlocked King Salmon',
    emoji: '👑',
    stocked: true,
    baits: _kingBaits,
    tip: 'Schools hang over the deepest basin — count your lure down and vary the depth until you connect.',
  );
  static const LakeSpecies _char = LakeSpecies(
    name: 'Arctic Char',
    emoji: '🐠',
    stocked: true,
    baits: _charBaits,
    tip: 'Char love the coldest water in the lake — fish deep midsummer, shallow right after ice-out.',
  );
  static const LakeSpecies _grayling = LakeSpecies(
    name: 'Arctic Grayling',
    emoji: '🪶',
    stocked: true,
    baits: _graylingBaits,
    tip: 'Watch for surface rises on calm evenings — grayling rarely refuse a well-drifted dry fly.',
  );

  static const List<Lake> lakes = [
    Lake(
      id: 'jewel',
      name: 'Jewel Lake',
      area: 'Sand Lake neighborhood, Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 83584201).
      lat: 61.1397,
      lng: -149.9632,
      surfaceAcres: 27,
      maxDepthFt: 18,
      blurb:
          'Anchorage\'s classic family fishing hole — stocked hard, easy bank access, a dock, and a reliable winter ice bite.',
      access: 'Jewel Lake Park: parking, dock, ADA access',
      species: [_rainbow, _king, _char],
      tactics: [
        'The dock drop-off is the most consistent spot on the lake.',
        'Ice season: glow jigs at first light, 8–12 ft of water.',
        'Summer kings suspend over the deep hole — troll tiny spoons.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.1342, 0.8822], [0.1552, 0.9272], [0.1987, 0.9885], [0.2165, 0.9902],
        [0.2706, 0.9957], [0.2981, 0.9986], [0.3858, 0.9981], [0.4016, 0.9966],
        [0.4294, 0.9978], [0.4483, 1.0], [0.4672, 0.9897], [0.4794, 0.9854],
        [0.546, 0.9621], [0.5995, 0.9465], [0.7317, 0.9086], [0.7961, 0.8762],
        [0.8394, 0.8372], [0.8526, 0.7778], [0.8658, 0.6902], [0.8424, 0.5966],
        [0.8274, 0.5695], [0.7871, 0.4975], [0.7287, 0.4063], [0.678, 0.3215],
        [0.6656, 0.3007], [0.6613, 0.2565], [0.6591, 0.2001], [0.6356, 0.1506],
        [0.6458, 0.0798], [0.5959, 0.024], [0.5712, 0.0], [0.4799, 0.0006],
        [0.3855, 0.0234], [0.3338, 0.0426], [0.3163, 0.1026], [0.2905, 0.1476],
        [0.2875, 0.1926], [0.2959, 0.2407], [0.2911, 0.3157], [0.2923, 0.4183],
        [0.2869, 0.4933], [0.2298, 0.6067], [0.2027, 0.6686], [0.1709, 0.7418],
        [0.1498, 0.7952], [0.1348, 0.8438],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'delong',
      name: 'DeLong Lake',
      area: 'Jewel Lake Road, Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 182788865).
      lat: 61.1625,
      lng: -149.9574,
      surfaceAcres: 21,
      maxDepthFt: 21,
      blurb:
          'A quieter alternative to Jewel with a deeper basin, grayling in the mix, and a nice loop trail.',
      access: 'DeLong Lake Park: parking, trail, canoe launch',
      species: [_rainbow, _grayling, _king],
      tactics: [
        'Grayling cruise the north shoreline shallows on summer evenings.',
        'The deep hole is mid-lake, slightly toward the outlet — jig vertically through the ice.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.0, 0.8549], [0.2067, 0.8681], [0.4442, 0.7166], [0.7138, 0.6516],
        [0.9261, 0.4767], [0.8618, 0.2618], [0.7787, 0.1597], [0.6738, 0.1166],
        [0.5146, 0.2102], [0.3685, 0.2664], [0.2948, 0.3033], [0.2555, 0.3583],
        [0.1872, 0.4212], [0.1654, 0.4645], [0.1545, 0.5363], [0.1652, 0.5869],
        [0.1304, 0.6697], [0.094, 0.6992], [0.0873, 0.7743], [0.0744, 0.8308],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'sand',
      name: 'Sand Lake',
      area: 'Southwest Anchorage',
      // Centroid + outline sourced from OpenStreetMap (relation 20307481).
      lat: 61.1511,
      lng: -149.9659,
      surfaceAcres: 75,
      maxDepthFt: 36,
      blurb:
          'The deepest lake in the Anchorage bowl — big rainbows winter over here, and the deep basin holds fish all summer.',
      access: 'Public access off Sand Lake Road; much of the shore is private',
      accessNote: 'Respect private property — use the public access point.',
      species: [_rainbow, _char],
      tactics: [
        'Depth is your friend midsummer — fish 20+ ft when the shallows warm.',
        'A float tube or canoe opens up the lake; bank access is limited.',
        'Holdover rainbows run bigger here than any city lake.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.0, 0.4937], [0.1307, 0.6068], [0.3293, 0.631], [0.3818, 0.5597],
        [0.4901, 0.5052], [0.508, 0.5547], [0.5414, 0.7361], [0.5595, 0.5237],
        [0.6877, 0.4704], [0.7979, 0.3953], [0.9802, 0.6556], [0.9466, 0.5302],
        [0.8539, 0.3702], [0.8692, 0.2297], [0.7362, 0.192], [0.6129, 0.2401],
        [0.4929, 0.299], [0.327, 0.3522], [0.2153, 0.4411], [0.1275, 0.4635],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'little-campbell',
      name: 'Little Campbell Lake',
      area: 'Kincaid Park, Anchorage',
      lat: 61.1506,
      lng: -150.0469,
      surfaceAcres: 12,
      maxDepthFt: 16,
      blurb:
          'Tucked into Kincaid Park\'s forest — feels like a wilderness lake ten minutes from the airport. Watch for moose.',
      access: 'Kincaid Park: Raspberry Road entrance, short walk in',
      species: [_rainbow, _king],
      tactics: [
        'Fish the lily-pad edges with unweighted flies in June.',
        'A packraft or canoe beats the brushy banks.',
      ],
      outline: [
        [0.25, 0.20], [0.50, 0.10], [0.75, 0.20], [0.88, 0.42],
        [0.80, 0.66], [0.60, 0.82], [0.55, 0.92], [0.38, 0.88],
        [0.18, 0.72], [0.12, 0.46],
      ],
      deepPoint: [0.50, 0.42],
    ),
    Lake(
      id: 'goose',
      name: 'Goose Lake',
      area: 'UAA / Northeast Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 71432763).
      lat: 61.1950,
      lng: -149.8201,
      surfaceAcres: 19,
      maxDepthFt: 9,
      blurb:
          'Shallow, warm, and right next to the university — a swim beach in summer and a sneaky-good early-season trout lake.',
      access: 'Goose Lake Park: parking, beach, paddleboat rentals',
      species: [_rainbow, _king],
      tactics: [
        'Best right after ice-out and again in fall — midsummer it warms and the bite slows.',
        'Shallow bowl means long casts from the beach reach fish.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.0, 0.6394], [0.2091, 0.8289], [0.3284, 0.8949], [0.3842, 0.957],
        [0.478, 0.9837], [0.6244, 0.9224], [0.6669, 0.8265], [0.7591, 0.5726],
        [0.8693, 0.4578], [0.9614, 0.3376], [0.9984, 0.1741], [0.9417, 0.0145],
        [0.8551, 0.0585], [0.7843, 0.097], [0.6307, 0.1395], [0.4685, 0.1654],
        [0.2812, 0.215], [0.1465, 0.2291], [0.0772, 0.3124], [0.0346, 0.4398],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'cheney',
      name: 'Cheney Lake',
      area: 'Northeast Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 59020753).
      lat: 61.2024,
      lng: -149.7603,
      surfaceAcres: 25,
      maxDepthFt: 12,
      blurb:
          'A neighborhood gem with a paved path, fishing dock, and steady stocking — perfect for kids\' first trout.',
      access: 'Cheney Lake Park: parking, dock, paved loop',
      species: [_rainbow, _char],
      tactics: [
        'The dock and the inlet corner produce all season.',
        'Light line and small hooks — these fish see plenty of pressure.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.264, 0.7394], [0.3072, 0.8597], [0.3272, 0.8975], [0.3414, 0.9693],
        [0.4687, 0.9938], [0.5013, 0.8722], [0.5796, 0.6221], [0.6084, 0.579],
        [0.659, 0.2395], [0.7222, 0.1168], [0.6543, 0.029], [0.5937, 0.0609],
        [0.5562, 0.135], [0.5332, 0.1215], [0.4788, 0.0012], [0.4338, 0.0582],
        [0.4026, 0.0965], [0.3976, 0.3808], [0.3908, 0.4873], [0.3231, 0.565],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'mirror',
      name: 'Mirror Lake',
      area: 'Chugiak',
      // Centroid + outline sourced from OpenStreetMap (way 257882089).
      lat: 61.4256,
      lng: -149.4147,
      surfaceAcres: 64,
      maxDepthFt: 33,
      blurb:
          'A deep, clear lake off the Glenn Highway with a true three-species fishery and a strong ice-fishing following.',
      access: 'Mirror Lake Park: parking, beach, picnic sites',
      species: [_rainbow, _char, _grayling],
      tactics: [
        'Char go deep in summer — 25 ft+ over the main basin.',
        'One of the area\'s best early-ice lakes; the bite is hot in December.',
        'Grayling sip dries along the highway-side shallows.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.0487, 0.8713], [0.1722, 0.981], [0.2758, 0.9559], [0.2944, 0.9919],
        [0.3161, 0.9241], [0.4084, 0.9485], [0.65, 0.7317], [0.8156, 0.6057],
        [0.9459, 0.5217], [0.9052, 0.3211], [0.821, 0.1924], [0.7192, 0.0921],
        [0.7491, 0.0027], [0.6486, 0.0813], [0.54, 0.1369], [0.3487, 0.1179],
        [0.2455, 0.2425], [0.238, 0.4158], [0.2034, 0.6111], [0.1288, 0.7317],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'beach',
      name: 'Beach Lake',
      area: 'Chugiak',
      // Centroid + outline sourced from OpenStreetMap (way 183249120).
      lat: 61.4046,
      lng: -149.5595,
      surfaceAcres: 89,
      maxDepthFt: 14,
      blurb:
          'Big, quiet water in the Chugiak woods with grayling on top and rainbows below — and room to spread out.',
      access: 'Beach Lake Park: parking, trails, hand launch',
      species: [_rainbow, _grayling],
      tactics: [
        'Wind matters on this open lake — fish the calm lee shore.',
        'Evening caddis hatches bring every grayling in the lake to the surface.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.0847, 0.7246], [0.151, 0.9116], [0.2067, 0.9195], [0.3756, 0.9604],
        [0.5513, 0.9863], [0.655, 0.9403], [0.7271, 0.8425], [0.8048, 0.7016],
        [0.8433, 0.5945], [0.8635, 0.4622], [0.9085, 0.3307], [0.9028, 0.168],
        [0.8484, 0.0997], [0.7431, 0.0017], [0.6147, 0.0172], [0.5283, 0.0575],
        [0.3709, 0.1804], [0.2806, 0.2789], [0.174, 0.4572], [0.1193, 0.5463],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'otter',
      name: 'Otter Lake',
      area: 'JBER, Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 28629986).
      lat: 61.2898,
      lng: -149.7363,
      surfaceAcres: 118,
      maxDepthFt: 16,
      blurb:
          'A productive base lake with rainbows, grayling, and char — worth the recreation-access paperwork.',
      access: 'On Joint Base Elmendorf-Richardson',
      accessNote: 'JBER recreational access pass required for civilians (iSportsman).',
      species: [_rainbow, _grayling, _char],
      tactics: [
        'Less pressure than city lakes — the fish are noticeably less picky.',
        'The weedy south end fishes best from a canoe or float tube.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.0237, 0.6719], [0.2102, 0.7606], [0.4217, 0.909], [0.4256, 0.9407],
        [0.5336, 0.9795], [0.5848, 0.9737], [0.6199, 0.8652], [0.7162, 0.5913],
        [0.8967, 0.5255], [0.9275, 0.3743], [0.9763, 0.221], [0.8679, 0.2016],
        [0.7747, 0.1469], [0.8354, 0.0896], [0.7742, 0.0011], [0.661, 0.0318],
        [0.5426, 0.1382], [0.4031, 0.2253], [0.2544, 0.4016], [0.1766, 0.5189],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'lower-fire',
      name: 'Lower Fire Lake',
      area: 'Eagle River',
      // Centroid + outline sourced from OpenStreetMap (relation 3522417).
      lat: 61.3530,
      lng: -149.5457,
      surfaceAcres: 61,
      maxDepthFt: 25,
      blurb:
          'Eagle River\'s hometown lake — a deep little bowl with stocked rainbows and char and a fast ice-up in early winter.',
      access: 'Public access off the Old Glenn Highway',
      species: [_rainbow, _char],
      tactics: [
        'The basin is small — find the deep hole and you\'ve found the fish.',
        'Early winter: safe ice often comes a week before Anchorage lakes.',
      ],
      // Real shoreline outline (from OSM), normalized to 0-1.
      outline: [
        [0.1754, 0.9209], [0.3173, 0.9882], [0.4556, 0.8168], [0.4973, 0.6718],
        [0.5718, 0.5759], [0.6548, 0.5354], [0.7359, 0.3983], [0.7384, 0.2965],
        [0.7602, 0.1597], [0.8025, 0.0443], [0.7318, 0.048], [0.7063, 0.0077],
        [0.6583, 0.0662], [0.5551, 0.0827], [0.4741, 0.15], [0.4635, 0.2648],
        [0.4191, 0.3409], [0.4114, 0.4794], [0.3088, 0.6847], [0.2449, 0.8075],
      ],
      deepPoint: [0.5, 0.5],
    ),
  ];
}
