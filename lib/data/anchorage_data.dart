import 'package:latlong2/latlong.dart';

enum AnchoragePOICategory {
  fishing,
  lake,
  food,
  lodging,
  gearRental,
  trail,
  scenic,
  wildlife,
}

class AnchoragePOI {
  final String id;
  final String name;
  final AnchoragePOICategory category;
  final LatLng location;
  final String description;
  final String quickFact;
  final bool isFeatured;
  final bool isTurnagainOutfitters;
  final String? websiteUrl;
  final String? phone;
  final String? hours;
  final List<String> tags;
  final List<String> fishingSpecies;
  final String? fishingNotes;

  const AnchoragePOI({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.description,
    required this.quickFact,
    this.isFeatured = false,
    this.isTurnagainOutfitters = false,
    this.websiteUrl,
    this.phone,
    this.hours,
    this.tags = const [],
    this.fishingSpecies = const [],
    this.fishingNotes,
  });
}

class AnchorageData {
  static const double boundsNorth = 61.245;
  static const double boundsSouth = 61.12;
  static const double boundsEast = -149.75;
  static const double boundsWest = -149.95;

  static bool isInAnchorage(double lat, double lng) {
    return lat <= boundsNorth &&
        lat >= boundsSouth &&
        lng <= boundsEast &&
        lng >= boundsWest;
  }

