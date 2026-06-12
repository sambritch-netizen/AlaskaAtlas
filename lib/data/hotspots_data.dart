import '../models/hotspot.dart';

/// Curated hot spots across the state — every coordinate is the real place.
class HotspotsData {
  HotspotsData._();

  static const List<String> categories = [
    'Parks',
    'Glaciers',
    'Fishing',
    'Hiking',
    'Wildlife',
    'Aurora',
    'Hot Springs',
    'Towns',
  ];

  static String categoryEmoji(String category) => switch (category) {
        'Parks' => '🏔️',
        'Glaciers' => '🧊',
        'Fishing' => '🎣',
        'Hiking' => '🥾',
        'Wildlife' => '🐻',
        'Aurora' => '🌌',
        'Hot Springs' => '♨️',
        'Towns' => '🛖',
        _ => '📍',
      };

  static const List<Hotspot> hotspots = [
    Hotspot(
      id: 'denali',
      name: 'Denali National Park',
      category: 'Parks',
      region: 'Interior',
      lat: 63.1148,
      lng: -151.1926,
      emoji: '🏔️',
      blurb: 'North America\'s tallest peak and six million wild acres.',
      description:
          'Home of 20,310-ft Denali, the park is crossed by a single 92-mile road plied by transit buses. Grizzlies, caribou, Dall sheep, moose, and wolves — the "Big Five" — are all regularly spotted from the road. Only 30% of visitors see the mountain itself; clear mornings are your best shot.',
      bestSeason: 'June – early September',
      rating: 4.9,
      featured: true,
      tips: [
        'Book transit buses and campgrounds months ahead.',
        'Eielson Visitor Center (mile 66) has the classic Denali view.',
        'Cell service ends at the park entrance — download maps first.',
      ],
    ),
    Hotspot(
      id: 'kenai-fjords',
      name: 'Kenai Fjords National Park',
      category: 'Parks',
      region: 'Southcentral',
      lat: 59.9226,
      lng: -149.6500,
      emoji: '🐋',
      blurb: 'Tidewater glaciers, orcas, and puffins out of Seward.',
      description:
          'The Harding Icefield spills 38 glaciers toward the Gulf of Alaska. Day cruises from Seward thread past calving tidewater glaciers, humpbacks, orcas, sea otters, and bird rookeries. Exit Glacier is the only road-accessible corner of the park.',
      bestSeason: 'May – September',
      rating: 4.9,
      featured: true,
      tips: [
        'The 8-hour Northwestern Fjord cruise beats the half-day trips.',
        'Hike the Harding Icefield Trail for a top-of-the-world view (strenuous, 8+ mi).',
      ],
    ),
    Hotspot(
      id: 'matanuska',
      name: 'Matanuska Glacier',
      category: 'Glaciers',
      region: 'Southcentral',
      lat: 61.7011,
      lng: -147.7503,
      emoji: '🧊',
      blurb: 'Walk on a 27-mile river of ice, two hours from Anchorage.',
      description:
          'The largest road-accessible glacier in the U.S., reached from a turnoff at Glenn Highway mile 102. Guided treks cross blue ice fins, moulins, and meltwater pools; winter tours explore frozen caves lit electric blue.',
      bestSeason: 'Year-round (guided)',
      rating: 4.8,
      featured: true,
      tips: [
        'Access is via guided tour only — book ahead in summer.',
        'The Glenn Highway drive there is a National Scenic Byway; budget photo stops.',
      ],
    ),
    Hotspot(
      id: 'mendenhall',
      name: 'Mendenhall Glacier',
      category: 'Glaciers',
      region: 'Southeast',
      lat: 58.4366,
      lng: -134.5453,
      emoji: '❄️',
      blurb: 'Juneau\'s drive-up glacier with a thundering waterfall neighbor.',
      description:
          'Thirteen miles from downtown Juneau, Mendenhall calves into its own lake beside 377-ft Nugget Falls. The flat 2-mile round-trip Nugget Falls trail is the best effort-to-reward walk in Southeast. Black bears fish the creek in late summer.',
      bestSeason: 'May – September',
      rating: 4.7,
      tips: [
        'Photo Point trail at sunrise beats the midday cruise-ship crowds.',
      ],
    ),
    Hotspot(
      id: 'exit-glacier',
      name: 'Exit Glacier',
      category: 'Glaciers',
      region: 'Southcentral',
      lat: 60.1867,
      lng: -149.6319,
      emoji: '🧭',
      blurb: 'Seward\'s walk-to glacier, with year markers tracking its retreat.',
      description:
          'The only drive-up corner of Kenai Fjords NP. An easy 1-mile loop reaches glacier overlooks, passing signs marking where the ice stood each decade — a sobering, fascinating timeline. Strong hikers continue up the Harding Icefield Trail.',
      bestSeason: 'May – October',
      rating: 4.6,
    ),
    Hotspot(
      id: 'kenai-river',
      name: 'Kenai River',
      category: 'Fishing',
      region: 'Southcentral',
      lat: 60.5439,
      lng: -150.7886,
      emoji: '🎣',
      blurb: 'World-famous salmon water — kings, reds, silvers, and giant rainbows.',
      description:
          'Alaska\'s most famous fishery. Sockeye floods arrive in June and July, silvers run through fall, and the trophy rainbow trout fishery below Skilak Lake is world-class. Drift boats, bank fishing, and guided trips all produce.',
      bestSeason: 'June – October',
      rating: 4.8,
      featured: true,
      tips: [
        'The Russian River confluence is combat fishing at its finest in July.',
        'Check ADF&G emergency orders before every trip — regs change weekly.',
      ],
    ),
    Hotspot(
      id: 'homer',
      name: 'Homer Spit',
      category: 'Fishing',
      region: 'Southcentral',
      lat: 59.6028,
      lng: -151.4178,
      emoji: '🚤',
      blurb: 'Halibut capital of the world, at the end of the road.',
      description:
          'A 4.5-mile gravel spit jutting into Kachemak Bay, lined with charter docks, fish shacks, art galleries, and the Salty Dawg Saloon. Halibut charters run daily in season; across the bay, water taxis open up Kachemak Bay State Park\'s trails and coves.',
      bestSeason: 'May – September',
      rating: 4.7,
      featured: true,
      tips: [
        'Full-day charters reach better halibut grounds than half-day trips.',
        'Eagles on the beach at low tide are an event in themselves.',
      ],
    ),
    Hotspot(
      id: 'ship-creek',
      name: 'Ship Creek',
      category: 'Fishing',
      region: 'Southcentral',
      lat: 61.2272,
      lng: -149.8694,
      emoji: '🐟',
      blurb: 'Catch a king salmon downtown, ten minutes from your hotel.',
      description:
          'The only urban king salmon fishery of its kind — kings June, silvers August, with downtown Anchorage towers in the background. Rental rods and tackle shops sit streamside; the bore tide mudflats are dangerous, so fish from the bank areas.',
      bestSeason: 'June – September',
      rating: 4.3,
    ),
    Hotspot(
      id: 'hatcher',
      name: 'Hatcher Pass',
      category: 'Hiking',
      region: 'Southcentral',
      lat: 61.7706,
      lng: -149.3028,
      emoji: '⛰️',
      blurb: 'Alpine tundra, gold-mine ruins, and berry picking above the Mat-Su.',
      description:
          'A high mountain pass through the Talkeetnas with the historic Independence Mine ruins at its heart. Summer means alpine hikes (Gold Cord Lake, April Bowl, Reed Lakes) and blueberries; winter brings backcountry skiing and sledding.',
      bestSeason: 'July – September; winter for skiing',
      rating: 4.8,
      featured: true,
      tips: [
        'Reed Lakes trail is the Talkeetnas\' showpiece — turquoise lakes and boulder fields.',
        'The pass road closes beyond Independence Mine in winter.',
      ],
    ),
    Hotspot(
      id: 'flattop',
      name: 'Flattop Mountain',
      category: 'Hiking',
      region: 'Southcentral',
      lat: 61.1042,
      lng: -149.6837,
      emoji: '🥾',
      blurb: 'Alaska\'s most-climbed peak, 30 minutes from downtown Anchorage.',
      description:
          'A 1.5-mile, 1,300-ft scramble from Glen Alps trailhead to a flat summit with views from Denali to the Aleutians on a clear day. The classic summer-solstice sunset hike for locals. The final pitch is a hands-on rock scramble.',
      bestSeason: 'June – September',
      rating: 4.5,
      tips: [
        'Go before 10 AM or take the shoulder-season window for parking.',
        'Moose browse the lower trail constantly — give them room.',
      ],
    ),
    Hotspot(
      id: 'crow-pass',
      name: 'Crow Pass Trail',
      category: 'Hiking',
      region: 'Southcentral',
      lat: 61.0306,
      lng: -149.1217,
      emoji: '🏕️',
      blurb: 'The Chugach\'s premier point-to-point: glaciers, gorge, and a river ford.',
      description:
          'A 21-mile traverse from Girdwood to the Eagle River Nature Center along the historic Iditarod route — waterfalls, Raven Glacier, mining relics, and a genuine glacial river ford. Done as an overnight or a long single day by fit hikers.',
      bestSeason: 'July – early September',
      rating: 4.8,
      tips: [
        'Ford Eagle River early morning when glacial melt is lowest.',
      ],
    ),
    Hotspot(
      id: 'katmai',
      name: 'Katmai – Brooks Falls',
      category: 'Wildlife',
      region: 'Southwest',
      lat: 58.5550,
      lng: -155.7775,
      emoji: '🐻',
      blurb: 'The famous waterfall where brown bears snatch leaping salmon.',
      description:
          'Every July, dozens of brown bears crowd Brooks Falls to catch sockeye mid-air — the scene from every Alaska documentary. Reached by floatplane from King Salmon; viewing platforms put you safely within yards of thousand-pound fishermen.',
      bestSeason: 'July; September for fat-bear season',
      rating: 4.9,
      featured: true,
      tips: [
        'Day trips sell out nearly a year out — book early.',
        'Bear school at the ranger station is mandatory on arrival.',
      ],
    ),
    Hotspot(
      id: 'kodiak',
      name: 'Kodiak Island',
      category: 'Wildlife',
      region: 'Southwest',
      lat: 57.7900,
      lng: -152.4072,
      emoji: '🦅',
      blurb: 'Emerald island of giant bears and epic roadside fishing.',
      description:
          'The Kodiak brown bear — the largest in the world — shares this lush island with a major fishing fleet and road-accessible salmon streams. Floatplane bear-viewing at Frazer Lake, surfcasting for silvers, and the Kodiak NWR visitor center fill an itinerary fast.',
      bestSeason: 'June – September',
      rating: 4.7,
    ),
    Hotspot(
      id: 'aialik',
      name: 'St. Paul – Pribilof Islands',
      category: 'Wildlife',
      region: 'Bering Sea',
      lat: 57.1264,
      lng: -170.2764,
      emoji: '🐦',
      blurb: 'The Galápagos of the north — fur seals and a million seabirds.',
      description:
          'Way out in the Bering Sea, the Pribilofs host the world\'s largest northern fur seal rookeries and legendary birding — puffins, auklets, and Asian vagrants that draw listers from everywhere. Remote, foggy, unforgettable.',
      bestSeason: 'June – August',
      rating: 4.6,
    ),
    Hotspot(
      id: 'murphy-dome',
      name: 'Murphy Dome',
      category: 'Aurora',
      region: 'Interior',
      lat: 64.9536,
      lng: -148.3565,
      emoji: '🌌',
      blurb: 'Fairbanks\' favorite aurora hill, above the fog and the light dome.',
      description:
          'A 2,930-ft dome 25 minutes from Fairbanks with 360° horizons — the go-to aurora perch for locals. Directly under the auroral oval, Fairbanks sees lights on 4 of 5 clear winter nights. Bring arctic layers; you\'ll be standing still at -20°F.',
      bestSeason: 'late August – mid April',
      rating: 4.7,
      featured: true,
      tips: [
        'Check the UAF Geophysical Institute forecast; aim for Kp 3+.',
        'Peak display window is 10 PM – 2 AM.',
      ],
    ),
    Hotspot(
      id: 'chena',
      name: 'Chena Hot Springs',
      category: 'Hot Springs',
      region: 'Interior',
      lat: 65.0539,
      lng: -146.0556,
      emoji: '♨️',
      blurb: 'Soak in 106°F rock pools while the aurora burns overhead.',
      description:
          'Sixty miles up the Chena Hot Springs Road from Fairbanks, the resort\'s outdoor rock lake steams at 106°F year-round. Add the Aurora Ice Museum (carved ice bar, -7°F inside) and late-night aurora wake-up calls and you have the Interior\'s classic winter stop.',
      bestSeason: 'Year-round; winter for aurora soaks',
      rating: 4.6,
      featured: true,
      tips: [
        'Your hair will freeze into sculptures at -20°F. That\'s the photo.',
      ],
    ),
    Hotspot(
      id: 'talkeetna',
      name: 'Talkeetna',
      category: 'Towns',
      region: 'Interior',
      lat: 62.3209,
      lng: -150.1066,
      emoji: '🛩️',
      blurb: 'Quirky climber town with the best Denali flightseeing in Alaska.',
      description:
          'The staging town for Denali expeditions, all log cabins, roadhouse pie, and bush planes. Flightseeing trips circle the Alaska Range and land on the Ruth Glacier — twenty minutes of silence inside a mile-deep granite amphitheater.',
      bestSeason: 'May – September',
      rating: 4.7,
      featured: true,
      tips: [
        'Pay for the glacier landing. Nobody regrets it.',
        'The river bluff behind town frames Denali on clear evenings.',
      ],
    ),
    Hotspot(
      id: 'girdwood',
      name: 'Girdwood & Alyeska',
      category: 'Towns',
      region: 'Southcentral',
      lat: 60.9620,
      lng: -149.1101,
      emoji: '🚡',
      blurb: 'Rainforest ski town with a tram, hand pies, and hanging glaciers.',
      description:
          'Forty minutes from Anchorage along Turnagain Arm, Girdwood pairs Alyeska Resort\'s aerial tram and ski terrain with lush hemlock trails like Winner Creek. The Turnagain Arm drive there — bore tides, beluga whales, Dall sheep on the cliffs — is itself a hot spot.',
      bestSeason: 'Year-round',
      rating: 4.7,
      tips: [
        'Time the bore tide at Beluga Point — surfers ride a wave up the Arm.',
      ],
    ),
    Hotspot(
      id: 'valdez',
      name: 'Valdez & Thompson Pass',
      category: 'Towns',
      region: 'Southcentral',
      lat: 61.1308,
      lng: -146.3483,
      emoji: '🏂',
      blurb: 'Waterfall-lined fjord town beneath Alaska\'s snowiest pass.',
      description:
          'The Richardson Highway drops through Keystone Canyon\'s curtain waterfalls into a fjord ringed by peaks. Summer brings pink salmon runs, sea kayaking to Columbia Glacier; winter, Thompson Pass\'s 700+ inches of snow makes it heli-ski country.',
      bestSeason: 'June – September; March for snow',
      rating: 4.6,
    ),
    Hotspot(
      id: 'utqiagvik',
      name: 'Utqiaġvik (Barrow)',
      category: 'Towns',
      region: 'Arctic',
      lat: 71.2906,
      lng: -156.7886,
      emoji: '🧊',
      blurb: 'The top of America — midnight sun, polar bears, Iñupiat culture.',
      description:
          'The northernmost town in the U.S., where the sun doesn\'t set for 80 days of summer or rise for 65 days of winter. Visit for Iñupiat heritage, whale-bone arches on the Arctic Ocean beach, and fall polar bear viewing near Point Barrow.',
      bestSeason: 'June – August; October for polar bears',
      rating: 4.4,
    ),
  ];

