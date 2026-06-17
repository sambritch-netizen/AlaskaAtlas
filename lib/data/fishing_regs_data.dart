import '../models/fishing_regs.dart';

/// Sport-fishing regulation summaries by ADF&G region. Lists species,
/// seasons, and methods/means context — NOT the specific bag/length
/// limits, which can change mid-season by emergency order. For numeric
/// limits, anglers must consult the current ADF&G regulation booklet.
///
/// Sourced from the 2026 ADF&G Southcentral Alaska Sport Fishing
/// Regulations Summary (the 2026sc_sfregs_complete.pdf). Each
/// sub-region's "Inclusive Waters" definition, general methods/seasons,
/// per-water special regulations, and species presence match the
/// published booklet.
class FishingRegsData {
  FishingRegsData._();

  static const List<FishingRegion> regions = [
    FishingRegion(
      name: 'Northern Alaska Regulations',
      summary:
          'Covers the Tanana, Yukon, Kuskokwim, and Arctic drainages — '
          'grayling, sheefish, pike, and salmon waters from Fairbanks '
          'north and west.',
      comingSoon: true,
    ),
    FishingRegion(
      name: 'Southwest Alaska Regulations',
      summary:
          'Covers Bristol Bay, the Alaska Peninsula, the Aleutians, '
          'and Kodiak — the heart of Alaska\'s wild salmon and trophy '
          'rainbow fisheries.',
      comingSoon: true,
    ),
    FishingRegion(
      name: 'Southcentral Alaska Regulations',
      summary:
          'Covers everything draining into Cook Inlet and Prince William '
          'Sound — the Anchorage Bowl, Knik Arm, Susitna and West Cook '
          'Inlet drainages, and the Kenai Peninsula.',
      subRegions: _southcentral,
    ),
    FishingRegion(
      name: 'Southeast Alaska Regulations',
      summary:
          'Covers the Inside Passage from Ketchikan to Yakutat — steelhead '
          'streams, coastal cutthroat lakes, and the saltwater fisheries '
          'for king, coho, and halibut.',
      comingSoon: true,
    ),
  ];

  static const List<FishingSubRegion> _southcentral = [
    _westCookInlet,
    _susitna,
    _knikArm,
    _anchorageBowl,
  ];

  // Frequently-reused species combos.
  static const _salmonCombo = [
    FishSpecies.king,
    FishSpecies.coho,
    FishSpecies.sockeye,
    FishSpecies.pink,
    FishSpecies.chum,
  ];