  static const List<AnchoragePOI> pois = [
    AnchoragePOI(
      id: 'turnagain-outfitters',
      name: 'Turnagain Outfitters',
      category: AnchoragePOICategory.gearRental,
      location: LatLng(61.1958, -149.8841),
      description:
          'Fishing & camping gear rentals, Starlink kits, and local know-how. '
          'The Atlas\' gear partner in Anchorage.',
      quickFact: 'Gear rentals · Local outfitter',
      isFeatured: true,
      isTurnagainOutfitters: true,
      websiteUrl: 'https://turnagainoutfitters.com',
      phone: '(907) 555-0182',
      hours: 'Daily 7am–7pm',
      tags: ['gear', 'rentals', 'outfitter'],
    ),
    AnchoragePOI(
      id: 'ship-creek',
      name: 'Ship Creek',
      category: AnchoragePOICategory.fishing,
      location: LatLng(61.2230, -149.8915),
      description:
          'A king and silver salmon fishery running right through downtown '
          'Anchorage — famous for being one of the only urban salmon streams '
          'in the country.',
      quickFact: 'Urban salmon run · Downtown',
      isFeatured: true,
      tags: ['salmon', 'urban fishing'],
      fishingSpecies: ['King Salmon', 'Coho Salmon', 'Pink Salmon'],
      fishingNotes:
          'King run peaks late May–June, silvers run August. Check ADF&G '
          'regs for the derby and bag limits.',
    ),
    AnchoragePOI(
      id: 'jewel-lake',
      name: 'Jewel Lake',
      category: AnchoragePOICategory.lake,
      location: LatLng(61.1397, -149.9214),
      description:
          'A stocked neighborhood lake popular with families for easy bank '
          'fishing and a calm paddle.',
      quickFact: 'Stocked lake · Bank fishing',
      tags: ['stocked', 'family friendly'],
      fishingSpecies: ['Rainbow Trout', 'Arctic Char'],
      fishingNotes: 'Stocked spring and fall; bank access on the south shore.',
    ),
    AnchoragePOI(
      id: 'goose-lake',
      name: 'Goose Lake',
      category: AnchoragePOICategory.lake,
      location: LatLng(61.2032, -149.8270),
      description:
          'Midtown lake with a sand beach, swimming dock, and easy stocked '
          'fishing minutes from downtown.',
      quickFact: 'Midtown · Beach + fishing',
      tags: ['stocked', 'swimming'],
      fishingSpecies: ['Rainbow Trout'],
      fishingNotes: 'Best fished early morning off the south dock.',
    ),
    AnchoragePOI(
      id: 'sand-lake',
      name: 'Sand Lake',
      category: AnchoragePOICategory.lake,
      location: LatLng(61.1531, -149.9521),
      description: 'Quiet residential lake popular for float-plane traffic and light fishing.',
      quickFact: 'Float planes · Quiet fishing',
      tags: ['floatplane'],
      fishingSpecies: ['Rainbow Trout'],
    ),
    AnchoragePOI(
      id: 'eklutna-lake',
      name: 'Eklutna Lake',
      category: AnchoragePOICategory.lake,
      location: LatLng(61.4083, -149.1722),
      description:
          'Glacial lake just outside the city with turquoise water, lake '
          'trout, and a popular bike/hike trail along the shore.',
      quickFact: 'Glacial lake · Lake trout',
      isFeatured: true,
      tags: ['glacial', 'trail access'],
      fishingSpecies: ['Lake Trout', 'Dolly Varden'],
      fishingNotes: 'Boat or kayak access reaches better trout water up-lake.',
    ),
    AnchoragePOI(
      id: 'kincaid-park',
      name: 'Kincaid Park',
      category: AnchoragePOICategory.trail,
      location: LatLng(61.1397, -149.9697),
      description:
          'Coastal forest park with world-class singletrack and ski trails, '
          'plus moose sightings along nearly every path.',
      quickFact: 'Singletrack · Moose country',
      tags: ['hiking', 'biking', 'skiing'],
    ),
    AnchoragePOI(
      id: 'flattop-mountain',
      name: 'Flattop Mountain',
      category: AnchoragePOICategory.trail,
      location: LatLng(61.0867, -149.6364),
      description:
          'Anchorage\'s most-climbed peak — a steep but short hike with one '
          'of the best panoramic views of the city and Cook Inlet.',
      quickFact: 'Most-climbed peak · City views',
      isFeatured: true,
      tags: ['hiking', 'views'],
    ),
    AnchoragePOI(
      id: 'coastal-trail',
      name: 'Tony Knowles Coastal Trail',
      category: AnchoragePOICategory.scenic,
      location: LatLng(61.2090, -149.9120),
      description:
          'An 11-mile paved trail tracing the coastline from downtown to '
          'Kincaid Park, with views across Cook Inlet to the Alaska Range.',
      quickFact: '11 miles · Coastal views',
      tags: ['biking', 'walking', 'views'],
    ),
    AnchoragePOI(
      id: 'awcc',
      name: 'Alaska Wildlife Conservation Center',
      category: AnchoragePOICategory.wildlife,
      location: LatLng(60.8453, -149.1758),
      description:
          'A rescue and rehab center on the Seward Highway where you can '
          'reliably see bears, moose, and wood bison up close.',
      quickFact: 'Wildlife rescue center',
      tags: ['bears', 'moose', 'family friendly'],
    ),
    AnchoragePOI(
      id: 'humpys',
      name: "Humpy's Great Alaskan Alehouse",
      category: AnchoragePOICategory.food,
      location: LatLng(61.2160, -149.8950),
      description:
          'Downtown institution for fresh halibut tacos and a deep local '
          'beer list after a day on the water.',
      quickFact: 'Halibut tacos · Local beer',
      tags: ['seafood', 'downtown'],
    ),
    AnchoragePOI(
      id: 'snow-city-cafe',
      name: 'Snow City Cafe',
      category: AnchoragePOICategory.food,
      location: LatLng(61.2169, -149.8980),
      description:
          'Beloved breakfast spot downtown — expect a line on weekends and '
          'a menu worth the wait.',
      quickFact: 'Breakfast institution',
      tags: ['breakfast', 'downtown'],
    ),
    AnchoragePOI(
      id: 'double-musky',
      name: 'The Double Musky Inn',
      category: AnchoragePOICategory.food,
      location: LatLng(60.7497, -149.1133),
      description:
          'A Girdwood roadhouse classic — Cajun-influenced Alaska seafood '
          'worth the drive down Turnagain Arm.',
      quickFact: 'Girdwood · Cajun seafood',
      tags: ['seafood', 'girdwood'],
    ),
    AnchoragePOI(
      id: 'captain-cook-hotel',
      name: 'Hotel Captain Cook',
      category: AnchoragePOICategory.lodging,
      location: LatLng(61.2163, -149.8934),
      description: 'Anchorage\'s flagship downtown hotel, walkable to Ship Creek and the harbor.',
      quickFact: 'Downtown flagship hotel',
      tags: ['downtown', 'luxury'],
    ),
    AnchoragePOI(
      id: 'lakefront-hotel',
      name: 'Lakefront Anchorage',
      category: AnchoragePOICategory.lodging,
      location: LatLng(61.1739, -150.0086),
      description:
          'Hotel on Lake Hood, the world\'s busiest float-plane base — '
          'watch planes take off right from the lobby windows.',
      quickFact: 'On Lake Hood floatplane base',
      tags: ['lake hood', 'floatplanes'],
    ),
  ];
}
