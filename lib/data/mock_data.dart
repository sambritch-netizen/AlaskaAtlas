import '../models/place.dart';
import '../models/restaurant.dart';
import '../models/rental_item.dart';

// Placeholder image pattern — swap with real CDN URLs or Supabase Storage
const _img = 'https://images.unsplash.com/photo-';

class MockData {
  MockData._();

  static const List<String> categories = [
    'Hikes',
    'Fishing',
    'Camping',
    'Food',
    'Scenic',
    'Wildlife',
    'Hidden Gems',
  ];

  static const Map<String, String> categoryIcons = {
    'Hikes': '🥾',
    'Fishing': '🎣',
    'Camping': '⛺',
    'Food': '🍽️',
    'Scenic': '🏔️',
    'Wildlife': '🦅',
    'Hidden Gems': '💎',
  };

  static final List<Place> places = [
    const Place(
      id: 'p1',
      name: 'Flattop Mountain Trail',
      category: 'Hikes',
      description:
          'One of the most climbed peaks in Alaska, Flattop offers stunning 360° views of Anchorage, Cook Inlet, and the Alaska Range on clear days. The summit rewards hikers with panoramic vistas that define the Alaska experience.',
      latitude: 61.1003,
      longitude: -149.7219,
      images: [
        '${_img}1531366936-rygzXESmFr8?w=600',
        '${_img}1472214103451-9374769b6b68?w=600',
      ],
      difficulty: 'Moderate',
      bestSeason: 'Jun–Sep',
      tags: ['Summit', 'Family Friendly', 'Dog Friendly', 'Views'],
      hasFoodNearby: true,
      rating: 4.8,
      reviewCount: 312,
      distanceMiles: 3.4,
    ),
    const Place(
      id: 'p2',
      name: 'Kenai Fjords National Park',
      category: 'Scenic',
      description:
          'A stunning landscape of glaciers, fjords, and abundant marine wildlife. Exit Glacier is the only road-accessible part of the park and showcases the dramatic retreat of ice over centuries.',
      latitude: 59.9167,
      longitude: -149.6667,
      images: [
        '${_img}1558618666-fcd25c85cd64?w=600',
        '${_img}1512026359083-b9dba5f30ba9?w=600',
      ],
      difficulty: null,
      bestSeason: 'May–Sep',
      tags: ['Glacier', 'Boat Tour', 'Wildlife', 'National Park'],
      hasFoodNearby: true,
      rating: 4.9,
      reviewCount: 847,
      distanceMiles: 127.0,
    ),
    const Place(
      id: 'p3',
      name: 'Russian River Fishing',
      category: 'Fishing',
      description:
          'World-class sockeye and king salmon fishing on the Kenai Peninsula. The confluence of the Russian and Kenai Rivers is legendary among anglers from around the globe.',
      latitude: 60.4706,
      longitude: -149.9603,
      images: [
        '${_img}1544551763-46a013bb70d5?w=600',
        '${_img}1563013544-824ae1b704d3?w=600',
      ],
      difficulty: null,
      bestSeason: 'Jul–Aug',
      tags: ['Salmon', 'Fly Fishing', 'Wading', 'License Required'],
      hasFoodNearby: false,
      rating: 4.7,
      reviewCount: 256,
      distanceMiles: 88.0,
    ),
    const Place(
      id: 'p4',
      name: 'Chugach State Park Camping',
      category: 'Camping',
      description:
          'Half a million acres of pristine wilderness just minutes from Anchorage. Multiple campgrounds from drive-in sites to backcountry permits, with endless hiking and wildlife viewing.',
      latitude: 61.1200,
      longitude: -149.5800,
      images: [
        '${_img}1504280390367-361c6d9f38f4?w=600',
        '${_img}1533240332313-26a7de054b86?w=600',
      ],
      difficulty: null,
      bestSeason: 'May–Sep',
      tags: ['Backcountry', 'Bear Country', 'Moose', 'Permit Required'],
      hasFoodNearby: false,
      rating: 4.6,
      reviewCount: 189,
      distanceMiles: 8.5,
    ),
    const Place(
      id: 'p5',
      name: 'Portage Glacier',
      category: 'Scenic',
      description:
          'One of Alaska\'s most visited natural attractions. Take a boat across the lake for close-up views of the calving glacier face, or hike Byron Glacier trail into an ice cave.',
      latitude: 60.7756,
      longitude: -148.8642,
      images: [
        '${_img}1466978913421-dad2ebd01d17?w=600',
        '${_img}1578662996442-48f60103fc96?w=600',
      ],
      difficulty: 'Easy',
      bestSeason: 'May–Sep',
      tags: ['Glacier', 'Ice Cave', 'Boat Tour', 'Family'],
      hasFoodNearby: true,
      rating: 4.7,
      reviewCount: 423,
      distanceMiles: 49.0,
    ),
    const Place(
      id: 'p6',
      name: 'McNeil River Bear Viewing',
      category: 'Wildlife',
      description:
          'The world\'s largest protected gathering of brown bears. Watch dozens of bears catch sockeye salmon in the falls — a once-in-a-lifetime wildlife experience accessible only by permit lottery.',
      latitude: 59.3333,
      longitude: -154.5167,
      images: [
        '${_img}1589802829985-a45e978f367d?w=600',
        '${_img}1516467508483-a7212febe31a?w=600',
      ],
      difficulty: null,
      bestSeason: 'Jul–Aug',
      tags: ['Brown Bear', 'Permit Lottery', 'Remote', 'Fly-In Only'],
      hasFoodNearby: false,
      rating: 5.0,
      reviewCount: 64,
      distanceMiles: 290.0,
    ),
    const Place(
      id: 'p7',
      name: 'Hatcher Pass',
      category: 'Hidden Gems',
      description:
          'A stunning alpine valley above treeline with wildflower meadows, gold rush history, and some of the most dramatic tundra scenery accessible by road in all of Alaska.',
      latitude: 61.7689,
      longitude: -149.2664,
      images: [
        '${_img}1507608869338-e23aa06ad3bd?w=600',
        '${_img}1472214103451-9374769b6b68?w=600',
      ],
      difficulty: 'Moderate',
      bestSeason: 'Jun–Sep',
      tags: ['Alpine', 'Wildflowers', 'Gold Rush', 'ATV Friendly'],
      hasFoodNearby: false,
      rating: 4.8,
      reviewCount: 198,
      distanceMiles: 62.0,
    ),
    const Place(
      id: 'p8',
      name: 'Resurrection Pass Trail',
      category: 'Hikes',
      description:
          'A 39-mile multi-day trail through the heart of the Kenai Peninsula, passing alpine lakes, abundant wildlife, and historic gold rush cabins available for overnight rental.',
      latitude: 60.5203,
      longitude: -150.0014,
      images: [
        '${_img}1473580464409-d3b4b3da2cc7?w=600',
        '${_img}1538300342682-cf57b9c8b9ab?w=600',
      ],
      difficulty: 'Hard',
      bestSeason: 'Jun–Sep',
      tags: ['Backpacking', 'Multi-Day', 'Cabins', 'Wildlife'],
      hasFoodNearby: false,
      rating: 4.9,
      reviewCount: 142,
      distanceMiles: 95.0,
    ),
  ];

