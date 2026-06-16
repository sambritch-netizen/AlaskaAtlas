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
      // Centroid + outline sourced from OpenStreetMap (way 28609293).
      lat: 61.1614,
      lng: -150.0243,
      surfaceAcres: 10,
      maxDepthFt: 16,
      blurb:
          'Tucked into Kincaid Park\'s forest — feels like a wilderness lake ten minutes from the airport. Watch for moose.',
      access: 'Kincaid Park: Raspberry Road entrance, short walk in',
      species: [_rainbow, _king],
      tactics: [
        'Fish the lily-pad edges with unweighted flies in June.',
        'A packraft or canoe beats the brushy banks.',
      ],
      // Real shoreline outline (from OSM way 28609293), normalized to 0-1.
      outline: [
        [0.2187, 0.0419], [0.0453, 0.0912], [0.0264, 0.1811], [0.2339, 0.3299],
        [0.2414, 0.4262], [0.1999, 0.5258], [0.0603, 0.6221], [0.0, 0.6917],
        [0.049, 0.8105], [0.1396, 0.8876], [0.2075, 0.9786], [0.4186, 1.0],
        [0.6487, 0.9764], [0.7694, 0.894], [0.8448, 0.7656], [1.0, 0.6849],
        [0.9995, 0.6061], [0.9577, 0.4891], [0.9882, 0.3727], [0.9397, 0.2042],
        [0.8564, 0.1395], [0.8034, 0.1094], [0.7053, 0.0334], [0.6654, 0.0196],
        [0.5829, 0.0094], [0.478, 0.0],
      ],
      deepPoint: [0.5, 0.5],
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
    Lake(
      id: 'taku',
      name: 'Taku Lake',
      area: 'Taku-Campbell, East Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 29350953).
      lat: 61.1502,
      lng: -149.8822,
      surfaceAcres: 12,
      maxDepthFt: 14,
      blurb:
          'A compact east-Anchorage lake tucked into the Taku-Campbell neighborhood — stocked rainbow trout with easy bank access and a small picnic area.',
      access: 'Taku Lake Park off Elmore Road; parking and bank access',
      species: [_rainbow, _char],
      tactics: [
        'Fish the deeper north end — that\'s where the trout hold after stocking.',
        'Dough bait and salmon eggs produce well from the bank year-round.',
        'Ice season: jig small glow lures in 8–12 ft near the deep center.',
      ],
      // Real shoreline outline (from OSM way 29350953), normalized to 0-1.
      outline: [
        [0.9921, 0.2284], [1.0, 0.3646], [0.9901, 0.3893], [0.9659, 0.4006],
        [0.9434, 0.4663], [0.9059, 0.5423], [0.8857, 0.6104], [0.8564, 0.7096],
        [0.8202, 0.7354], [0.7808, 0.7654], [0.7617, 0.8068], [0.7437, 0.8197],
        [0.7304, 0.8597], [0.7094, 0.8671], [0.6859, 0.8499], [0.6679, 0.8391],
        [0.6507, 0.8498], [0.6334, 0.8744], [0.5665, 0.9256], [0.5061, 0.9596],
        [0.4421, 0.9778], [0.3868, 0.9819], [0.3524, 0.96], [0.2439, 0.9452],
        [0.1799, 0.9704], [0.1324, 0.9966], [0.0679, 1.0], [0.0431, 0.9691],
        [0.0387, 0.9337], [0.0, 0.7039], [0.0048, 0.6668], [0.0182, 0.645],
        [0.0337, 0.6271], [0.0531, 0.6219], [0.1426, 0.5377], [0.2327, 0.4486],
        [0.4297, 0.2611], [0.5073, 0.1876], [0.5142, 0.1737], [0.5069, 0.1614],
        [0.5138, 0.1525], [0.5263, 0.1507], [0.5392, 0.1536], [0.558, 0.1369],
        [0.6052, 0.1003], [0.6872, 0.0262], [0.7208, 0.0049], [0.7463, 0.0],
        [0.7946, 0.0055], [0.8505, 0.0475], [0.9154, 0.1196], [0.9631, 0.1855],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'campbell',
      name: 'Campbell Lake',
      area: 'Sand Lake / Jewel Lake area, Anchorage',
      // Centroid + outline sourced from OpenStreetMap (relation 17075573).
      lat: 61.1329,
      lng: -149.9409,
      surfaceAcres: 130,
      maxDepthFt: 25,
      blurb:
          'Anchorage\'s biggest in-town lake — a man-made dam on lower Campbell Creek with rainbows, kings, and a winter ice fishery. Most shoreline is private; access is at the city park and via paddlecraft from the public launch.',
      access: 'Campbell Creek mouth public launch; bank access limited to public reaches',
      accessNote:
          'Much of the shoreline is private — respect adjacent property and use public access points only.',
      species: [_rainbow, _king, _char],
      tactics: [
        'Troll spoons through the basin in summer; the deep hole is mid-lake.',
        'Ice season: jig glow tubes 12–20 ft over the main basin.',
        'Watch the salmon-spawn windows — Campbell Creek\'s special regulations apply, see the Fishing tab.',
      ],
      // Real shoreline outline (from OSM relation 17075573, way 28590813), normalized to 0-1.
      outline: [
        [0.9494, 0.0], [0.9496, 0.3995], [1.0, 0.601], [0.9619, 0.6465],
        [0.8792, 0.6964], [0.7353, 0.7671], [0.6651, 0.7522], [0.5725, 0.688],
        [0.5272, 0.7121], [0.4871, 0.6192], [0.4091, 0.6413], [0.3241, 0.7973],
        [0.1564, 0.8757], [0.127, 1.0], [0.085, 0.965], [0.064, 0.8867],
        [0.0, 0.7713], [0.103, 0.5935], [0.1507, 0.4757], [0.2576, 0.5674],
        [0.288, 0.5195], [0.3269, 0.4661], [0.3579, 0.3745], [0.3696, 0.3435],
        [0.4037, 0.229], [0.4451, 0.161], [0.4664, 0.1791], [0.5063, 0.1835],
        [0.5287, 0.2105], [0.5696, 0.2687], [0.5853, 0.3203], [0.6665, 0.4741],
        [0.7048, 0.5588], [0.7442, 0.5254], [0.7855, 0.4971], [0.8707, 0.4274],
      ],
      deepPoint: [0.5, 0.5],
    ),
    Lake(
      id: 'sixmile',
      name: 'Sixmile Lake',
      area: 'Joint Base Elmendorf-Richardson, Anchorage',
      // Centroid + outline sourced from OpenStreetMap (way 165578895).
      lat: 61.2882,
      lng: -149.7969,
      surfaceAcres: 308,
      maxDepthFt: 40,
      blurb:
          'A long, narrow JBER lake stocked with rainbow trout and burbot. Base recreation permit required; civilian access via the Hillberg / Sixmile Lake recreation area.',
      access: 'JBER Hillberg & Sixmile Lake recreation areas — base recreation permit required',
      accessNote:
          'On Joint Base Elmendorf-Richardson — register for a JBER recreation permit at jber.recaccess.com before entering base lands.',
      species: [_rainbow, _char],
      tactics: [
        'Cast small spinners along the south shore drop-offs in spring.',
        'Winter burbot fishery from set lines per ADF&G rules.',
        'The deep basin is at the east end — troll spoons there in summer.',
      ],
      // Real shoreline outline (from OSM way 165578895), normalized to 0-1.
      outline: [
        [0.0394, 0.0], [0.0236, 0.0716], [0.0, 0.5226], [0.0219, 0.4624],
        [0.0459, 0.4435], [0.0684, 0.3534], [0.1581, 0.3847], [0.2359, 0.3478],
        [0.3149, 0.4249], [0.3518, 0.5092], [0.3841, 0.5359], [0.4395, 0.5901],
        [0.4651, 0.628], [0.487, 0.6522], [0.5199, 0.6644], [0.5444, 0.6813],
        [0.5958, 0.6958], [0.7789, 0.7491], [0.7097, 0.7757], [0.8113, 0.8012],
        [0.77, 0.8656], [0.9453, 0.9634], [1.0, 1.0], [0.8705, 0.9567],
        [0.7595, 0.8432], [0.6936, 0.7722], [0.5656, 0.6913], [0.6826, 0.6275],
        [0.5885, 0.5026], [0.4405, 0.265], [0.2391, 0.0894], [0.0821, 0.0419],
      ],
      deepPoint: [0.7, 0.5],
    ),
    Lake(
      id: 'birch',
      name: 'Birch Lake',
      area: 'Richardson Highway, MP 306 (southeast of Fairbanks)',
      // Centroid + outline sourced from OpenStreetMap (relation 11208732).
      lat: 64.3167,
      lng: -146.6615,
      surfaceAcres: 162,
      maxDepthFt: 24,
      blurb:
          'Interior Alaska\'s premier road-accessible stocked lake — landlocked king salmon, rainbow trout, Arctic char, and Arctic grayling at MP 306 of the Richardson Highway. Excellent winter ice fishery, including a state recreation site with picnic tables, restrooms, and boat launch.',
      access: 'Birch Lake State Recreation Site — Richardson Highway MP 306. Boat launch, parking, restrooms.',
      species: [_rainbow, _king, _char, _grayling],
      tactics: [
        'Troll small spoons and Mepps spinners 10–20 ft down for stocked rainbows and kings.',
        'Ice season: glow jigs 8–18 ft for trout, deeper for char.',
        'Cast small dries for grayling cruising the inlet stream area in summer.',
      ],
      // Real shoreline outline (from OSM relation 11208732), normalized to 0-1.
      outline: [
        [0.9634, 0.3271], [1.0, 0.2578], [0.9758, 0.1773], [0.9441, 0.1223],
        [0.9008, 0.082], [0.8538, 0.0528], [0.7762, 0.0177], [0.7158, 0.0048],
        [0.6504, 0.0], [0.6095, 0.0021], [0.5768, 0.0043], [0.5666, 0.0096],
        [0.514, 0.0467], [0.463, 0.0682], [0.4326, 0.0676], [0.4079, 0.0939],
        [0.3987, 0.1272], [0.3623, 0.1424], [0.3079, 0.1717], [0.2572, 0.2491],
        [0.2476, 0.2744], [0.2225, 0.2909], [0.1846, 0.32], [0.1337, 0.359],
        [0.0763, 0.439], [0.0, 0.733], [0.0383, 0.8185], [0.1349, 0.9073],
        [0.2399, 0.9707], [0.3101, 1.0], [0.4153, 0.9975], [0.482, 0.9504],
        [0.536, 0.8823], [0.5647, 0.8388], [0.5745, 0.8093], [0.6349, 0.8041],
      ],
      deepPoint: [0.5, 0.5],
    ),
  ];
}