  // ──────────────────────────────────────────────────────────────────
  // WEST COOK INLET
  // ──────────────────────────────────────────────────────────────────
  static const _westCookInlet = FishingSubRegion(
    name: 'West Cook Inlet',
    inclusiveWaters:
        'All waters draining into the west side of Cook Inlet between '
        'the Susitna River and Cape Douglas (excluding the Susitna '
        'River). Includes Kalgin Island.',
    generalSeasons: [
      'Fishing is open year-round for all species unless otherwise noted in special regulations.',
      'October 1 – December 31: All flowing waters of West Cook Inlet are closed to salmon fishing.',
      'King salmon fishing is closed in 2026 by emergency order.',
    ],
    generalMethods: [
      'Drainages between the Susitna River and the West Foreland — flowing waters:',
      '   • July 14 – August 31: bait and multiple hooks allowed.',
      '   • September 1 – July 13: only unbaited, artificial lures or flies allowed.',
      'Drainages from the West Foreland south to the southern tip of Chisik Island — flowing waters:',
      '   • May 16 – August 31: bait and multiple hooks allowed.',
      '   • September 1 – May 15: only unbaited, artificial lures or flies allowed.',
      'Drainages south of Chisik Island to Cape Douglas — flowing waters:',
      '   • May 16 – July 14: bait and multiple hooks allowed.',
      '   • July 15 – May 15: only unbaited, artificial lures or flies allowed.',
      'Live release of northern pike is prohibited — pike not retained must be killed.',
    ],
    waters: [
      FishingWater(
        name: 'Beluga River Drainage',
        notes:
            'Includes Coal Creek and tributaries of Beluga Lake.',
        species: _salmonCombo,
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon, including catch-and-release.',
        ],
      ),
      FishingWater(
        name: 'Chinitna River Drainage',
        species: [FishSpecies.king, FishSpecies.coho, FishSpecies.pink, FishSpecies.chum, FishSpecies.dolly],
        seasons: [
          'Clearwater Creek (including Roscoe Creek, up to ½ mile above the Chinitna confluence): closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Chuitna River Drainage',
        species: _salmonCombo,
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon — all king caught must be released.',
        ],
      ),
      FishingWater(
        name: 'Lewis River',
        species: _salmonCombo,
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon — all king caught must be released.',
        ],
      ),
      FishingWater(
        name: 'McNeil River',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.chum, FishSpecies.dolly],
        seasons: [
          'Within ½ mile of McNeil River Falls (≈1 mile upstream of McNeil Lagoon): closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Shelter Creek',
        species: [FishSpecies.coho, FishSpecies.pink],
        seasons: [
          'Upstream of ADF&G marker ≈1 mile above its mouth: closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Silver Salmon Creek',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.dolly],
        seasons: [
          'Within ½ mile of its outlet at Silver Salmon Lake: closed year-round to salmon fishing.',
        ],
      ),
      FishingWater(
        name: 'Silver Salmon Lake',
        species: [FishSpecies.dolly, FishSpecies.rainbow],
        seasons: ['Closed year-round to all salmon fishing.'],
      ),
      FishingWater(
        name: 'Theodore River Drainage',
        species: _salmonCombo,
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon — all king caught must be released.',
        ],
      ),
      FishingWater(
        name: 'Threemile Creek',
        notes:
            'Upstream of the Beluga–Tyonek Road culvert to Threemile/Tukhallah Lake.',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: [
          'Open year-round to species other than salmon.',
          'Closed year-round to all salmon fishing.',
        ],
      ),
      FishingWater(
        name: 'Threemile/Tukhallah Lake',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling, FishSpecies.pike],
        seasons: [
          'Open year-round to species other than salmon.',
          'Closed year-round to all salmon fishing.',
        ],
        methods: [
          'Live release of northern pike is prohibited.',
          'Ice-fishing for pike permitted with 5 attended lines per ADF&G rules.',
        ],
      ),
      FishingWater(
        name: 'Wolverine Creek',
        notes:
            'Includes Big River Lake within a 500-yard radius of the Wolverine Creek mouth. South Fork of Big River upstream of an island ≈1.25 miles above the South Fork confluence is closed to all sport fishing.',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.dolly],
        seasons: [
          'June 1 – July 31: fly-fishing-only waters.',
        ],
        methods: [
          'Snagging is prohibited.',
          'See page 6 of the ADF&G booklet for gear allowed in fly-fishing-only waters.',
        ],
      ),
      FishingWater(
        name: 'Chuitbuna Lake',
        notes:
            'Northern pike infested lake — special ice-fishing rules apply.',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.pike],
        methods: [
          'Live release of northern pike is prohibited.',
          'Ice fishing for pike with up to 5 attended lines; all other species must be released.',
        ],
      ),
    ],
  );

  // ──────────────────────────────────────────────────────────────────
  // SUSITNA RIVER DRAINAGES
  // ──────────────────────────────────────────────────────────────────
  static const _susitna = FishingSubRegion(
    name: 'Susitna River Drainages',
    inclusiveWaters:
        'All waters of the Susitna River drainage from its mouth upstream '
        'to its headwaters, broken into six management Units. Includes '
        'major sub-drainages: Alexander, Deshka, Yentna, Skwentna, '
        'Talkeetna, Chulitna, and the upper Susitna.',
    generalSeasons: [
      'Fishing is open year-round for all species unless otherwise noted in special regulations.',
      'King salmon fishing is closed in 2026 in most flowing waters by emergency order.',
    ],
    generalMethods: [
      'Methods/means vary heavily by Unit and by water — check each entry.',
      'Bait and multiple hooks are commonly restricted during early-season catch-and-release periods (typically April 15 – June 14) and during king salmon closures.',
      'Single-hook, artificial lure or fly is the default restriction in many tributaries outside the open-bait window.',
      'Live release of northern pike is prohibited throughout the drainage.',
    ],
    waters: [
      FishingWater(
        name: 'Alexander Creek Drainage',
        notes: 'Lower Susitna tributary; king salmon waters.',
        species: _salmonCombo,
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Deshka River Drainage',
        notes: 'One of the most popular king and coho fisheries in Southcentral.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'King salmon closed in 2026 by emergency order.',
          'Special weekend / time-of-day windows apply during open salmon periods — check current EOs.',
        ],
      ),
      FishingWater(
        name: 'Birch Creek',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
      ),
      FishingWater(
        name: 'Goose Creek',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
      ),
      FishingWater(
        name: 'Greys (196 Mile) Creek',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
      ),
      FishingWater(
        name: 'Kashwitna River Drainage',
        species: _salmonCombo,
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Little Willow Creek Drainage',
        species: _salmonCombo,
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Montana Creek Drainage',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Sheep Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
        methods: [
          'Only one unbaited, single-hook, artificial lure or fly is allowed in many sections — check the booklet.',
        ],
      ),
      FishingWater(
        name: 'Sunshine Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
      ),
      FishingWater(
        name: 'Trapper Creek Drainage',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Willow Creek Drainage',
        notes: 'Major road-accessible king and silver fishery.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Deception Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
      ),
      FishingWater(
        name: 'Clarence Lake',
        notes: 'Remote upper-Susitna lake with grayling and lake trout.',
        species: [FishSpecies.grayling, FishSpecies.lakeTrout, FishSpecies.burbot],
      ),
      FishingWater(
        name: 'Susitna River',
        notes:
            'Upper mainstem above the major tributaries; primarily a grayling, whitefish, and lake-trout fishery.',
        species: [
          FishSpecies.grayling,
          FishSpecies.lakeTrout,
          FishSpecies.whitefish,
          FishSpecies.burbot,
        ],
      ),
      FishingWater(
        name: 'Canyon Creek',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Talachulitna River Drainage',
        notes: 'Famous fly-water rainbow and silver fishery.',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        methods: [
          'Single-hook, artificial lure or fly is the default in most reaches; check the booklet for exact mileposts.',
        ],
      ),
      FishingWater(
        name: 'Fish Lake Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Lake Creek Drainage',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Peters Creek',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Clear (Chunilna) Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Fish Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Larson Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
      FishingWater(
        name: 'Byers Creek Drainage / Byers Lake',
        notes: 'Denali State Park; popular roadside lake.',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling, FishSpecies.lakeTrout, FishSpecies.burbot],
      ),
      FishingWater(
        name: 'East Fork Chulitna River Drainages',
        species: [FishSpecies.dolly, FishSpecies.grayling, FishSpecies.whitefish],
      ),
    ],
  );

  // ──────────────────────────────────────────────────────────────────
  // KNIK ARM
  // ──────────────────────────────────────────────────────────────────
  static const _knikArm = FishingSubRegion(
    name: 'Knik Arm',
    inclusiveWaters:
        'Bounded on the north by (but not including) Willow Creek '
        'Drainage, on the west by a line ½ mile east of the Susitna '
        'River, on the south by Cook Inlet and Knik Arm, and on the '
        'east by the Upper Susitna drainage upstream of its confluence '
        'with the Oshetna River. Includes the Matanuska and Knik River '
        'drainages.',
    generalSeasons: [
      'Open year-round for all species unless otherwise noted.',
      'King salmon fishing is closed in 2026 in fresh waters of Knik Arm by emergency order (except Eklutna Tailrace — see special regs).',
    ],
    generalMethods: [
      'Bait and multiple hooks are allowed unless restricted by special regulations.',
      'Northern pike and blackfish may be taken year-round with a spear or bow and arrow in flowing waters of the Palmer-Wasilla Zone.',
      'Live release of northern pike is prohibited.',
      'Ice fishing for northern pike permitted using 5 lines (attended, all other species released immediately) on listed pike-infested lakes.',
    ],
    waters: [
      FishingWater(
        name: 'Big, Mirror, and Flat Lakes',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.burbot, FishSpecies.pike, FishSpecies.otherFinfish],
        seasons: [
          'Closed year-round to all salmon fishing.',
          'Arctic char/Dolly Varden: catch-and-release only.',
          'Burbot: closed March 15 – April 30; open with limits the rest of the year.',
        ],
        methods: [
          'November 1 – April 30: only one unbaited, single-hook, artificial lure or fly allowed (including for burbot); chumming prohibited.',
          'Through the ice: two lines allowed, each with one single-hook only.',
          'Northern pike ice fishery rules apply — see general methods.',
        ],
      ),
      FishingWater(
        name: 'Bodenburg Creek',
        notes:
            'Includes Knik River waters within a 100-yard radius of the creek mouth.',
        species: [FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Closed year-round to all salmon fishing.',
          'April 15 – June 15: catch-and-release only for rainbow/steelhead.',
        ],
      ),
      FishingWater(
        name: 'Bonnie Lakes Connecting Stream',
        notes: 'From the outlet at Upper Bonnie Lake to the inlet of Lower Bonnie Lake.',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: ['July 1 – April 14: open to sport fishing.'],
      ),
      FishingWater(
        name: 'Cottonwood Creek Drainage',
        notes:
            'Retaining a bag of salmon closes you out for the day from any salmon waters.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'All lakes (including Wasilla Lake): closed year-round to salmon fishing.',
          'Mouth to 1 mile above Hayflats access road, June 15 – April 14: open to species other than king salmon, Saturdays/Sundays only, 5 a.m. – 10 p.m.',
          'Above the Hayflats markers: closed year-round to salmon; June 15 – April 14 open to species other than salmon.',
        ],
      ),
      FishingWater(
        name: 'Eklutna Tailrace',
        notes:
            'The one fresh-water Knik Arm exception where king salmon fishing is allowed.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Open year-round to king salmon within ½ mile of the Knik River confluence (to ADF&G marker 2 mi downstream).',
          'April 15 – June 15: rainbow/steelhead catch-and-release only.',
        ],
        methods: [
          'Retaining a king ≥20" closes you out for the day from any king waters.',
          'Annual limit is 5 king salmon.',
          'Youth-Only Fishery (anglers ≤15) on the 3rd Saturday of June and August, 6 a.m. – 6 p.m.',
        ],
      ),
      FishingWater(
        name: 'Fish Creek Drainage',
        notes: 'Retaining a bag of salmon closes you out of salmon waters for the day.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Mouth ↔ ¼ mile above Knik-Goose Bay Rd: Jan 1 – June 14 closed; June 15 – July 14 open (no kings); July 15 – 31 closed; Aug 1 – 2 youth-only; Aug 3 – 7 closed; Aug 8 – Dec 31 open (no kings).',
          '¼ mile above Knik-Goose Bay Rd → ¼ mile above Lewis Rd Bridge: closed year-round.',
          'Above Lewis Rd markers (incl. Meadow Creek): June 15 – April 14 open (no salmon).',
          'Fish Creek lakes: open year-round (no salmon).',
        ],
        methods: [
          'Open hours during the open salmon windows: 5 a.m. – 10 p.m. only.',
          'Youth-Only Fishery on the first Saturday and Sunday in August (anglers ≤15).',
        ],
      ),
      FishingWater(
        name: 'Jim Creek Drainage',
        notes:
            'Includes all Knik River waters downstream to within 100 yards of the Bodenburg Creek confluence.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Jan 1 – July 31: open to species other than king salmon.',
          'April 15 – June 15: catch-and-release only for rainbow/steelhead.',
          'August 1 – December 31: closed Mondays/Tuesdays; open Wed–Sun, 5 a.m. – 10 p.m.',
          'Upper Jim Creek (above Leaf Lake), Jim Lake, Leaf Lake, Mud Lake, McRoberts Creek: open year-round, no salmon.',
        ],
      ),
      FishingWater(
        name: 'Johnson Lake (near Palmer)',
        species: [],
        seasons: ['Closed year-round to all sport fishing.'],
      ),
      FishingWater(
        name: 'Little Susitna River Drainage',
        notes:
            'Major silver salmon road-fishery. King salmon fishing is closed in 2026 by emergency order.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.pike, FishSpecies.burbot],
        seasons: [
          'Mouth to Parks Highway: open year-round (no kings).',
          '  • August 6 – September 30: bait and multiple hooks allowed.',
          '  • October 1 – August 5: only unbaited, artificial lures or flies.',
          'Above the Parks Highway: closed year-round to salmon; June 15 – April 14 open (no salmon).',
          'Nancy Lake Creek drainage above ADF&G marker ¼ mile above its mouth: closed year-round to all salmon.',
          'Nancy Lake: closed year-round to burbot.',
        ],
        methods: [
          'No motorized boats unless 4-stroke or direct-injection 2-stroke.',
          'May 15 – July 13: fishing hours 6 a.m. – 11 p.m. only.',
          'A coho removed from the water must be retained.',
          'Above the Parks Highway: only one unbaited, single-hook, artificial lure or fly.',
          'Nancy Lake northern pike: Nov 1 – Mar 15 ice fishing, up to 5 lines, 8 a.m. – 5 p.m., attended; live release prohibited.',
        ],
      ),
      FishingWater(
        name: 'Long Lake (Kepler-Bradley Complex)',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: [
          'May 1 – October 31: open to sport fishing.',
          'Rainbow trout: catch-and-release only.',
        ],
        methods: ['Only one unbaited, single-hook, artificial lure or fly.'],
      ),
      FishingWater(
        name: 'Wasilla Creek Drainage',
        notes: 'Includes Rabbit Slough.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Mouth to Alaska Railroad Bridge (incl. lakes/ponds): June 15 – April 14, Sat/Sun only, 5 a.m. – 10 p.m.',
          'Above the Alaska Railroad Bridge: closed year-round to salmon; June 15 – April 14 open (no salmon).',
        ],
        methods: [
          'July 15 – August 15: motorized watercraft >3 HP prohibited on Saturdays/Sundays.',
          'Below the railroad bridge during open windows: bait and multiple hooks allowed.',
        ],
      ),
      FishingWater(
        name: 'Wishbone Lake (near Sutton)',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: [
          'May 1 – October 31: open to sport fishing.',
          'November 1 – April 30: closed to all sport fishing.',
          'Rainbow trout: catch-and-release only.',
        ],
        methods: ['Only one unbaited, single-hook, artificial lure or fly.'],
      ),
      FishingWater(
        name: 'Wolverine Lake Drainage (near Palmer)',
        notes:
            'From its confluence with Wolverine Creek upstream to and including Wolverine Lake.',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
      ),
    ],
  );

  // ──────────────────────────────────────────────────────────────────
  // ANCHORAGE BOWL
  // ──────────────────────────────────────────────────────────────────
  static const _anchorageBowl = FishingSubRegion(
    name: 'Anchorage Bowl',
    inclusiveWaters:
        'All waters draining into the east side of Knik Arm south of, '
        'and including, the Eklutna River drainage, and all waters '
        'draining into the north and west sides of Turnagain Arm, and '
        'all waters draining into the south side of Turnagain Arm east '
        'of, and including Ingram Creek.',
    generalSeasons: [
      'Open year-round for all species unless otherwise noted.',
      'King salmon fishing is closed in 2026 by emergency order — see Ship Creek for the one exception.',
    ],
    generalMethods: [
      'Bait and multiple hooks are allowed unless prohibited in special regulations.',
      'Stocked lakes have separate salmon/trout combo limits — see ADF&G "Stocked Waters" pages.',
      'Live release of northern pike is prohibited.',
    ],
    waters: [
      FishingWater(
        name: 'Campbell Creek Drainage',
        notes: 'From the mouth upstream — staged closures and gear restrictions vary reach-by-reach.',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'April 15 – June 14: closed to all sport fishing.',
          'June 15 – July 13: closed to salmon; open to other species.',
          'July 14 – Sept 30: open to coho salmon and other species.',
          'Oct 1 – Dec 31: closed to all salmon fishing; open to other species.',
          'Mouth to ADF&G markers under the Dimond Blvd Bridge (incl. Campbell Lake): closed year-round to all sport fishing.',
          'Above Piper Street forks: rainbow/steelhead catch-and-release only; only Arctic char/Dolly Varden may be kept.',
        ],
        methods: [
          'Bait and multiple hooks prohibited until August 1 by emergency order.',
          'July 14 – July 31: single-hook, artificial lure only; bait prohibited (by EO).',
          'Above Piper Street forks: only one unbaited, single-hook, artificial lure or fly.',
        ],
      ),
      FishingWater(
        name: 'Campbell Creek Youth-Only Fishery',
        notes:
            'From ADF&G markers under the Dimond Boulevard Bridge to the Old Seward Highway. Last Saturday & Sunday of June.',
        species: [FishSpecies.king],
        seasons: [
          '2026: catch-and-release only; bait and multiple hooks prohibited by EO.',
          'June 27 – 28, 2026, 6 a.m. – 10 p.m.; anglers 15 or younger only.',
        ],
        methods: [
          'Anglers 16+ may not sport fish in this reach during the fishery window.',
        ],
      ),
      FishingWater(
        name: 'Chester Creek Drainage',
        notes: 'Includes East and West Chester Lagoon and University Lake.',
        species: [FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Closed year-round to all salmon fishing.',
          'June 15 – April 14: open to species other than salmon.',
        ],
        methods: ['Rainbow/steelhead harvest record required for fish ≥20".'],
      ),
      FishingWater(
        name: 'Eagle River Drainage',
        notes:
            'King salmon closed in 2026 by emergency order. Mouth to Route Bravo Bridge on JBER closed year-round to all sport fishing.',
        species: [..._salmonCombo, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Route Bravo Bridge → Mile 7.4 markers (incl. waters within 100 yd of South Fork confluence): open year-round to species other than king salmon.',
          'May 1 – July 13: only one unbaited, single-hook, artificial lure with hook gap ≤ ½ inch (by EO).',
          'Above Mile 7.4 and the North Fork & tributaries: September 16 – May 31 open to species other than king salmon.',
        ],
        methods: [
          'JBER recreation permit required for waters on the base — see jber.recaccess.com.',
        ],
      ),
      FishingWater(
        name: 'South Fork Eagle River',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: [
          'Confluence with Eagle River → falls: closed year-round to all salmon fishing; open to species other than salmon.',
          'Above the falls: see general regulations.',
        ],
      ),
      FishingWater(
        name: 'Symphony Lake',
        notes: 'South Fork Eagle River headwaters — alpine lake.',
        species: [FishSpecies.rainbow, FishSpecies.grayling],
        seasons: [
          'July 1 – May 1: open to sport fishing.',
          'Rainbow trout: harvest record required for fish ≥20".',
        ],
      ),
      FishingWater(
        name: 'Eklutna River Drainage',
        notes:
            'Includes Eklutna Lake. The Eklutna Tailrace is a separate drainage (see Knik Arm).',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.dolly, FishSpecies.lakeTrout, FishSpecies.burbot],
        seasons: [
          'Mouth → Glenn Highway Bridge: open to species other than king, sockeye, and coho salmon.',
          'Above the Glenn Highway Bridge, Jan 1 – Sept 30: open to species other than king, sockeye, and coho.',
        ],
      ),
      FishingWater(
        name: 'Peters Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Mouth → Glenn Highway: open year-round to species other than king salmon.',
          'Above the Glenn Highway: open to species other than salmon; closed year-round to all salmon.',
        ],
      ),
      FishingWater(
        name: 'Sixmile Creek Drainage (JBER)',
        notes:
            'On Joint Base Elmendorf-Richardson — JBER recreation permit and base regulations also apply.',
        species: [FishSpecies.coho, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Mouth → ADF&G markers near the mouth: salt-water Cook Inlet general regulations apply.',
          'ADF&G markers → Lower Sixmile Lake: closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Ship Creek',
        notes:
            'Downtown Anchorage. The single Anchorage-bowl exception to the 2026 king closure.',
        species: [FishSpecies.king, FishSpecies.coho, FishSpecies.pink, FishSpecies.sockeye, FishSpecies.chum, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Mouth → 100 ft below Chugach power plant dam (cable): open year-round.',
          'May 15 – July 13: fishing hours 6 a.m. – 11 p.m. only.',
          'Cable → Elmendorf power plant dam: closed year-round.',
        ],
        methods: [
          'Single-hook, artificial lure only July 14 – July 31; bait prohibited (by EO).',
          'King salmon may not be removed from the water before release.',
          'Combined annual limit of 5 king salmon ≥20" from Cook Inlet salt, West Cook Inlet, Susitna, Knik Arm, Anchorage Bowl, Kenai River, and Kenai Peninsula.',
          'Youth-Only Fishery: Sat June 20, 2026, 6 a.m. – 11 p.m. (C Street Bridge → restaurant bridge); anglers 15 or younger only.',
        ],
      ),
      FishingWater(
        name: 'Potter Creek / Potter Marsh Drainage',
        notes:
            'Highly visible roadside marsh on the Seward Highway south of Anchorage.',
        species: [],
        seasons: ['Closed year-round to all sport fishing.'],
      ),
      FishingWater(
        name: 'Rabbit Creek Drainage',
        species: [FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Closed year-round to all salmon fishing.',
          'Mouth → Old Seward Highway: closed year-round to all sport fishing.',
          'Above the Old Seward Highway: open year-round to species other than salmon.',
        ],
      ),
      FishingWater(
        name: 'Indian Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Downstream of the Seward Highway: open year-round to species other than king salmon.',
          'Upstream of the Seward Highway: closed year-round to all salmon; Jan 1 – June 30 open to species other than salmon.',
        ],
      ),
      FishingWater(
        name: 'Bird Creek Drainage',
        notes: 'Roadside Turnagain Arm coho fishery.',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'January 1 – July 13: closed to all sport fishing.',
          'July 14 – December 31: open to species other than king salmon.',
        ],
        methods: [
          'Access note: legal public access is limited to the streambed upstream of ADF&G markers (private land begins ≈100 yd downstream of the Seward Highway Bridge).',
        ],
      ),
      FishingWater(
        name: 'Glacier Creek Drainage',
        notes: 'Includes California Creek.',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Open year-round to species other than salmon.',
          'Mouth → 25 yd above California Creek confluence: open to salmon other than king.',
          'Above that point, Jan 1 – Sept 30: open to salmon other than king.',
        ],
      ),
      FishingWater(
        name: 'California Creek Drainage',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Open year-round to species other than salmon.',
          'Confluence with Glacier Creek → 25 yd up: open to species other than king salmon.',
          'Above 25 yd marker, Jan 1 – Sept 30: open to salmon other than king.',
        ],
      ),
      FishingWater(
        name: 'Williwaw Creek',
        species: [FishSpecies.rainbow, FishSpecies.dolly, FishSpecies.grayling],
        seasons: [
          'Closed year-round to all salmon fishing.',
          'September 16 – June 30: open to species other than salmon.',
          'July 1 – September 15: closed to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Placer Creek Drainage (Bear Valley streams)',
        species: [FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Closed year-round to all salmon fishing.',
          'Open year-round to species other than salmon.',
        ],
      ),
      FishingWater(
        name: 'Placer River Drainage',
        notes: 'Includes Lower Explorer Creek and Skookum Creek.',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.dolly],
        seasons: [
          'Open year-round to species other than king salmon.',
          'Lower Explorer Creek above ADF&G markers near the Lower Explorer Pond confluence — Jan 1 – July 13: open to species other than king salmon.',
          'Skookum Creek above the Alaska Railroad Bridge — Jan 1 – July 13: open to species other than king salmon.',
        ],
      ),
      FishingWater(
        name: 'Portage Creek Drainage',
        notes: 'Includes Williwaw Creek and Placer Creek.',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.rainbow, FishSpecies.dolly],
        seasons: [
          'Excluding Lower Railroad Slough, Williwaw Creek, and Placer Creek: open year-round to species other than king salmon.',
          'Lower Railroad Slough waters: Jan 1 – July 13 open to species other than king salmon.',
        ],
      ),
      FishingWater(
        name: 'Twentymile River Drainage',
        notes: 'Includes the Upper Carmen River and Glacier River.',
        species: [FishSpecies.coho, FishSpecies.sockeye, FishSpecies.pink, FishSpecies.chum, FishSpecies.dolly],
        seasons: [
          'Mouth → ADF&G markers ≈10 mi above the Seward Highway: open year-round to species other than king salmon.',
          'Above those markers, Jan 1 – July 13: open to species other than king salmon; July 14 – Dec 31 closed to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Upper Carmen & Glacier River Drainages',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.dolly],
        seasons: [
          'Above ADF&G markers at the confluence — Jan 1 – July 13: open to species other than king salmon; July 14 – Dec 31 closed.',
        ],
      ),
      FishingWater(
        name: 'Ingram Creek Drainage',
        notes:
            'Marks the eastern boundary of the Anchorage Bowl regulatory area on the south side of Turnagain Arm.',
        species: [FishSpecies.coho, FishSpecies.pink, FishSpecies.dolly],
        seasons: [
          'Open year-round to species other than salmon.',
          'Mouth → ADF&G markers ≈50 yd above the Seward Highway: open to species other than king salmon.',
          'Above those markers, Jan 1 – Sept 30: open to salmon other than king.',
        ],
      ),
    ],
  );
}