  static final List<Restaurant> restaurants = [
    const Restaurant(
      id: 'r1',
      name: 'Humpy\'s Great Alaskan Alehouse',
      cuisineType: 'Alaskan / Pub',
      description:
          'Anchorage\'s beloved craft beer bar and restaurant. Known for wild Alaska seafood, enormous burgers, and 50+ beers on tap. Lively atmosphere with live music.',
      latitude: 61.2181,
      longitude: -149.8936,
      priceRange: r'$$',
      hours: {
        'Mon–Thu': '11am–2am',
        'Fri–Sat': '11am–3am',
        'Sun': '11am–2am',
      },
      images: ['${_img}1414235077428-338989a2e8c0?w=600'],
      rating: 4.5,
      reviewCount: 1240,
      phone: '+1-907-276-2337',
    ),
    const Restaurant(
      id: 'r2',
      name: 'Simon & Seafort\'s',
      cuisineType: 'Seafood / Steakhouse',
      description:
          'Anchorage\'s premier fine dining destination with panoramic Cook Inlet views. Legendary for prime rib, king crab legs, and an award-winning wine list.',
      latitude: 61.2197,
      longitude: -149.8901,
      priceRange: r'$$$$',
      hours: {
        'Mon–Fri': '11:30am–10pm',
        'Sat–Sun': '4pm–10pm',
      },
      images: ['${_img}1517248135467-4c7edcad34c4?w=600'],
      rating: 4.7,
      reviewCount: 892,
      phone: '+1-907-274-3502',
    ),
    const Restaurant(
      id: 'r3',
      name: 'Moose\'s Tooth Pub & Pizzeria',
      cuisineType: 'Pizza / Brewery',
      description:
          'Anchorage institution with creative wood-fired pizzas and house-brewed craft beers. The Avalanche and Kodiak Arrest are fan favorites. Expect a wait — it\'s worth it.',
      latitude: 61.1919,
      longitude: -149.8450,
      priceRange: r'$$',
      hours: {
        'Mon–Thu': '11am–11pm',
        'Fri–Sat': '11am–12am',
        'Sun': '11am–11pm',
      },
      images: ['${_img}1513104890138-7c749659a591?w=600'],
      rating: 4.8,
      reviewCount: 2100,
      phone: '+1-907-258-2537',
    ),
    const Restaurant(
      id: 'r4',
      name: 'Kenai River Brewing',
      cuisineType: 'Brewery / Gastropub',
      description:
          'Soldotna\'s beloved craft brewery with Alaska-inspired beers and hearty pub food. Great stop before or after a day of fishing the Kenai River.',
      latitude: 60.4881,
      longitude: -151.0528,
      priceRange: r'$$',
      hours: {
        'Daily': '11am–10pm',
      },
      images: ['${_img}1559526324-593bc073d938?w=600'],
      rating: 4.6,
      reviewCount: 445,
      phone: '+1-907-262-2337',
    ),
    const Restaurant(
      id: 'r5',
      name: 'The Saltry',
      cuisineType: 'Alaskan Seafood',
      description:
          'Accessible only by water taxi from Homer, this legendary restaurant in Halibut Cove serves fresh halibut, king crab, and house-smoked salmon in an unforgettable wilderness setting.',
      latitude: 59.6169,
      longitude: -151.2053,
      priceRange: r'$$$',
      hours: {
        'Tue–Sun': '12pm–9pm',
        'Mon': 'Closed',
      },
      images: ['${_img}1414235077428-338989a2e8c0?w=600'],
      rating: 4.9,
      reviewCount: 320,
      phone: '+1-907-296-2424',
    ),
  ];

