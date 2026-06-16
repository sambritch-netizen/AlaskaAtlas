import '../models/fishing_regs.dart';

/// Sport-fishing regulation summaries by ADF&G region. Lists species,
/// seasons, and methods/means context — NOT the specific bag/length
/// limits, which can change mid-season by emergency order. For numeric
/// limits, anglers must consult the current ADF&G regulation booklet.
///
/// Sourced from the 2026 ADF&G Southcentral Alaska Sport Fishing
/// Regulations Summary. Each Southcentral sub-region's "Inclusive
/// Waters" definition, general methods/seasons, and special-regulation
/// water bodies match the published booklet's organization.
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
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon, including catch-and-release.',
        ],
      ),
      FishingWater(
        name: 'Chinitna River Drainage',
        seasons: [
          'Clearwater Creek (including Roscoe Creek, up to ½ mile above the Chinitna confluence): closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Chuitna River Drainage',
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon — all king caught must be released.',
        ],
      ),
      FishingWater(
        name: 'Lewis River',
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon — all king caught must be released.',
        ],
      ),
      FishingWater(
        name: 'McNeil River',
        seasons: [
          'Within ½ mile of McNeil River Falls (≈1 mile upstream of McNeil Lagoon): closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Shelter Creek',
        seasons: [
          'Upstream of ADF&G marker ≈1 mile above its mouth: closed year-round to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Silver Salmon Creek',
        seasons: [
          'Within ½ mile of its outlet at Silver Salmon Lake: closed year-round to salmon fishing.',
        ],
      ),
      FishingWater(
        name: 'Silver Salmon Lake',
        seasons: ['Closed year-round to all salmon fishing.'],
      ),
      FishingWater(
        name: 'Theodore River Drainage',
        seasons: [
          'Open year-round to species other than king salmon.',
          'Closed year-round to king salmon — all king caught must be released.',
        ],
      ),
      FishingWater(
        name: 'Threemile Creek',
        notes:
            'Upstream of the Beluga–Tyonek Road culvert to Threemile/Tukhallah Lake.',
        seasons: [
          'Open year-round to species other than salmon.',
          'Closed year-round to all salmon fishing.',
        ],
      ),
      FishingWater(
        name: 'Threemile/Tukhallah Lake',
        seasons: [
          'Open year-round to species other than salmon.',
          'Closed year-round to all salmon fishing.',
        ],
      ),
      FishingWater(
        name: 'Wolverine Creek',
        notes:
            'Includes Big River Lake within a 500-yard radius of the Wolverine Creek mouth. South Fork of Big River upstream of an island ≈1.25 miles above the South Fork confluence is closed to all sport fishing.',
        seasons: [
          'June 1 – July 31: fly-fishing-only waters.',
        ],
        methods: [
          'Snagging is prohibited.',
          'See page 6 of the ADF&G booklet for gear allowed in fly-fishing-only waters.',
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
        name: 'Alexander Creek Drainage (Unit 1)',
        notes: 'Lower Susitna tributary; king salmon waters.',
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Deshka River Drainage (Unit 1)',
        notes: 'One of the most popular king and coho fisheries in Southcentral.',
        seasons: [
          'King salmon closed in 2026 by emergency order.',
          'Special weekend / time-of-day windows apply during open salmon periods — check current EOs.',
        ],
      ),
      FishingWater(name: 'Birch Creek (Unit 2)'),
      FishingWater(name: 'Goose Creek (Unit 2)'),
      FishingWater(name: 'Greys (196 Mile) Creek (Unit 2)'),
      FishingWater(
        name: 'Kashwitna River Drainage (Unit 2)',
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Little Willow Creek Drainage (Unit 2)',
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Montana Creek Drainage (Unit 2)',
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Sheep Creek Drainage (Unit 2)',
        methods: [
          'Only one unbaited, single-hook, artificial lure or fly is allowed in many sections — check the booklet.',
        ],
      ),
      FishingWater(name: 'Sunshine Creek Drainage (Unit 2)'),
      FishingWater(
        name: 'Trapper Creek Drainage (Unit 2)',
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(
        name: 'Willow Creek Drainage (Unit 2)',
        notes: 'Major road-accessible king and silver fishery.',
        seasons: ['King salmon closed in 2026 by emergency order.'],
      ),
      FishingWater(name: 'Deception Creek Drainage (Unit 2)'),
      FishingWater(
        name: 'Clarence Lake (Unit 3)',
        notes: 'Remote upper-Susitna lake with grayling and lake trout.',
      ),
      FishingWater(
        name: 'Susitna River (Unit 3 — mainstem)',
        notes:
            'Upper mainstem above the major tributaries; primarily a grayling, whitefish, and lake-trout fishery.',
      ),
      FishingWater(name: 'Canyon Creek (Unit 4)'),
      FishingWater(
        name: 'Talachulitna River Drainage (Unit 4)',
        notes: 'Famous fly-water rainbow and silver fishery.',
        methods: [
          'Single-hook, artificial lure or fly is the default in most reaches; check the booklet for exact mileposts.',
        ],
      ),
      FishingWater(name: 'Fish Lake Creek Drainage (Unit 4)'),
      FishingWater(name: 'Lake Creek Drainage (Unit 4)'),
      FishingWater(name: 'Peters Creek (Unit 4)'),
      FishingWater(name: 'Clear (Chunilna) Creek Drainage (Unit 5)'),
      FishingWater(name: 'Fish Creek Drainage (Unit 5)'),
      FishingWater(name: 'Larson Creek Drainage (Unit 5)'),
      FishingWater(
        name: 'Byers Creek Drainage / Byers Lake (Unit 6)',
        notes: 'Denali State Park; popular roadside lake.',
      ),
      FishingWater(
        name: 'East Fork Chulitna River Drainages (Unit 6)',
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
        seasons: [
          'Closed year-round to all salmon fishing.',
          'April 15 – June 15: catch-and-release only for rainbow/steelhead.',
        ],
      ),
      FishingWater(
        name: 'Bonnie Lakes Connecting Stream',
        notes: 'From the outlet at Upper Bonnie Lake to the inlet of Lower Bonnie Lake.',
        seasons: ['July 1 – April 14: open to sport fishing.'],
      ),
      FishingWater(
        name: 'Cottonwood Creek Drainage',
        notes:
            'Retaining a bag of salmon closes you out for the day from any salmon waters.',
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
        seasons: [
          'Jan 1 – July 31: open to species other than king salmon.',
          'April 15 – June 15: catch-and-release only for rainbow/steelhead.',
          'August 1 – December 31: closed Mondays/Tuesdays; open Wed–Sun, 5 a.m. – 10 p.m.',
          'Upper Jim Creek (above Leaf Lake), Jim Lake, Leaf Lake, Mud Lake, McRoberts Creek: open year-round, no salmon.',
        ],
      ),
      FishingWater(
        name: 'Johnson Lake (near Palmer)',
        seasons: ['Closed year-round to all sport fishing.'],
      ),
      FishingWater(
        name: 'Little Susitna River Drainage',
        notes:
            'Major silver salmon road-fishery. King salmon fishing is closed in 2026 by emergency order.',
        seasons: [
          'Mouth to Parks Highway: open year-round (no kings).',
          '  • August 6 – September 30: bait and multiple hooks allowed.',
          '  • October 1 – August 5: only unbaited, artificial lures or flies.',
          'Above the Parks Highway: closed year-round to salmon; June 15 – April 14 open (no salmon).',
          'Nancy Lake Creek drainage above ADF&G marker ¼ mile above its mouth: closed year-round to all salmon.',
          'Nancy Lake: closed year-round to burbot.',
        ],
        methods: [
          'No motorized boats unless 4-stroke or direct-injection 2-stroke. A non-DI 2-stroke may be used to access bank fishing only.',
          'May 15 – July 13: fishing hours 6 a.m. – 11 p.m. only.',
          'May 1 – July 13 (Lower Little Su): one unbaited single-hook artificial lure, hook gap ≤ ½ inch (by EO).',
          'A coho removed from the water must be retained — you may not release a landed coho.',
          'Retaining a bag of chum/coho/pink/sockeye closes you out of the Little Su for the day.',
          'Above the Parks Highway: only one unbaited, single-hook, artificial lure or fly.',
          'Nancy Lake northern pike: Nov 1 – Mar 15 ice fishing, up to 5 lines, 8 a.m. – 5 p.m., attended, hook gap ≥ ¾", whole bait fish, all other species released.',
        ],
      ),
      FishingWater(
        name: 'Long Lake (Kepler-Bradley Complex)',
        seasons: [
          'May 1 – October 31: open to sport fishing.',
          'Rainbow trout: catch-and-release only.',
        ],
        methods: ['Only one unbaited, single-hook, artificial lure or fly.'],
      ),
      FishingWater(
        name: 'Wasilla Creek Drainage',
        notes: 'Includes Rabbit Slough.',
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
        seasons: [
          'April 15 – June 14: closed to all sport fishing.',
          'In waters open to retention, rainbow/steelhead trout and Arctic char/Dolly Varden have specific limits.',
        ],
        methods: [
          'Bait and multiple hooks prohibited until August 1 by emergency order.',
        ],
      ),
      FishingWater(
        name: 'Chester Creek Drainage',
        notes: 'Includes east and west forks.',
        seasons: [
          'Jan 1 – July 13: closed to all sport fishing.',
        ],
      ),
      FishingWater(
        name: 'Eagle River Drainage',
        notes: 'Major Anchorage-bowl salmon and char stream.',
        seasons: [
          'Specific reach-by-reach seasons apply — check the booklet for Dimond Boulevard Bridge / Old Seward markers.',
        ],
      ),
      FishingWater(
        name: 'South Fork Eagle River',
        seasons: [
          'See main Eagle River entry plus headwater-specific restrictions.',
        ],
      ),
      FishingWater(
        name: 'Peters Creek Drainage',
        seasons: ['Reach-specific closures and methods restrictions apply.'],
      ),
      FishingWater(
        name: 'Sixmile Creek Drainage (JBER)',
        notes:
            'On Joint Base Elmendorf-Richardson — JBER access pass and base regulations also apply.',
      ),
      FishingWater(
        name: 'Symphony Lake',
        notes: 'South Fork Eagle River headwaters — alpine lake.',
        seasons: ['See special regulations in the booklet.'],
      ),
      FishingWater(
        name: 'Potter Creek / Potter Marsh Drainage',
        notes:
            'Hightly visible roadside marsh on the Seward Highway south of Anchorage.',
      ),
      FishingWater(
        name: 'Rabbit Creek Drainage',
        seasons: ['Bag/possession limits as listed for the general species.'],
      ),
      FishingWater(
        name: 'Ship Creek',
        notes:
            'Downtown Anchorage. The single Anchorage-bowl exception to the 2026 king closure.',
        seasons: [
          'Jan 1 – April 14: closed to salmon, open to other species.',
          'April 15 – June 14: closed to all sport fishing.',
          'June 15 – July 13: closed to salmon, open to other species.',
          'July 14 – Sept 30: open to coho salmon and other species; single-hook artificial lure only, bait prohibited.',
        ],
        methods: [
          'Single-hook, artificial lure only during the July 14 – Sept 30 coho window; bait prohibited.',
          'See special-regulation markers under the Dimond Blvd Bridge and near Shelikof Street.',
        ],
      ),
      FishingWater(
        name: 'Bird Creek Drainage',
        notes: 'Roadside Turnagain Arm coho fishery.',
        seasons: [
          'Reach- and date-specific restrictions; consult the booklet for the popular silver run window.',
        ],
      ),
      FishingWater(
        name: 'Glacier Creek Drainage',
        notes: 'Includes California Creek.',
        seasons: ['January 1 – September 30: open to sport fishing.'],
      ),
      FishingWater(
        name: 'California Creek Drainage',
      ),
      FishingWater(
        name: 'Williwaw Creek',
        seasons: [
          'Open year-round to sport fishing for species other than salmon.',
        ],
      ),
      FishingWater(
        name: 'Indian Creek Drainage',
        seasons: [
          'Open year-round to sport fishing for species other than salmon.',
        ],
      ),
      FishingWater(
        name: 'Ingram Creek Drainage',
        notes:
            'Marks the eastern boundary of the Anchorage Bowl regulatory area on the south side of Turnagain Arm.',
      ),
    ],
  );
}
