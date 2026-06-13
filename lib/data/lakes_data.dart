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
      lat: 61.1372,
      lng: -149.9379,
      surfaceAcres: 23,
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
      outline: [
        [0.22, 0.18], [0.45, 0.10], [0.68, 0.14], [0.85, 0.30],
        [0.90, 0.52], [0.82, 0.72], [0.62, 0.86], [0.40, 0.90],
        [0.20, 0.80], [0.10, 0.60], [0.10, 0.38],
      ],
      deepPoint: [0.52, 0.48],
    ),
    Lake(
      id: 'delong',
      name: 'DeLong Lake',
      area: 'Jewel Lake Road, Anchorage',
      lat: 61.1565,
      lng: -149.9608,
      surfaceAcres: 15,
      maxDepthFt: 21,
      blurb:
          'A quieter alternative to Jewel with a deeper basin, grayling in the mix, and a nice loop trail.',
      access: 'DeLong Lake Park: parking, trail, canoe launch',
      species: [_rainbow, _grayling, _king],
      tactics: [
        'Grayling cruise the north shoreline shallows on summer evenings.',
        'The deep hole is mid-lake, slightly toward the outlet — jig vertically through the ice.',
      ],
      outline: [
        [0.18, 0.30], [0.36, 0.12], [0.60, 0.08], [0.82, 0.18],
        [0.92, 0.40], [0.86, 0.62], [0.70, 0.78], [0.52, 0.92],
        [0.30, 0.88], [0.14, 0.70], [0.08, 0.50],
      ],
      deepPoint: [0.48, 0.45],
    ),
    Lake(
      id: 'sand',
      name: 'Sand Lake',
      area: 'Southwest Anchorage',
      lat: 61.1510,
      lng: -149.9444,
      surfaceAcres: 67,
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
      outline: [
        [0.15, 0.10], [0.35, 0.06], [0.50, 0.16], [0.58, 0.34],
        [0.74, 0.42], [0.88, 0.56], [0.86, 0.76], [0.66, 0.90],
        [0.44, 0.86], [0.34, 0.68], [0.22, 0.52], [0.10, 0.34],
      ],
      deepPoint: [0.62, 0.60],
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
      lat: 61.1949,
      lng: -149.8226,
      surfaceAcres: 42,
      maxDepthFt: 9,
      blurb:
          'Shallow, warm, and right next to the university — a swim beach in summer and a sneaky-good early-season trout lake.',
      access: 'Goose Lake Park: parking, beach, paddleboat rentals',
      species: [_rainbow, _king],
      tactics: [
        'Best right after ice-out and again in fall — midsummer it warms and the bite slows.',
        'Shallow bowl means long casts from the beach reach fish.',
      ],
      outline: [
        [0.20, 0.25], [0.42, 0.12], [0.66, 0.12], [0.86, 0.26],
        [0.90, 0.50], [0.78, 0.72], [0.56, 0.84], [0.34, 0.82],
        [0.14, 0.66], [0.10, 0.44],
      ],
      deepPoint: [0.50, 0.50],
    ),
    Lake(
      id: 'cheney',
      name: 'Cheney Lake',
      area: 'Northeast Anchorage',
      lat: 61.2042,
      lng: -149.7706,
      surfaceAcres: 17,
      maxDepthFt: 12,
      blurb:
          'A neighborhood gem with a paved path, fishing dock, and steady stocking — perfect for kids\' first trout.',
      access: 'Cheney Lake Park: parking, dock, paved loop',
      species: [_rainbow, _char],
      tactics: [
        'The dock and the inlet corner produce all season.',
        'Light line and small hooks — these fish see plenty of pressure.',
      ],
      outline: [
        [0.22, 0.22], [0.46, 0.10], [0.70, 0.16], [0.86, 0.34],
        [0.88, 0.58], [0.74, 0.78], [0.50, 0.88], [0.28, 0.82],
        [0.12, 0.62], [0.12, 0.40],
      ],
      deepPoint: [0.48, 0.50],
    ),
    Lake(
      id: 'mirror',
      name: 'Mirror Lake',
      area: 'Chugiak',
      lat: 61.4262,
      lng: -149.4119,
      surfaceAcres: 73,
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
      outline: [
        [0.16, 0.28], [0.34, 0.12], [0.58, 0.08], [0.80, 0.16],
        [0.92, 0.36], [0.88, 0.60], [0.72, 0.80], [0.50, 0.90],
        [0.28, 0.84], [0.12, 0.64], [0.08, 0.44],
      ],
      deepPoint: [0.55, 0.45],
    ),
    Lake(
      id: 'beach',
      name: 'Beach Lake',
      area: 'Chugiak',
      lat: 61.3956,
      lng: -149.4774,
      surfaceAcres: 80,
      maxDepthFt: 14,
      blurb:
          'Big, quiet water in the Chugiak woods with grayling on top and rainbows below — and room to spread out.',
      access: 'Beach Lake Park: parking, trails, hand launch',
      species: [_rainbow, _grayling],
      tactics: [
        'Wind matters on this open lake — fish the calm lee shore.',
        'Evening caddis hatches bring every grayling in the lake to the surface.',
      ],
      outline: [
        [0.14, 0.34], [0.30, 0.16], [0.52, 0.10], [0.76, 0.14],
        [0.90, 0.32], [0.88, 0.54], [0.74, 0.72], [0.54, 0.86],
        [0.32, 0.88], [0.14, 0.74], [0.08, 0.54],
      ],
      deepPoint: [0.50, 0.48],
    ),
    Lake(
      id: 'otter',
      name: 'Otter Lake',
      area: 'JBER, Anchorage',
      lat: 61.2806,
      lng: -149.6587,
      surfaceAcres: 75,
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
      outline: [
        [0.20, 0.16], [0.44, 0.08], [0.68, 0.14], [0.84, 0.30],
        [0.90, 0.52], [0.80, 0.74], [0.60, 0.88], [0.36, 0.90],
        [0.16, 0.76], [0.08, 0.52], [0.10, 0.32],
      ],
      deepPoint: [0.46, 0.46],
    ),
    Lake(
      id: 'lower-fire',
      name: 'Lower Fire Lake',
      area: 'Eagle River',
      lat: 61.3445,
      lng: -149.5384,
      surfaceAcres: 27,
      maxDepthFt: 25,
      blurb:
          'Eagle River\'s hometown lake — a deep little bowl with stocked rainbows and char and a fast ice-up in early winter.',
      access: 'Public access off the Old Glenn Highway',
      species: [_rainbow, _char],
      tactics: [
        'The basin is small — find the deep hole and you\'ve found the fish.',
        'Early winter: safe ice often comes a week before Anchorage lakes.',
      ],
      outline: [
        [0.24, 0.18], [0.48, 0.10], [0.72, 0.18], [0.86, 0.38],
        [0.84, 0.62], [0.68, 0.80], [0.46, 0.90], [0.26, 0.82],
        [0.12, 0.62], [0.12, 0.38],
      ],
      deepPoint: [0.50, 0.46],
    ),
  ];
}