  static final List<RentalItem> rentalItems = [
    const RentalItem(
      id: 'rent1',
      name: 'Packraft Explorer Kit',
      description:
          'Alpacka Raft packraft with paddle, dry bag, and PFD. Lightweight enough to carry to remote rivers and lakes. Perfect for multi-day wilderness expeditions.',
      category: 'Water',
      pricePerDay: 95.0,
      images: ['${_img}1544551763-46a013bb70d5?w=600'],
      includedItems: ['Alpacka Raft', 'Carlisle paddle', 'NRS PFD', '20L dry bag', 'inflation bag'],
      recommendedFor: ['p3', 'p8'],
      available: true,
    ),
    const RentalItem(
      id: 'rent2',
      name: 'Bear Canister & Safety Pack',
      description:
          'BearVault BV500 bear canister, bear spray with holster, and emergency whistle. Required for overnight backcountry in many Alaska areas.',
      category: 'Safety',
      pricePerDay: 18.0,
      images: ['${_img}1504280390367-361c6d9f38f4?w=600'],
      includedItems: ['BearVault BV500', 'Bear spray (Counter Assault)', 'Holster', 'Emergency whistle'],
      recommendedFor: ['p4', 'p8', 'p6'],
      available: true,
    ),
    const RentalItem(
      id: 'rent3',
      name: 'Fly Fishing Outfit',
      description:
          'Complete 9\' 6wt fly rod setup for Alaska salmon fishing. Includes waders, wading boots, reel pre-spooled with line, and a selection of proven Alaska flies.',
      category: 'Fishing',
      pricePerDay: 75.0,
      images: ['${_img}1563013544-824ae1b704d3?w=600'],
      includedItems: [
        'Sage 9\' 6wt rod',
        'Abel reel with line',
        'Simms waders',
        'Wading boots',
        'Fly selection box',
        'Net',
      ],
      recommendedFor: ['p3'],
      available: true,
    ),
    const RentalItem(
      id: 'rent4',
      name: 'Mountaineering Boot Set',
      description:
          'La Sportiva Trango Tech boots with crampons and trekking poles. Stiff soles handle technical approaches and glacier travel with confidence.',
      category: 'Hiking',
      pricePerDay: 45.0,
      images: ['${_img}1531366936-rygzXESmFr8?w=600'],
      includedItems: ['La Sportiva boots (sized)', 'Petzl crampons', 'Black Diamond trekking poles (pair)'],
      recommendedFor: ['p1', 'p5', 'p7'],
      available: true,
    ),
    const RentalItem(
      id: 'rent5',
      name: 'Base Camp Tent Package',
      description:
          'MSR Access 3 four-season tent with sleeping pads and cook system. Handles Alaska weather from summer rain to shoulder-season snowfall.',
      category: 'Camping',
      pricePerDay: 65.0,
      images: ['${_img}1533240332313-26a7de054b86?w=600'],
      includedItems: [
        'MSR Access 3 tent',
        'Stakes & guy lines',
        '2x Therm-a-Rest NeoAir sleeping pads',
        'MSR WhisperLite stove',
        'Fuel canister',
        'Cook pot set',
      ],
      recommendedFor: ['p4', 'p8', 'p7'],
      available: true,
    ),
    const RentalItem(
      id: 'rent6',
      name: 'Spotty Satellite Communicator',
      description:
          'SPOT X two-way satellite communicator with 7-day battery. Send/receive messages and trigger SOS from anywhere in Alaska, with or without cell service.',
      category: 'Safety',
      pricePerDay: 22.0,
      images: ['${_img}1519583272095-6433daf26b6e?w=600'],
      includedItems: ['SPOT X device', 'Charging cable', 'Activation instructions', 'Carry case'],
      recommendedFor: ['p6', 'p8', 'p3'],
      available: false,
    ),
    const RentalItem(
      id: 'rent7',
      name: 'E-Bike Adventure Rental',
      description:
          'Trek Allant+ e-bike for exploring paved and gravel trails around Anchorage. Tackle the Tony Knowles Coastal Trail or Kincaid Park with ease.',
      category: 'Bikes',
      pricePerDay: 85.0,
      images: ['${_img}1558618047-3c9c0e1a62a5?w=600'],
      includedItems: ['Trek Allant+ e-bike', 'Helmet', 'Lock', 'Panniers', 'Charger'],
      recommendedFor: ['p1'],
      available: true,
    ),
    const RentalItem(
      id: 'rent8',
      name: 'Kayak Day Rental',
      description:
          'Necky Manitou 14 sea kayak with paddle, PFD, and spray skirt. Ideal for exploring Prince William Sound, Resurrection Bay, or Kachemak Bay.',
      category: 'Water',
      pricePerDay: 55.0,
      images: ['${_img}1544551763-46a013bb70d5?w=600'],
      includedItems: ['Necky Manitou 14 kayak', 'Werner paddle', 'PFD', 'Spray skirt', 'Dry bag'],
      recommendedFor: ['p2', 'p5'],
      available: true,
    ),
  ];

  static const List<String> rentalCategories = [
    'All',
    'Hiking',
    'Camping',
    'Water',
    'Fishing',
    'Bikes',
    'Safety',
  ];
}