  static List<Hotspot> get featured =>
      hotspots.where((h) => h.featured).toList();

  static List<Hotspot> byCategory(String? category) => category == null
      ? hotspots
      : hotspots.where((h) => h.category == category).toList();

  static const List<LocalPick> localPicks = [
    LocalPick(
      name: 'Moose\'s Tooth Pub & Pizzeria',
      town: 'Anchorage',
      kind: 'Pizza & brews',
      emoji: '🍕',
      blurb: 'The line out the door is locals. Broken Tooth ale and the Spicy Thai Chicken pie.',
    ),
    LocalPick(
      name: 'The Salty Dawg Saloon',
      town: 'Homer Spit',
      kind: 'Historic bar',
      emoji: '🍺',
      blurb: 'A lighthouse-topped shack wallpapered in signed dollar bills since the \'50s.',
    ),
    LocalPick(
      name: 'Talkeetna Roadhouse',
      town: 'Talkeetna',
      kind: 'Bakery & breakfast',
      emoji: '🥧',
      blurb: 'Climber-fuel breakfasts and berry pie in a 1917 log roadhouse.',
    ),
    LocalPick(
      name: 'Tracy\'s King Crab Shack',
      town: 'Juneau',
      kind: 'Seafood',
      emoji: '🦀',
      blurb: 'Bristol Bay red king crab legs and crab bisque on the docks.',
    ),
    LocalPick(
      name: 'The Bake Shop',
      town: 'Girdwood',
      kind: 'Bakery',
      emoji: '🥨',
      blurb: 'Sweet rolls and sourdough pancakes — the pre-tram ritual since 1972.',
    ),
    LocalPick(
      name: 'Salmon Bake at Pioneer Park',
      town: 'Fairbanks',
      kind: 'Alaskan classic',
      emoji: '🔥',
      blurb: 'Firepit-grilled salmon and halibut under the midnight sun.',
    ),
  ];
}
