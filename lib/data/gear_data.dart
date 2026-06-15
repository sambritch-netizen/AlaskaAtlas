import '../models/gear_item.dart';

/// The Turnagain Outfitters rental catalog — synced from the live
/// Turnagain Outfitters Base44 app (Product entity). Item ids are the real
/// Base44 product ids so live sync can match records.
class GearData {
  GearData._();

  static const String outfitterName = 'Turnagain Outfitters';
  static const String outfitterTagline =
      'Anchorage-based gear rentals — fishing, camping, winter & more.';

  /// Base44 app id for the Turnagain Outfitters store.
  static const String base44AppId = '69cc33ead8900ab3dab19df0';

  static const List<String> categories = [
    'Fishing',
    'Camping',
    'Winter',
    'Standalone Items',
  ];

  static const List<GearItem> items = [
    // ── Fishing ─────────────────────────────────────────────────────────
    GearItem(
      id: '69cf0953932a612a06ed747b',
      name: 'Salmon Package',
      category: 'Fishing',
      emoji: '🐟',
      description:
          'Complete salmon fishing setup for Alaska\'s legendary runs. Everything you need to get on the water and start fishing, all in one package.',
      pricePerDay: 30,
      includes: ['Rod/Reel', 'Hip Waders', 'Lures', 'Net', 'Stringer', 'Backpack'],
      goodFor: [
        'Silver, pink, chum & red salmon runs',
        'River banks & roadside spots',
        'All experience levels',
      ],
    ),
    GearItem(
      id: '69cf0953932a612a06ed747a',
      name: 'King Salmon Package',
      category: 'Fishing',
      emoji: '👑',
      description:
          'Kings are big, powerful fish, and this package gives you a strong, reliable setup that\'s ready for Alaska conditions. No guesswork, no piecing things together — just gear that\'s meant to do the job.',
      pricePerDay: 30,
      includes: ['Heavy-duty Rod/Reel', 'Hip Waders', 'Landing Net', 'Lures', 'Backpack'],
      goodFor: ['King salmon', 'Shore & river fishing'],
    ),
    GearItem(
      id: '69cf1f8d4244a2577c6100ec',
      name: 'Fly Fishing Package',
      category: 'Fishing',
      emoji: '🪶',
      description:
          'Everything you need to get out on the water and start casting — a simple, ready-to-go setup that works well for local rivers and streams, whether you\'ve fly fished for years or are just getting into it.',
      pricePerDay: 30,
      includes: ['Fly Rod & Reel', 'Flies', 'Rod Case', 'Net', 'Waders & Boots'],
      goodFor: ['Salmon', 'Trout & grayling', 'Local rivers & streams'],
    ),
    GearItem(
      id: '69cf0953932a612a06ed747c',
      name: 'Surf Fishing Package',
      category: 'Fishing',
      emoji: '🌊',
      description:
          'Built for casting out from beaches, river mouths, and roadside spots around Alaska. Simple, solid gear that lets you get a line in the water without overthinking it.',
      pricePerDay: 30,
      includes: ['Surf Rod/Reel', 'Rigging', 'Weights', 'Lures', 'Backpack'],
      goodFor: ['Shore fishing', 'River mouths & beaches', 'Quick roadside stops'],
    ),
    GearItem(
      id: '69cf0953932a612a06ed747d',
      name: 'Ice Fishing Package',
      category: 'Fishing',
      emoji: '🧊',
      description:
          'A straightforward setup that lets you drill, drop a line, and start fishing without overthinking it — out for a few hours or making a full day of it.',
      pricePerDay: 20,
      includes: ['Rod/Reel', 'Lures', 'Ladle', 'Seat', 'Rod Case'],
      goodFor: ['Frozen lakes & ponds', 'Trout & freshwater species', 'First-timers'],
    ),
    GearItem(
      id: '69e82e088d0c023198b724f7',
      name: 'Kids Fishing Package',
      category: 'Fishing',
      emoji: '🎏',
      description:
          'A complete, easy-to-use setup sized for kids so they can get in on the action too. Free with any adult fishing package rental — just mention it when you book.',
      pricePerDay: 15,
      includes: ['Kid-sized rod & reel', 'Lures', 'Tackle box', 'Life jacket'],
      goodFor: ['Family trips', 'Free with adult package'],
    ),
    GearItem(
      id: '69df14ba9194ca3a927ef80f',
      name: 'Hooligan Package',
      category: 'Fishing',
      emoji: '🥅',
      description:
          'Hooligan season on Turnagain Arm is short, weird, and a lot of fun. Stand in the water, dip a net, and pull out a bucket of small, oily fish locals smoke, dry, or fry by the dozen. Season typically runs late April through May.',
      pricePerDay: 25,
      includes: ['Hooligan dip net', 'Bucket', 'Small cooler'],
      goodFor: ['Turnagain Arm', 'Late April – May'],
    ),
    GearItem(
      id: '6a16503fbb2b7704b23bd525',
      name: 'Chest Waders with Boots',
      category: 'Fishing',
      emoji: '🥾',
      description:
          'Chest waders for wading into deeper waters. Wading boots are included.',
      pricePerDay: 20,
    ),
    GearItem(
      id: '6a1650b791b9b149351c1d45',
      name: 'Hip Waders',
      category: 'Fishing',
      emoji: '👢',
      description: 'Rubber hip waders that attach to the belt.',
      pricePerDay: 10,
    ),
    GearItem(
      id: '69f1746db0bd1faad480fbe7',
      name: 'Tackle Kit',
      category: 'Fishing',
      emoji: '🧰',
      description:
          'A curated selection of Alaska-proven lures, hooks, weights, and terminal tackle. Tell us what species you\'re targeting and we\'ll curate your kit with all the right tackle.',
      pricePerDay: 8,
    ),
    GearItem(
      id: '69f1746db0bd1faad480fbed',
      name: 'Tackle Bag / Gear Bag',
      category: 'Fishing',
      emoji: '🎒',
      description:
          'Organized tackle bag with multiple compartments for carrying all your fishing gear to and from the water.',
      pricePerDay: 5,
    ),
    GearItem(
      id: '69f1746db0bd1faad480fbec',
      name: 'Rain Jacket',
      category: 'Fishing',
      emoji: '🧥',
      description:
          'Waterproof rain jacket for fishing in typical Alaska coastal weather. Because it will rain at some point.',
      pricePerDay: 8,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7493',
      name: 'Fishing Pliers',
      category: 'Fishing',
      emoji: '🔧',
      description: 'Fishing pliers for hook removal and rigging.',
      pricePerDay: 4,
    ),
    GearItem(
      id: '69cf0953932a612a06ed748a',
      name: 'Fillet Knife',
      category: 'Fishing',
      emoji: '🔪',
      description: 'Sharp fillet knife for cleaning and processing fish.',
      pricePerDay: 3,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7480',
      name: 'Landing Net',
      category: 'Fishing',
      emoji: '🥅',
      description: 'Landing net for securing your catch.',
      pricePerDay: 4,
    ),
    GearItem(
      id: '69f1746db0bd1faad480fbee',
      name: 'Stringer',
      category: 'Fishing',
      emoji: '🪢',
      description:
          'Heavy-duty fish stringer for keeping your catch in the water while you keep fishing. Simple and effective.',
      pricePerDay: 1,
    ),
    GearItem(
      id: '69f1769a7fccc17a8fb7f7f2',
      name: 'Fish Bonker',
      category: 'Fishing',
      emoji: '🏏',
      description:
          'A solid fish bonker for quickly and humanely dispatching your catch in the field.',
      pricePerDay: 3,
    ),

    // ── Camping ─────────────────────────────────────────────────────────
    GearItem(
      id: '69df33498e1d1c70ce0a2ab0',
      name: 'Dual Basecamp Kit',
      category: 'Camping',
      emoji: '🏕️',
      description:
          'Our most popular camping package. Everything two people need to set up a solid basecamp in Alaska — great for couples, friends, or anyone who wants a comfortable setup without hauling gear.',
      pricePerDay: 40,
      includes: [
        '2-person tent',
        '2 sleeping bags',
        '2 sleeping pads',
        '2 camp chairs',
        '2-burner stove',
        'Cookware set',
        'Lantern',
        'Tarp',
      ],
      goodFor: ['Couples & friends', 'Car camping basecamps'],
    ),
    GearItem(
      id: '69df33498e1d1c70ce0a2aaf',
      name: 'Solo Adventurer Pack',
      category: 'Camping',
      emoji: '⛺',
      description:
          'Everything you need for a solo backcountry trip along Turnagain Arm. Packed light and ready to go — perfect for hikers passing through or spending a few nights on the trail.',
      pricePerDay: 30,
      includes: [
        'Lightweight 1-person tent',
        'Sleeping bag',
        'Sleeping pad',
        'Backpack',
        'Compact stove + fuel',
        'Mess kit',
      ],
      goodFor: ['Solo backpacking', 'Multi-night trail trips'],
    ),
    GearItem(
      id: '69df33498e1d1c70ce0a2ab2',
      name: 'Weekend Warrior Bundle',
      category: 'Camping',
      emoji: '🌲',
      description:
          'Everything for a 2-night trip, priced as a flat weekend rate. Grab it Friday, return it Sunday. No daily math, no nickel-and-diming.',
      pricePerDay: 75,
      includes: [
        'Tent',
        '2 sleeping bags',
        '2 sleeping pads',
        '2 camp chairs',
        'Cooler',
        'Tarp',
      ],
      goodFor: ['Flat weekend rate', 'Friday–Sunday trips'],
    ),
    GearItem(
      id: '69df33498e1d1c70ce0a2ab1',
      name: 'Family Camp Package',
      category: 'Camping',
      emoji: '👨‍👩‍👧‍👦',
      description:
          'Enough gear to get the whole family out there without renting piece by piece. Ideal for families visiting Alaska in summer who want a real outdoor experience without the baggage fees.',
      pricePerDay: 125,
      includes: [
        '4–6 person tent',
        '4 sleeping bags',
        '4 sleeping pads',
        'Cooler',
        '4 camp chairs',
      ],
      goodFor: ['Families', 'Summer visits'],
    ),

    // ── Winter ──────────────────────────────────────────────────────────
    GearItem(
      id: '69efb5608e9f6299b257f512',
      name: 'Snowshoes',
      category: 'Winter',
      emoji: '❄️',
      description:
          'Atlas or MSR snowshoes suitable for packed and unpacked Alaskan terrain. Multiple sizes — perfect for winter hiking, moose watching, and backcountry travel.',
      pricePerDay: 25,
    ),
    GearItem(
      id: '69efb5608e9f6299b257f514',
      name: 'Sled / Pulk',
      category: 'Winter',
      emoji: '🛷',
      description:
          'Plastic pulk sled for hauling gear across snow. Great for ice fishing trips or hauling camp supplies. Includes tow rope.',
      pricePerDay: 20,
    ),
    GearItem(
      id: '69cf3ea7af1cbb9ad9837591',
      name: 'Ice Fishing Tent',
      category: 'Winter',
      emoji: '🎪',
      description:
          'Insulated shelter for winter ice fishing with excellent temperature retention.',
      pricePerDay: 20,
    ),
    GearItem(
      id: '69efb5608e9f6299b257f513',
      name: 'Winter Day Pack',
      category: 'Winter',
      emoji: '🎒',
      description:
          'Insulated 30L daypack built for cold-weather use. Hydration-compatible with an insulated sleeve to prevent hose freeze-up.',
      pricePerDay: 15,
    ),

    // ── Standalone Items ───────────────────────────────────────────────
    GearItem(
      id: '69cf0953932a612a06ed749b',
      name: 'The Connectivity Kit',
      category: 'Standalone Items',
      emoji: '📶',
      description:
          'Cell service in Alaska gets thin fast once you leave the highway. The Starlink Mini is a real, working internet connection — check weather, video call home, handle work, or stream a movie at camp. Packs up small and it\'s tougher than it looks.',
      pricePerDay: 25,
      includes: ['Starlink Mini', 'Protective Case', 'Charging Cables'],
      goodFor: ['Remote fishing trips', 'Off-grid camping', 'Staying reachable'],
    ),
    GearItem(
      id: '6a164cd25b65753911003707',
      name: 'Garmin inReach',
      category: 'Standalone Items',
      emoji: '📡',
      description:
          'Two-way satellite communicator for remote Alaska adventures. Send and receive messages, track your route, trigger SOS alerts, and share your location when you\'re far beyond cell range.',
      pricePerDay: 15,
      goodFor: ['Backcountry hiking', 'Off-grid peace of mind'],
    ),
    GearItem(
      id: '69e90f543e73c002b2f667c3',
      name: 'Garmin GPS',
      category: 'Standalone Items',
      emoji: '🧭',
      description:
          'Handheld Garmin GPS unit for navigation in Alaska\'s backcountry. Preloaded with topographic maps.',
      pricePerDay: 15,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7488',
      name: 'Bear Spray',
      category: 'Standalone Items',
      emoji: '🐻',
      description:
          'EPA-registered bear deterrent. Non-negotiable for Alaska backcountry travel. Flat-rate rental for your entire trip.',
      pricePerDay: 15,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7492',
      name: 'Bear Vault',
      category: 'Standalone Items',
      emoji: '🛢️',
      description:
          'Bear-resistant food canister required in many Alaska wilderness areas.',
      pricePerDay: 9,
    ),
    GearItem(
      id: '69cf26305d877f66a5fc278a',
      name: 'Action Camera Package',
      category: 'Standalone Items',
      emoji: '🎥',
      description:
          'Capture your trip without risking your phone. A solid action camera setup with the mounts you need for good footage — throw it on your gear, hit record, and go. Memory card not included.',
      pricePerDay: 15,
      includes: ['Action camera', 'Several mounting attachments', 'Extra battery', 'Charger'],
      goodFor: ['Fishing trips', 'Off-road adventures', 'Hands-free filming'],
    ),
    GearItem(
      id: '69d862da48ea0b9c516af366',
      name: 'Gold Panning Package',
      category: 'Standalone Items',
      emoji: '⛏️',
      description:
          'Everything you need for a day of gold panning in Alaska — all the tools to find your fortune in local creeks and streams.',
      pricePerDay: 15,
      includes: ['Gold Pan', 'Classifier', 'Bucket', 'Shovel'],
    ),
    GearItem(
      id: '69d862da48ea0b9c516af365',
      name: 'Metal Detecting Package',
      category: 'Standalone Items',
      emoji: '🕵️',
      description:
          'Alaska has more buried history than people realize — old mining sites, ghost towns, century-old beaches. The Minelab Equinox 800 is one of the best detectors on the market. Check land status and local rules before detecting.',
      pricePerDay: 20,
      includes: ['Minelab Equinox 800', 'Pinpointer', 'Trowel'],
    ),
    GearItem(
      id: '69d862da48ea0b9c516af367',
      name: 'Berry Picking Package',
      category: 'Standalone Items',
      emoji: '🫐',
      description:
          'Alaska is one of the best places in the world for wild berry picking — blueberries, raspberries, salmonberries, low-bush cranberries. The basket clips on so you have both hands free. Best late summer through early fall.',
      pricePerDay: 15,
      includes: ['Berry picking basket', 'Bucket', 'Ziplock bags'],
    ),
    GearItem(
      id: '69cf1ccf283f6afe48ba0123',
      name: 'Roadside Assistance Kit',
      category: 'Standalone Items',
      emoji: '🚗',
      description:
          'Be prepared for anything on Alaska\'s remote roads — jumper cables, a tire patch kit, a mini compressor, and essential safety equipment.',
      pricePerDay: 10,
      includes: [
        'Jumper cables',
        'Tire patch kit',
        'Mini air compressor',
        'Reflective triangles, gloves, flashlight',
      ],
    ),
    GearItem(
      id: '6a17316be41bdc92c8d2324a',
      name: 'Tent (1, 2 or 4 Person)',
      category: 'Standalone Items',
      emoji: '⛺',
      description:
          'A quality camping tent perfect for Alaska\'s wilderness — choose the size that fits your group. All tents are freestanding, weather-resistant, and easy to set up.',
      pricePerDay: 25,
      goodFor: ['Ultralight solo', 'Couples', 'Family groups'],
    ),
    GearItem(
      id: '6a2b23fcded8efd6a6736ee7',
      name: 'Sleeping Bag',
      category: 'Standalone Items',
      emoji: '🛌',
      description:
          'Warm, durable sleeping bag suitable for Alaska camping conditions. Rated for comfort in cool temperatures.',
      pricePerDay: 7,
    ),
    GearItem(
      id: '6a2b23fcded8efd6a6736ee6',
      name: 'Sleeping Pad',
      category: 'Standalone Items',
      emoji: '🛏️',
      description:
          'Lightweight, insulated sleeping pad — cushioning and insulation from the ground.',
      pricePerDay: 4,
    ),
    GearItem(
      id: '69cf360b70d7aa396839577a',
      name: 'Jetboil',
      category: 'Standalone Items',
      emoji: '🔥',
      description:
          'Ultra-efficient backcountry stove system for quick meals and hot drinks.',
      pricePerDay: 10,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7497',
      name: 'Cooler (48qt)',
      category: 'Standalone Items',
      emoji: '🧊',
      description: '48qt heavy-duty cooler for keeping food and catch fresh.',
      pricePerDay: 14,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7496',
      name: 'Camp Chair',
      category: 'Standalone Items',
      emoji: '🪑',
      description: 'Lightweight, packable camp chair.',
      pricePerDay: 7,
    ),
    GearItem(
      id: '69cf0953932a612a06ed748b',
      name: 'Binoculars',
      category: 'Standalone Items',
      emoji: '🔭',
      description: 'Compact binoculars for glassing terrain and spotting wildlife.',
      pricePerDay: 14,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7494',
      name: 'Water Filter',
      category: 'Standalone Items',
      emoji: '💧',
      description:
          'Lightweight water filter for safe drinking water from Alaska streams.',
      pricePerDay: 9,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7490',
      name: 'Headlamp',
      category: 'Standalone Items',
      emoji: '🔦',
      description: 'Bright, lightweight headlamp for camp and trail use.',
      pricePerDay: 3,
    ),
    GearItem(
      id: '69cf0953932a612a06ed7498',
      name: 'Power Bank',
      category: 'Standalone Items',
      emoji: '🔋',
      description: 'High-capacity portable power bank to keep devices charged.',
      pricePerDay: 9,
    ),
    GearItem(
      id: '6a15eb237bdc0a3d9d9ac980',
      name: 'Trekking Poles',
      category: 'Standalone Items',
      emoji: '🥢',
      description:
          'Adjustable trekking poles for added stability on Alaska\'s varied terrain — hiking, river crossings, and backcountry travel.',
      pricePerDay: 5,
    ),
    GearItem(
      id: '69d2957a734ad5af95dc2c64',
      name: '5 Gallon Gas Can',
      category: 'Standalone Items',
      emoji: '⛽',
      description:
          'Heavy-duty 5 gallon fuel container, perfect for remote trips where fuel stops are scarce.',
      pricePerDay: 7,
    ),
    GearItem(
      id: '69cf1e0e6b172924ae64cc3e',
      name: 'Portable Toilet',
      category: 'Standalone Items',
      emoji: '🚽',
      description: 'Compact portable toilet for backcountry and remote camping.',
      pricePerDay: 5,
    ),
  ];

  static List<GearItem> byCategory(String? category) => category == null
      ? items
      : items.where((i) => i.category == category).toList();
}
