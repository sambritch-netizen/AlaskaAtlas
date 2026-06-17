import '../models/species.dart';

/// Alaska wildlife field guide — used by the Guides "Birds" and
/// "Land Animals" sub-categories.
class WildlifeSpeciesData {
  WildlifeSpeciesData._();

  static const List<Species> all = [
    // ============== BIRDS ==============
    Species(
      id: 'bald-eagle',
      name: 'Bald Eagle',
      scientificName: 'Haliaeetus leucocephalus',
      emoji: '🦅',
      subcategory: 'Birds',
      overview:
          'The bald eagle is one of the most iconic and abundant raptors in Alaska, with the state hosting the largest population in North America. '
          'These powerful birds of prey are commonly seen perched along rivers and coastlines, especially where salmon are running. '
          'Alaska Natives consider the eagle a symbol of strength and wisdom, and it features prominently in regional art and culture.',
      habitat:
          'Found statewide near coastlines, rivers, and lakes, especially in Southeast Alaska. The Chilkat River near Haines hosts one of the largest seasonal gatherings in the world.',
      size: 'Wingspan 6–7.5 ft; body length 28–40 in; weight 6.5–14 lbs',
      season: 'Year-round, with the largest concentrations in late fall (October–December)',
      facts: [
        'Alaska is home to over 30,000 bald eagles, more than the rest of the U.S. combined.',
        'They build some of the largest tree nests of any bird, sometimes weighing over a ton after years of reuse.',
        'Despite their name, bald eagles are not bald — "bald" derives from an old word meaning white-headed.',
        'A single eagle can spot a fish from over a mile away thanks to extraordinary eyesight.',
      ],
      tips:
          'The Chilkat Bald Eagle Preserve near Haines is the premier viewing spot, with thousands of eagles gathering each fall to feed on late salmon runs. '
          'Look for them perched in tall cottonwoods along riverbanks or soaring on thermals over coastal bluffs. Early morning light along the water provides the best photography conditions, and a spotting scope helps avoid disturbing nesting birds.',
      baits: [],
    ),
    Species(
      id: 'golden-eagle',
      name: 'Golden Eagle',
      scientificName: 'Aquila chrysaetos',
      emoji: '🦅',
      subcategory: 'Birds',
      overview:
          'Golden eagles are powerful, far-ranging raptors that favor Alaska\'s open mountains and tundra rather than the coastal forests preferred by bald eagles. '
          'They are formidable hunters capable of taking down animals as large as young caribou calves or Dall sheep lambs. '
          'Many Alaska golden eagles migrate remarkable distances, with some tracked traveling over 4,000 miles to and from the state each year.',
      habitat:
          'Found in interior and arctic Alaska, favoring alpine tundra, mountain foothills, and open country away from dense forest.',
      size: 'Wingspan 6–7.5 ft; body length 26–40 in; weight 6.5–13 lbs',
      season: 'Spring and fall migration (March–May and August–October) offer the best viewing as birds funnel through mountain passes',
      facts: [
        'Golden eagles can dive at speeds exceeding 150 mph when hunting.',
        'They are sometimes confused with juvenile bald eagles, which also lack white head feathers.',
        'A breeding pair may maintain a territory of over 60 square miles in Alaska\'s sparse interior.',
        'Some Alaska-breeding golden eagles winter as far south as the desert Southwest.',
      ],
      tips:
          'Look for them riding thermals along ridgelines in the Alaska Range, Brooks Range, or Denali National Park, particularly during spring migration when concentrations pass through mountain passes like Gunsight Mountain on the Glenn Highway. '
          'Scan rocky cliffs for nests and watch for eagles hunting ground squirrels or hares on open tundra slopes during early morning hours.',
      baits: [],
    ),
    Species(
      id: 'trumpeter-swan',
      name: 'Trumpeter Swan',
      scientificName: 'Cygnus buccinator',
      emoji: '🦢',
      subcategory: 'Birds',
      overview:
          'The trumpeter swan is North America\'s largest native waterfowl species, and Alaska supports the majority of the world\'s breeding population. '
          'These elegant white birds nest on remote ponds and wetlands across the state, raising cygnets through the short Alaska summer. '
          'Their deep, resonant calls carry for long distances across quiet lakes and marshes.',
      habitat:
          'Breeds on shallow lakes, ponds, and wetlands throughout the Copper River Delta, Kenai Peninsula, and interior lowlands.',
      size: 'Length 5–6 ft; wingspan up to 8 ft; weight 21–30 lbs',
      season: 'Summer (May–September) for breeding pairs; spring and fall for migration staging',
      facts: [
        'Alaska hosts roughly 15,000 trumpeter swans, the largest breeding concentration on Earth.',
        'They mate for life and often return to the same nesting territory year after year.',
        'A cygnet must travel hundreds of miles south before its first winter, guided by its parents.',
        'Their namesake call is a loud, brassy honk that can be heard from over a mile away.',
      ],
      tips:
          'The Copper River Delta near Cordova and wetlands along the Kenai Peninsula are excellent locations to see nesting pairs in summer. '
          'Use binoculars from a distance to avoid disturbing nests hidden in marsh grass, and visit at dawn or dusk when swans are most active feeding on aquatic vegetation.',
      baits: [],
    ),
    Species(
      id: 'willow-ptarmigan',
      name: 'Willow Ptarmigan',
      scientificName: 'Lagopus lagopus',
      emoji: '🐦',
      subcategory: 'Birds',
      overview:
          'The willow ptarmigan is Alaska\'s official state bird, a hardy grouse-like species perfectly adapted to survive brutal arctic winters. '
          'It undergoes a dramatic seasonal transformation, molting from mottled brown summer plumage to pure white in winter for camouflage against snow. '
          'Flocks can number in the hundreds during winter as birds gather in willow thickets to feed.',
      habitat:
          'Common across tundra, willow thickets, and shrubby lowlands throughout arctic and alpine Alaska.',
      size: 'Length 14–17 in; weight 1–1.5 lbs',
      season: 'Year-round; most visible in winter against snow or during spring breeding displays',
      facts: [
        'Feathered feet act like snowshoes, helping ptarmigan walk on top of deep snow.',
        'Males perform loud, raucous courtship displays in spring, often described as a barking laugh.',
        'They dig burrows into snowbanks to roost overnight, conserving body heat.',
        'Willow ptarmigan was named Alaska\'s state bird in 1955, before statehood was even granted.',
      ],
      tips:
          'Look for them along alpine tundra trails such as those in Denali National Park or the Chugach foothills near Anchorage, particularly in willow and dwarf birch shrub zones. '
          'In winter, their white plumage makes them nearly invisible until they move — watch for sudden flushes of birds bursting from the snow underfoot.',
      baits: [],
    ),
    Species(
      id: 'spruce-grouse',
      name: 'Spruce Grouse',
      scientificName: 'Falcipennis canadensis',
      emoji: '🐦',
      subcategory: 'Birds',
      overview:
          'The spruce grouse is a plump, ground-dwelling bird of Alaska\'s boreal forest, often nicknamed the "fool hen" for its tendency to sit motionless rather than flee from approaching hikers. '
          'Males perform dramatic tail-fanning and wing-clapping displays during spring breeding season. '
          'Their diet shifts heavily to spruce needles in winter, giving their meat a distinctive resinous flavor.',
      habitat:
          'Resident of dense spruce and mixed conifer forests throughout interior and southcentral Alaska.',
      size: 'Length 15–17 in; weight 1–1.5 lbs',
      season: 'Year-round; spring (April–May) is best for observing male display behavior',
      facts: [
        'Spruce grouse rely on camouflage so heavily that they often allow people to walk within a few feet.',
        'In winter they roost and feed almost entirely in spruce trees, eating needles for weeks at a time.',
        'Males have a bright red comb of skin above the eye, displayed prominently during courtship.',
        'Chicks can fly short distances within days of hatching to escape predators.',
      ],
      tips:
          'Walk quietly along forest trails in spruce-dominated woods, scanning the ground and low branches — spruce grouse often freeze in place and are easy to walk past unnoticed. '
          'Spring mornings near forest edges are best for hearing males drumming and displaying.',
      baits: [],
    ),
    Species(
      id: 'common-raven',
      name: 'Common Raven',
      scientificName: 'Corvus corax',
      emoji: '🐦‍⬛',
      subcategory: 'Birds',
      overview:
          'The common raven is one of the most intelligent birds in the world and a year-round fixture across Alaska, from remote wilderness to downtown Anchorage. '
          'Ravens hold deep cultural significance for many Alaska Native peoples, often appearing as a trickster or creator figure in traditional stories. '
          'They are remarkably adaptable, thriving in temperatures from -50°F to summer heat by scavenging, hunting, and raiding food caches.',
      habitat:
          'Found statewide in virtually every habitat, from arctic tundra and boreal forest to coastal towns and cities.',
      size: 'Length 22–27 in; wingspan up to 4 ft; weight 2–4 lbs',
      season: 'Year-round',
      facts: [
        'Ravens can mimic sounds including human speech, wolf howls, and other bird calls.',
        'They are known to play, sliding down snowbanks and tumbling in flight for apparent fun.',
        'Ravens form lifelong pair bonds and can live over 20 years in the wild.',
        'They sometimes work cooperatively with wolves, leading them to prey in exchange for scraps.',
      ],
      tips:
          'No special effort is needed — ravens are common in nearly every Alaska community and along roadsides. '
          'Watch for their acrobatic flight displays and problem-solving behavior, such as opening latches or food containers, especially around campgrounds and parking areas.',
      baits: [],
    ),
    Species(
      id: 'great-horned-owl',
      name: 'Great Horned Owl',
      scientificName: 'Bubo virginianus',
      emoji: '🦉',
      subcategory: 'Birds',
      overview:
          'The great horned owl is one of Alaska\'s largest and most powerful owls, a formidable nocturnal predator capable of taking prey as large as snowshoe hares and even small foxes. '
          'Its deep, resonant hooting call is a familiar sound of Alaska\'s forested nights, especially during winter courtship season. '
          'Distinctive feather tufts resembling "horns" and piercing yellow eyes give the species its memorable appearance.',
      habitat:
          'Found in forested areas throughout southcentral and interior Alaska, including wooded parks within Anchorage and Fairbanks.',
      size: 'Length 18–25 in; wingspan up to 4.5 ft; weight 3–5.5 lbs',
      season: 'Year-round; calling activity peaks in late winter (January–March) during breeding season',
      facts: [
        'Their silent flight is enabled by specialized soft, fringed feather edges.',
        'Great horned owls have one of the most varied diets of any North American raptor.',
        'They begin nesting in late winter, often before snow has melted, reusing old hawk or raven nests.',
        'A great horned owl\'s grip strength can exert pressure of around 300 psi.',
      ],
      tips:
          'Listen for their deep "hoo-h\'HOO-hoo-hoo" calls at dusk or after dark in wooded areas near Anchorage\'s Kincaid Park or Fairbanks\' forested greenbelts, particularly in late winter. '
          'Use a red-filtered flashlight to avoid disturbing the bird if you locate one roosting, and remain still and quiet for the best chance of a sighting.',
      baits: [],
    ),
    Species(
      id: 'sandhill-crane',
      name: 'Sandhill Crane',
      scientificName: 'Antigone canadensis',
      emoji: '🦩',
      subcategory: 'Birds',
      overview:
          'Sandhill cranes are tall, elegant birds known for their rolling, bugling calls and spectacular fall migration gatherings. '
          'Alaska\'s breeding population nests across open tundra and wetlands before undertaking long journeys to wintering grounds in the Lower 48 and Mexico. '
          'Their unison courtship dances, involving leaps, bows, and wing-flapping, are among the most striking displays in the bird world.',
      habitat:
          'Breeds in open tundra, bogs, and wet meadows across interior and southcentral Alaska, including the Matanuska-Susitna Valley.',
      size: 'Height 3.3–4 ft; wingspan up to 6.5 ft; weight 6.5–14 lbs',
      season: 'Fall migration staging (late August–September) offers the most dramatic viewing',
      facts: [
        'Thousands of sandhill cranes stage in the Matanuska-Susitna Valley each September before migrating south.',
        'Their distinctive rattling call can carry over a mile across open country.',
        'Sandhill cranes are among the oldest known bird species, with fossil records dating back millions of years.',
        'Pairs perform synchronized dancing displays that strengthen their lifelong bonds.',
      ],
      tips:
          'Visit the Creamer\'s Field Migratory Waterfowl Refuge in Fairbanks or fields around Palmer in late August and September to watch large flocks staging before migration. '
          'Cranes are often seen feeding in agricultural fields at dawn and dusk — scan open ground with binoculars and listen for their loud rattling calls overhead.',
      baits: [],
    ),

    // ============== LAND ANIMALS ==============
    Species(
      id: 'brown-bear',
      name: 'Brown Bear / Grizzly',
      scientificName: 'Ursus arctos',
      emoji: '🐻',
      subcategory: 'Land Animals',
      overview:
          'Brown bears, including the inland grizzly and coastal brown bear, are among Alaska\'s most iconic and powerful animals, with the state home to roughly 30,000 of them — about 70% of the U.S. population. '
          'Coastal bears grow especially large by gorging on salmon during summer runs, while interior grizzlies rely more on berries, roots, and occasional prey. '
          'Bears are generally solitary except for mothers with cubs or seasonal gatherings at salmon streams.',
      habitat:
          'Found throughout Alaska except some islands, with the highest densities along salmon-rich coastal areas like Katmai and Kodiak.',
      size: 'Length 6–9 ft; weight 300–900 lbs for males, with coastal bears reaching over 1,000 lbs',
      season: 'Summer (June–September) for salmon-stream viewing; bears are dormant in dens roughly November–April',
      facts: [
        'Brown bears can run up to 35 mph despite their bulk.',
        'A bear\'s sense of smell is estimated to be up to seven times stronger than a bloodhound\'s.',
        'Coastal "brown bears" and inland "grizzlies" are the same species, differing mainly due to diet and habitat.',
        'Brooks Falls in Katmai National Park is world-famous for bears catching leaping salmon.',
      ],
      tips:
          'Katmai National Park\'s Brooks Falls and Kodiak Island offer some of the best viewing platforms for watching bears fish, often from elevated, protected viewing decks. '
          'Always maintain at least 300 feet (100 yards) of distance from bears, never approach for photos, store food securely, make noise while hiking to avoid surprise encounters, and carry bear spray. If you encounter a bear, stay calm, back away slowly, and do not run.',
      baits: [],
      caution: 'Extremely dangerous. Maintain at least 300 ft distance, never approach, secure food and scented items, and carry bear spray. Surprise encounters can trigger defensive attacks.',
    ),
    Species(
      id: 'black-bear',
      name: 'Black Bear',
      scientificName: 'Ursus americanus',
      emoji: '🐻',
      subcategory: 'Land Animals',
      overview:
          'Black bears are the most widespread and numerous bear species in Alaska, smaller and generally less aggressive than brown bears but still capable of dangerous encounters. '
          'They are excellent climbers and often forage in forested areas for berries, vegetation, insects, and occasionally fish or small mammals. '
          'Despite the name, Alaska black bears can range in color from jet black to brown or even cinnamon.',
      habitat:
          'Common in forested regions of southcentral, southeast, and interior Alaska, generally avoiding the open tundra favored by brown bears.',
      size: 'Length 4–6 ft; weight 125–400 lbs',
      season: 'Spring through fall (April–October); dormant in dens during winter',
      facts: [
        'Black bears are skilled tree climbers, even as adults, which helps cubs escape predators.',
        'Alaska\'s population is estimated at over 100,000 black bears, far more than brown bears.',
        'Some coastal populations feed heavily on salmon during summer runs, similar to brown bears.',
        'A rare blue-gray color phase called the "glacier bear" occurs in parts of Southeast Alaska.',
      ],
      tips:
          'Look for black bears along forest edges, berry patches, and salmon streams in places like the Kenai Peninsula or Tongass National Forest, especially in early morning or evening. '
          'Maintain at least 100 yards of distance, never get between a sow and her cubs, store food in bear-resistant containers, and make noise while hiking to avoid surprising one.',
      baits: [],
      caution: 'Can be dangerous, especially mothers with cubs. Keep at least 100 yards away, store food securely, and never run if a bear approaches — back away slowly.',
    ),
    Species(
      id: 'moose',
      name: 'Moose',
      scientificName: 'Alces alces',
      emoji: '🫎',
      subcategory: 'Land Animals',
      overview:
          'The moose is the largest member of the deer family and an unmistakable symbol of Alaska, often seen browsing on willows in backyards, parks, and roadside ditches. '
          'Bulls grow massive paddle-shaped antlers each year, shedding and regrowing them annually, with the largest racks spanning over 6 feet. '
          'Despite their size, moose are surprisingly common in and around Alaska\'s cities, including Anchorage.',
      habitat:
          'Found throughout Alaska in willow thickets, wetlands, boreal forest, and even urban green spaces in Anchorage and Fairbanks.',
      size: 'Height 5–6.5 ft at shoulder; weight 800–1,600 lbs for bulls',
      season: 'Year-round; fall rut (September–October) is when bulls are most active and visible',
      facts: [
        'Alaska moose are the largest of all moose subspecies, with bulls weighing up to 1,600 pounds.',
        'A moose can run up to 35 mph and swim across lakes and rivers with ease.',
        'Antlers can grow over an inch per day during peak summer growth.',
        'Moose are responsible for more human injuries in Alaska annually than bears.',
      ],
      tips:
          'Moose are frequently seen along the Seward Highway, in Anchorage\'s greenbelts, and around Denali National Park, especially at dawn and dusk when they feed on willow and aquatic plants. '
          'Give moose plenty of space — at least 25 yards — and never approach a cow with calves or a bull during the fall rut. If a moose flattens its ears or raises its hackles, move away immediately; they can charge and deliver powerful kicks.',
      baits: [],
      caution: 'Can be aggressive, especially cows with calves and bulls during the fall rut. Keep at least 25 yards away and retreat immediately if a moose displays aggressive posture.',
    ),
    Species(
      id: 'caribou',
      name: 'Caribou',
      scientificName: 'Rangifer tarandus',
      emoji: '🦌',
      subcategory: 'Land Animals',
      overview:
          'Caribou are nomadic members of the deer family famous for their massive seasonal migrations, with some herds traveling over 1,000 miles annually — among the longest land migrations on Earth. '
          'Both males and females grow antlers, a rarity among deer species. '
          'Caribou are central to the subsistence culture of many Alaska Native communities, particularly in arctic and interior regions.',
      habitat:
          'Found across arctic tundra, the Brooks Range, and interior Alaska, with major herds including the Western Arctic and Porcupine caribou herds.',
      size: 'Height 3.5–4.5 ft at shoulder; weight 150–400 lbs',
      season: 'Late summer and fall (August–October) during migration movements',
      facts: [
        'The Western Arctic Herd is one of the largest caribou herds in North America, numbering in the hundreds of thousands historically.',
        'Caribou hooves change shape seasonally, becoming broader in winter to act like snowshoes.',
        'Their clicking knee tendons make a distinctive sound audible when large herds move.',
        'Caribou can swim across wide rivers during migration, including the Yukon River.',
      ],
      tips:
          'The Dalton Highway and Denali National Park offer chances to spot caribou herds crossing roads or open tundra, especially during fall migration. '
          'Watch from a distance with binoculars, as herds can appear suddenly and move quickly across the landscape — give animals room to pass without blocking their path.',
      baits: [],
    ),
    Species(
      id: 'dall-sheep',
      name: 'Dall Sheep',
      scientificName: 'Ovis dalli',
      emoji: '🐑',
      subcategory: 'Land Animals',
      overview:
          'Dall sheep are sure-footed mountain dwellers known for their pure white coats and the curling horns grown by rams, which are used in dramatic head-butting contests during the fall rut. '
          'They live in some of Alaska\'s steepest and most rugged terrain, relying on cliffs and rocky outcrops to evade predators like wolves and eagles. '
          'Denali National Park\'s Polychrome area is famous for accessible sheep viewing.',
      habitat:
          'Resident of alpine and subalpine mountain terrain throughout the Alaska Range, Chugach Mountains, and Brooks Range.',
      size: 'Height 3 ft at shoulder; weight 100–125 lbs for rams, 75–110 lbs for ewes',
      season: 'Summer (June–August) for high-elevation viewing; rams descend lower during the November rut',
      facts: [
        'A ram\'s horns can weigh up to 30 pounds, nearly as much as all the bones in its body combined.',
        'Dall sheep can navigate near-vertical rock faces with remarkable agility.',
        'Rams establish dominance through head-butting clashes that can be heard from a distance.',
        'Their white coats provide near-perfect camouflage against snowy peaks for much of the year.',
      ],
      tips:
          'Scan high rocky slopes and ridgelines with binoculars or a spotting scope along the Seward Highway near Anchorage (Windy Corner) or in Denali National Park\'s Polychrome Pass area. '
          'Sheep are most active feeding in early morning and evening; look for small white dots moving against gray scree slopes far above the road.',
      baits: [],
    ),
    Species(
      id: 'gray-wolf',
      name: 'Gray Wolf',
      scientificName: 'Canis lupus',
      emoji: '🐺',
      subcategory: 'Land Animals',
      overview:
          'The gray wolf is a highly social predator living in packs that cooperatively hunt moose, caribou, and Dall sheep across Alaska\'s vast wilderness. '
          'Alaska\'s wolf population, estimated between 7,000 and 11,000, is one of the healthiest in North America and plays a key role in regulating prey populations. '
          'Wolves are elusive and rarely seen, making any sighting a memorable wilderness experience.',
      habitat:
          'Found throughout mainland Alaska in forest, tundra, and mountain habitats, with healthy populations in Denali National Park.',
      size: 'Length 4.5–6.5 ft including tail; weight 70–120 lbs',
      season: 'Year-round, though winter tracking on snow can reveal recent activity',
      facts: [
        'Wolf packs typically consist of 6–12 individuals, usually a family group led by a breeding pair.',
        'Wolves can travel over 30 miles in a single day while hunting or patrolling territory.',
        'Howls help packs communicate over long distances and reinforce social bonds.',
        'Denali National Park has been a key site for long-term wolf research since the 1930s.',
      ],
      tips:
          'Sightings are rare and largely a matter of luck — Denali National Park\'s road corridor and the Glenn Highway area offer the best odds, especially scanning open tundra and riverbeds at dawn or dusk. '
          'If you encounter a wolf, do not approach or feed it; back away slowly while making noise, and keep small pets close, as wolves may view them as prey or competitors.',
      baits: [],
      caution: 'Wolves rarely approach humans but should never be fed or approached. Keep dogs leashed and back away slowly if a wolf is encountered at close range.',
    ),
    Species(
      id: 'lynx',
      name: 'Lynx',
      scientificName: 'Lynx canadensis',
      emoji: '🐱',
      subcategory: 'Land Animals',
      overview:
          'The Canada lynx is a secretive, medium-sized wild cat perfectly adapted for hunting snowshoe hares, its primary prey, across Alaska\'s boreal forests. '
          'Lynx populations rise and fall in close cycles tied to hare abundance, sometimes fluctuating dramatically over a decade. '
          'Their large, padded paws act like snowshoes, allowing them to move efficiently atop deep snow while pursuing prey.',
      habitat:
          'Found in boreal forest throughout interior and southcentral Alaska, generally avoiding open tundra and coastal rainforest.',
      size: 'Length 2.5–3.5 ft; weight 15–35 lbs',
      season: 'Year-round, though winter tracks in snow are the most common evidence of their presence',
      facts: [
        'Lynx populations can fluctuate by tenfold over roughly 10-year cycles tied to snowshoe hare numbers.',
        'Their oversized paws can be nearly 4 inches across, distributing weight on snow.',
        'Distinctive black ear tufts and a short, "bobbed" tail help distinguish lynx from other cats.',
        'Lynx are mostly nocturnal and crepuscular, hunting primarily at dawn, dusk, and night.',
      ],
      tips:
          'Lynx are rarely seen due to their secretive, mostly nocturnal habits — look for distinctive large round tracks in fresh snow along forest trails in interior Alaska. '
          'Remote wildlife cameras near hare-rich willow and spruce thickets offer the best chance of documenting activity; direct sightings are considered a rare treat.',
      baits: [],
    ),
    Species(
      id: 'wolverine',
      name: 'Wolverine',
      scientificName: 'Gulo gulo',
      emoji: '🦡',
      subcategory: 'Land Animals',
      overview:
          'The wolverine is a powerful, low-slung member of the weasel family with a reputation for ferocity far exceeding its size, capable of driving bears and wolves away from carcasses. '
          'It roams enormous territories across remote Alaska wilderness in search of carrion, small mammals, and birds, especially during the lean winter months. '
          'Wolverines are notoriously difficult to study and observe due to their vast ranges and low population densities.',
      habitat:
          'Found across remote interior, arctic, and mountainous regions of Alaska, requiring large, undisturbed wilderness territories.',
      size: 'Length 2.5–3.5 ft including tail; weight 20–55 lbs',
      season: 'Year-round; winter tracking on snow offers the best chance of detecting sign',
      facts: [
        'A single wolverine\'s territory can exceed 500 square miles.',
        'Their thick, frost-resistant fur was historically prized for parka ruffs because it doesn\'t hold frost from breath.',
        'Wolverines can crush bones with powerful jaws to access marrow other predators leave behind.',
        'They are capable of taking down prey much larger than themselves, including young moose, when desperate.',
      ],
      tips:
          'Sightings are extremely rare due to low densities and vast home ranges — winter is the best time to look for distinctive five-toed tracks with long claw marks in remote backcountry areas of the Brooks Range or Alaska Range. '
          'If encountered, observe from a distance and do not approach; wolverines are normally shy but can become defensive if cornered near a food cache.',
      baits: [],
      caution: 'Generally avoids humans but can be aggressive if cornered or near a food cache. Observe from a distance and never attempt to approach.',
    ),
  ];
}
