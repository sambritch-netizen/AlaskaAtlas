import '../models/gear_item.dart';

/// The Turnagain Outfitters rental catalog.
///
/// This is the bundled offline catalog. Live inventory, pricing, and booking
/// come from the Turnagain Outfitters Base44 app once the connector is
/// configured — see `TurnagainService`.
class GearData {
  GearData._();

  static const String outfitterName = 'Turnagain Outfitters';
  static const String outfitterTagline =
      'Anchorage-based. Trail-tested. Everything you need for the Last Frontier.';

  static const List<String> categories = [
    'Camping',
    'Fishing',
    'Winter',
    'Safety & Nav',
  ];

  static const List<GearItem> items = [
    // ── Camping ─────────────────────────────────────────────────────────
    GearItem(
      id: 'tent-4s',
      name: '4-Season Expedition Tent',
      category: 'Camping',
      emoji: '⛺',
      description:
          'A bombproof 2-person mountain tent rated for Alaskan wind and rain. Full-coverage fly, snow-ready pole structure, and a vestibule big enough for wet boots and a stove.',
      pricePerDay: 22,
      includes: ['Tent + fly + footprint', 'Extra stakes & guyline', 'Repair sleeve'],
      goodFor: ['Backcountry trips', 'Shoulder-season camping', 'Above treeline'],
    ),
    GearItem(
      id: 'sleep-system',
      name: 'Cold-Weather Sleep System',
      category: 'Camping',
      emoji: '🛌',
      description:
          '0°F down bag paired with an insulated pad (R-value 5.4). Warm enough for early-season trips and glacier-adjacent camps.',
      pricePerDay: 14,
      includes: ['0°F down bag', 'Insulated sleeping pad', 'Compression sack & liner'],
      goodFor: ['May–September backcountry', 'Cold sleepers'],
    ),
    GearItem(
      id: 'bear-kit',
      name: 'Bear Country Kit',
      category: 'Camping',
      emoji: '🐻',
      description:
          'Everything Alaska expects you to carry in bear country: an approved hard-sided canister and bear spray, with a holster so the spray rides on your hip where it belongs.',
      pricePerDay: 9,
      includes: ['BV500 bear canister', 'Bear spray + hip holster', 'Odor-proof bags'],
      goodFor: ['Required in Denali backcountry', 'Any salmon-stream camp'],
    ),
    GearItem(
      id: 'camp-kitchen',
      name: 'Backcountry Kitchen',
      category: 'Camping',
      emoji: '🍳',
      description:
          'Stove, fuel, cookset, and a gravity water filter — the whole kitchen, minus the food. Tested down to freezing.',
      pricePerDay: 11,
      includes: ['Canister stove + 2 fuel cans', '2-person cookset', 'Gravity filter (4L)'],
      goodFor: ['Multi-day trips', 'Groups of 2–4'],
    ),
    GearItem(
      id: 'packraft',
      name: 'Packraft + Paddle Kit',
      category: 'Camping',
      emoji: '🛶',
      description:
          'A 5.5-lb inflatable boat that opens up lake crossings and Class I–II floats. The classic Alaskan hike-and-float tool.',
      pricePerDay: 45,
      includes: ['Packraft + inflation bag', '4-piece paddle', 'PFD + dry bag'],
      goodFor: ['Hike-to-float routes', 'Lake basecamps'],
    ),

    // ── Fishing ─────────────────────────────────────────────────────────
    GearItem(
      id: 'rod-salmon',
      name: 'Salmon Spinning Combo',
      category: 'Fishing',
      emoji: '🎣',
      description:
          'A stout 9-ft medium-heavy spinning setup rigged for reds and silvers, with a tackle kit matched to the week\'s runs — spinners, spoons, and leader material.',
      pricePerDay: 18,
      includes: ['9-ft rod + 4000 reel', 'Salmon tackle kit', 'Fish bag & stringer alternative'],
      goodFor: ['Kenai & Russian rivers', 'Ship Creek', 'Valdez pinks'],
    ),
    GearItem(
      id: 'rod-fly',
      name: 'Alaska Fly Rod Outfit',
      category: 'Fishing',
      emoji: '🪶',
      description:
          'An 8-weight fly outfit that handles silvers and rainbows, with a fly box stocked for Alaska: beads, flesh flies, leeches, and a few mice for the brave.',
      pricePerDay: 24,
      includes: ['8wt rod + reel + line', 'Stocked Alaska fly box', 'Leaders & tippet'],
      goodFor: ['Trophy rainbows', 'Dolly Varden', 'Coho on the swing'],
    ),
    GearItem(
      id: 'waders',
      name: 'Waders + Boot Kit',
      category: 'Fishing',
      emoji: '🥾',
      description:
          'Breathable chest waders and rubber-soled wading boots (felt is illegal in Alaska — these comply). Sized when you book.',
      pricePerDay: 15,
      includes: ['Breathable chest waders', 'Wading boots (rubber sole)', 'Wading belt'],
      goodFor: ['River fishing', 'Combat fishing comfort'],
    ),

    // ── Winter ──────────────────────────────────────────────────────────
    GearItem(
      id: 'arctic-parka',
      name: 'Arctic Parka & Bibs',
      category: 'Winter',
      emoji: '🧥',
      description:
          'Expedition-weight parka and insulated bibs rated to -40°F. The aurora-watching uniform — you stand still in deep cold far longer than you think.',
      pricePerDay: 19,
      includes: ['-40°F parka', 'Insulated bibs', 'Expedition mittens'],
      goodFor: ['Aurora nights', 'Ice fishing', 'Dog-sled tours'],
    ),
    GearItem(
      id: 'winter-boots',
      name: 'Pac Boots & Traction',
      category: 'Winter',
      emoji: '❄️',
      description:
          'Rated-to--40°F pac boots plus microspikes for glare ice. Sized when you book; wool socks included and yours to keep.',
      pricePerDay: 12,
      includes: ['Pac boots (-40°F)', 'Microspikes', 'New wool socks'],
      goodFor: ['Winter sightseeing', 'Icy trails', 'Glacier viewpoints'],
    ),
    GearItem(
      id: 'snowshoes',
      name: 'Backcountry Snowshoe Set',
      category: 'Winter',
      emoji: '🏔️',
      description:
          'Aggressive-crampon snowshoes with heel lifts for climbing, paired with adjustable poles. Floats you over Hatcher Pass powder.',
      pricePerDay: 13,
      includes: ['Snowshoes', 'Adjustable poles', 'Gaiters'],
      goodFor: ['Winter trails', 'Hatcher Pass', 'Aurora hill walks'],
    ),

    // ── Safety & Nav ────────────────────────────────────────────────────
    GearItem(
      id: 'starlink',
      name: 'Alaska Starlink Kit',
      category: 'Safety & Nav',
      emoji: '📶',
      description:
          'Portable Starlink satellite internet for basecamps, cabins, and remote lodges. Real broadband where Alaska has no coverage at all — check current pricing and availability on turnagainoutfitters.com.',
      pricePerDay: 35,
      includes: ['Starlink dish + router', 'Power kit', 'Carry case'],
      goodFor: ['Remote cabins & lodges', 'Basecamps', 'Work-from-anywhere trips'],
    ),
    GearItem(
      id: 'inreach',
      name: 'Satellite Communicator',
      category: 'Safety & Nav',
      emoji: '📡',
      description:
          'Garmin inReach with an active SOS + messaging plan. Most of Alaska has zero cell coverage — this is the single most important rental we offer.',
      pricePerDay: 10,
      includes: ['inReach device', 'Active SOS/messaging plan', 'USB charger'],
      goodFor: ['Every backcountry trip', 'Road trips on remote highways'],
    ),
    GearItem(
      id: 'gps-kit',
      name: 'Navigation Kit',
      category: 'Safety & Nav',
      emoji: '🧭',
      description:
          'Handheld GPS preloaded with Alaska topo maps, a declination-adjusted compass, and waterproof map cases for your route.',
      pricePerDay: 8,
      includes: ['GPS + Alaska topo maps', 'Compass (declination set)', 'Map case'],
      goodFor: ['Off-trail routes', 'Hunting & fishing access'],
    ),
    GearItem(
      id: 'first-aid',
      name: 'Expedition First-Aid Kit',
      category: 'Safety & Nav',
      emoji: '⛑️',
      description:
          'A real wilderness med kit built for groups up to 6 — trauma supplies, SAM splint, blister care, and a field guide. Restocked after every rental.',
      pricePerDay: 6,
      includes: ['Group med kit', 'SAM splint', 'Emergency bivy ×2'],
      goodFor: ['Group trips', 'Multi-day backcountry'],
    ),
  ];

  static List<GearItem> byCategory(String? category) => category == null
      ? items
      : items.where((i) => i.category == category).toList();
}
