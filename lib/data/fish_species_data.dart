import '../models/species.dart';

/// Alaska game fish field guide — used by the Guides "Fish Species" sub-category.
class FishSpeciesData {
  FishSpeciesData._();

  static const List<Species> all = [
    Species(
      id: 'king-salmon',
      name: 'King Salmon (Chinook)',
      scientificName: 'Oncorhynchus tshawytscha',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'The largest of the Pacific salmon, king salmon are the prized trophy catch of Alaska '
          'sport fishing. Powerful runs and acrobatic fights make them a bucket-list species, '
          'and their rich, oily flesh is considered the finest table fare of any salmon.',
      habitat:
          'Found in major river systems such as the Kenai, Kasilof, Copper, and Nushagak, as '
          'well as coastal saltwater bays and inlets during their spring and summer migrations '
          'back to spawn.',
      size: 'Typically 15-40 lbs, with trophy fish exceeding 50 lbs and the Alaska record over 97 lbs',
      season: 'Late May through July, with the Kenai River seeing two distinct runs',
      facts: [
        'The world record king salmon, 97 lbs 4 oz, was caught on the Kenai River in 1985.',
        'Kings can travel hundreds of miles upriver, navigating by smell back to their home stream.',
        'Juvenile kings may spend one to two years in fresh water before heading to sea.',
        'They are known locally simply as "kings" and are Alaska\'s official state fish.',
      ],
      tips:
          'Drift or back-troll large herring, sardine wraps, or spinners along deep river runs '
          'where kings rest during their upstream push. In saltwater, downriggers with herring or '
          'large plugs work well near tide rips and current seams. Slow, deep presentations are '
          'key—kings often hug the bottom and hit subtly, so watch your rod tip closely.',
      baits: [
        'Herring',
        'Spinners',
        'Salmon Roe',
        'Large Plugs',
        'Sardine Wraps',
        'Spoons',
      ],
      caution:
          'King salmon retention is heavily regulated and subject to emergency closures; always '
          'check current Alaska Department of Fish and Game (ADF&G) announcements before fishing.',
    ),
    Species(
      id: 'silver-salmon',
      name: 'Silver Salmon (Coho)',
      scientificName: 'Oncorhynchus kisutch',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'Silver salmon, or coho, are famous for their aggressive strikes and aerial fights, '
          'making them one of the most fun species to target on rod and reel. Bright chrome '
          'fish fresh from the ocean give way to deep red and green spawning colors as the '
          'season progresses.',
      habitat:
          'Common in coastal rivers, streams, and saltwater near river mouths throughout '
          'Southcentral and Southeast Alaska, including the Kenai Peninsula, Prince William '
          'Sound, and Kodiak Island.',
      size: 'Typically 8-12 lbs, with larger fish reaching 15-20 lbs',
      season: 'Late July through October, peaking in August and September',
      facts: [
        'Coho are nicknamed "silvers" for their bright, chrome-like ocean coloration.',
        'They are famous for repeated jumps and long runs when hooked.',
        'Coho often hold in slower side channels and behind current breaks.',
        'Late-season silvers develop a hooked jaw (kype) and reddish body color.',
      ],
      tips:
          'Cast and retrieve spinners or pixie-style lures through pools and current seams, '
          'varying retrieve speed to trigger reaction strikes. Drifting beads or egg patterns '
          'under an indicator also works well in clear water. Silvers respond strongly to flash '
          'and vibration, so don\'t be afraid to fish lures aggressively.',
      baits: [
        'Spinners',
        'Pixee Lures',
        'Beads',
        'Egg Patterns',
        'Flesh Flies',
        'Spoons',
      ],
    ),
    Species(
      id: 'sockeye-salmon',
      name: 'Sockeye Salmon (Red)',
      scientificName: 'Oncorhynchus nerka',
      emoji: '🐠',
      subcategory: 'Fish Species',
      overview:
          'Sockeye, or "reds," are renowned for their deep red flesh and incredible flavor, '
          'fueling some of the most famous combat fishing on rivers like the Russian and '
          'Kenai. They travel in huge schools, making for fast, exciting action when runs peak.',
      habitat:
          'Found in glacial and clear-water rivers connected to nursery lakes, especially the '
          'Kenai, Russian, Kasilof, and Copper river drainages.',
      size: 'Typically 5-8 lbs, occasionally up to 12 lbs',
      season: 'Late June through July, with a smaller late run in August',
      facts: [
        'Sockeye primarily feed on plankton, so anglers rely on "flossing" or flash to trigger bites.',
        'Their bodies turn brilliant red and their heads green as they near spawning.',
        'Sockeye runs can number in the millions on systems like the Kenai and Copper rivers.',
        'They are considered by many to be the best-tasting salmon for the smoker and freezer.',
      ],
      tips:
          'Because sockeye rarely strike out of aggression, the classic technique is drifting a '
          'weighted leader with a small bare hook or fly through their migration lanes so it '
          'passes near the fish\'s mouth ("flossing"). Fish close to bottom in defined travel '
          'lanes near shore, and time trips to incoming or outgoing tides for the best movement.',
      baits: [
        'Bare Hooks',
        'Small Flies',
        'Hot Pink Yarn',
        'Sockeye Flies',
        'Weighted Leaders',
      ],
      caution:
          'Many sockeye fisheries use "flossing" techniques with strict gear and snagging '
          'regulations—check local emergency orders for hook size and bait restrictions.',
    ),
    Species(
      id: 'pink-salmon',
      name: 'Pink Salmon (Humpback)',
      scientificName: 'Oncorhynchus gorbuscha',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'Pink salmon, or "humpies," are the smallest and most abundant Pacific salmon, '
          'returning in massive numbers on odd-numbered years throughout much of Alaska. '
          'They are an excellent choice for beginners and kids due to their willingness to bite.',
      habitat:
          'Spawn in countless coastal streams and rivers across Southcentral, Southeast, and '
          'Kodiak, often visible in huge schools in shallow tidal reaches.',
      size: 'Typically 3-6 lbs, rarely exceeding 8 lbs',
      season: 'July through August, with strongest runs in odd-numbered years',
      facts: [
        'Pinks have a strict two-year life cycle, leading to much larger runs in odd years.',
        'Spawning males develop a pronounced humped back, giving them their nickname.',
        'They are the most numerous salmon species in the North Pacific by sheer biomass.',
        'Pinks are popular for fly fishing due to their abundance and willingness to chase flies.',
      ],
      tips:
          'Cast small pink or chartreuse spinners, jigs, or flies into schools near stream mouths '
          'and retrieve with a steady or twitching motion—pink lures matching their name are '
          'consistently effective. Fish shallow riffles and tidewater areas where schools stack '
          'up, and target the leading edge of a run for the freshest, brightest fish.',
      baits: [
        'Pink Spinners',
        'Pink Salmon Egg Pattern Flies',
        'Small Jigs',
        'Spoons',
        'Pink Hoochies',
      ],
    ),
    Species(
      id: 'chum-salmon',
      name: 'Chum Salmon (Dog)',
      scientificName: 'Oncorhynchus keta',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'Chum salmon, often called "dog salmon," are a hard-fighting and underrated species '
          'that historically fed sled dogs across Alaska. They put up a strong, dogged fight on '
          'light tackle and are increasingly popular with fly anglers.',
      habitat:
          'Widespread in coastal rivers and streams throughout Alaska, particularly abundant in '
          'Southeast Alaska, Prince William Sound, and the Yukon and Kuskokwim drainages.',
      size: 'Typically 8-15 lbs, up to 20+ lbs',
      season: 'July through September',
      facts: [
        'Chum salmon get their nickname from their historic use as dog food for sled teams.',
        'Spawning males develop striking purple and green calico patterns on their sides.',
        'Chum are the second largest Pacific salmon by average size after kings.',
        'They are known for powerful runs and surprising aerial jumps when hooked.',
      ],
      tips:
          'Chum respond well to bright, flashy presentations—cast chartreuse or pink flies and '
          'spinners into slower pools and tailouts where schools stage before spawning. A slow, '
          'steady swing or twitch retrieve near the bottom often draws aggressive strikes, '
          'especially early in the run when fish are still bright.',
      baits: [
        'Chartreuse Flies',
        'Spinners',
        'Egg Patterns',
        'Flesh Flies',
        'Spoons',
      ],
    ),
    Species(
      id: 'rainbow-trout',
      name: 'Rainbow Trout',
      scientificName: 'Oncorhynchus mykiss',
      emoji: '🌈',
      subcategory: 'Fish Species',
      overview:
          'Rainbow trout are one of Alaska\'s most beloved sport fish, prized for their '
          'beautiful coloration, acrobatic fights, and willingness to take dry flies. Alaska\'s '
          'wild rainbows grow exceptionally large by feeding heavily on salmon eggs and flesh.',
      habitat:
          'Abundant in clear rivers, streams, and lakes across Southcentral and Southwest '
          'Alaska, with famous fisheries on the Kenai Peninsula, Bristol Bay, and the Wood-Tikchik area.',
      size: 'Typically 14-22 inches, with trophy fish over 28 inches in trout-rich drainages',
      season: 'June through September, with excellent fall fishing during salmon spawn',
      facts: [
        'Some Bristol Bay rainbows can live over a decade, growing to trophy size.',
        'Rainbows gorge on salmon eggs and flesh during fall spawning runs, fueling rapid growth.',
        'Alaska enforces catch-and-release regulations on many premier rainbow waters.',
        'They are closely related to steelhead, which are sea-run rainbow trout.',
      ],
      tips:
          'During salmon spawning season, drift egg patterns, beads, or flesh flies through '
          'gravel runs below spawning salmon. In summer, target rising fish with attractor dry '
          'flies or swing streamers through deep pools and undercut banks. Light, natural '
          'presentations and long drifts produce the best results in clear Alaska water.',
      baits: [
        'Beads',
        'Egg Patterns',
        'Flesh Flies',
        'Streamers',
        'Dry Flies',
        'Spinners',
      ],
      caution:
          'Many premier rainbow trout waters are catch-and-release only or restricted to '
          'single-hook, artificial lures—verify regulations for your specific drainage.',
    ),
    Species(
      id: 'arctic-grayling',
      name: 'Arctic Grayling',
      scientificName: 'Thymallus arcticus',
      emoji: '🐠',
      subcategory: 'Fish Species',
      overview:
          'Arctic grayling are easily recognized by their large, sail-like dorsal fin and '
          'iridescent purple-blue sheen. They are abundant, eager biters that make excellent '
          'targets for light fly and spin tackle in clear northern waters.',
      habitat:
          'Found throughout interior and northern Alaska in clear, cold rivers and streams, '
          'including the Brooks Range, Denali area, and many tributaries of the Yukon and Tanana rivers.',
      size: 'Typically 10-16 inches, with larger fish reaching 18-20 inches',
      season: 'June through September, with ice-out providing especially active fishing',
      facts: [
        'Grayling have an unusually large dorsal fin used for display during spawning.',
        'They often feed actively on the surface, making them a favorite for dry-fly anglers.',
        'Grayling tend to hold in small pods near current edges and below riffles.',
        'Their slightly sweet, mild flesh has historically made them an important subsistence fish.',
      ],
      tips:
          'Cast small dry flies or spinners upstream and let them drift naturally through riffles '
          'and current seams—grayling often rise enthusiastically to dries on calm days. A '
          'small spinner worked through pools below fast water is also highly effective and '
          'covers water quickly when searching for active fish.',
      baits: [
        'Small Dry Flies',
        'Spinners',
        'Nymphs',
        'Small Spoons',
        'Mosquito Patterns',
      ],
    ),
    Species(
      id: 'northern-pike',
      name: 'Northern Pike',
      scientificName: 'Esox lucius',
      emoji: '🐊',
      subcategory: 'Fish Species',
      overview:
          'Northern pike are aggressive ambush predators with a toothy grin, prized by anglers '
          'for their explosive strikes on large lures. While native to much of western and '
          'interior Alaska, pike are invasive in parts of Southcentral and can devastate salmon '
          'and trout populations.',
      habitat:
          'Native to sloughs, weedy lakes, and slow rivers of Western and Interior Alaska, '
          'including the Yukon-Kuskokwim drainages and the Minto Flats area; also found '
          'invasively in some Southcentral lakes.',
      size: 'Typically 5-15 lbs, trophy fish over 20 lbs',
      season: 'Best fishing from ice-out in May through September',
      facts: [
        'Pike are voracious predators with sharp teeth and a diet of fish, frogs, and small mammals.',
        'They ambush prey from weed beds using a burst of explosive speed.',
        'Pike are considered invasive in parts of Southcentral Alaska, where eradication efforts are ongoing.',
        'Their sharp teeth make a wire leader essential to avoid bite-offs.',
      ],
      tips:
          'Cast large spoons, spinnerbaits, or jerkbaits along weed edges and into shallow bays '
          'where pike ambush prey, using an erratic, pause-and-go retrieve to trigger reaction '
          'strikes. Early morning and overcast conditions often produce the most aggressive '
          'feeding activity in shallow water.',
      baits: [
        'Spoons',
        'Spinnerbaits',
        'Jerkbaits',
        'Large Streamers',
        'Soft Plastic Swimbaits',
      ],
      caution:
          'In Southcentral Alaska, invasive northern pike must often be killed if caught and '
          'cannot be transported live or released—check ADF&G regulations for the specific water body.',
    ),
    Species(
      id: 'dolly-varden',
      name: 'Dolly Varden',
      scientificName: 'Salvelinus malma',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'Dolly Varden are colorful char found throughout coastal Alaska, often confused with '
          'Arctic char. They are aggressive, willing biters that follow salmon runs to feast on '
          'eggs, making them a favorite supporting species for anglers targeting salmon and trout.',
      habitat:
          'Common in coastal streams, rivers, and nearshore saltwater throughout Southcentral, '
          'Southeast, and Southwest Alaska, often found alongside salmon during spawning season.',
      size: 'Typically 12-20 inches, up to 5-8 lbs for sea-run fish',
      season: 'May through October, peaking during summer and fall salmon runs',
      facts: [
        'Dolly Varden are anadromous, moving between saltwater and freshwater throughout the year.',
        'Spawning males develop vivid red and orange spots and bellies.',
        'They often follow behind spawning salmon to feed on drifting eggs.',
        'Dollies can be distinguished from Arctic char by their smaller, more numerous spots.',
      ],
      tips:
          'Drift egg patterns, beads, or small spinners through riffles and pools below '
          'spawning salmon, where Dollies congregate to feed on loose eggs. In saltwater '
          'estuaries, casting small spoons or flies near stream mouths during outgoing tides '
          'is also productive.',
      baits: [
        'Beads',
        'Egg Patterns',
        'Small Spinners',
        'Spoons',
        'Flesh Flies',
      ],
    ),
    Species(
      id: 'lake-trout',
      name: 'Lake Trout',
      scientificName: 'Salvelinus namaycush',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'Lake trout are long-lived, deep-water predators that can grow to impressive sizes in '
          'Alaska\'s pristine lakes. Slow-growing and slow to mature, they reward anglers willing '
          'to fish deep structure with the chance at a true trophy.',
      habitat:
          'Found in deep, cold lakes throughout Alaska, including Lake Clark, Susitna lakes, and '
          'many remote lakes across the Brooks Range and Interior.',
      size: 'Typically 15-25 lbs, trophy fish over 30 lbs and up to 50+ lbs',
      season: 'Best right after ice-out in spring and again in early fall',
      facts: [
        'Lake trout can live over 25 years and grow very slowly in cold northern lakes.',
        'They spend most of their time in deep water, relating closely to structure and thermoclines.',
        'Right after ice-out, lake trout move shallow and are more accessible to anglers.',
        'Alaska\'s remote lakes hold some of the largest lake trout in North America.',
      ],
      tips:
          'In early spring, troll or cast large spoons and jerkbaits near shoreline drop-offs '
          'where lake trout feed in shallow water. Later in the season, jig heavy spoons or '
          'large flies vertically along deep structure such as humps, points, and underwater '
          'ledges where fish hold near the thermocline.',
      baits: [
        'Large Spoons',
        'Jerkbaits',
        'Jigs',
        'Large Streamers',
        'Cut Bait',
      ],
    ),
    Species(
      id: 'burbot',
      name: 'Burbot',
      scientificName: 'Lota lota',
      emoji: '🐟',
      subcategory: 'Fish Species',
      overview:
          'Burbot, sometimes called "lush" or "Alaska\'s freshwater cod," are nocturnal bottom '
          'dwellers with an eel-like body and a single chin whisker. Though often overlooked, '
          'they put up a surprisingly strong fight and are excellent eating, especially through the ice.',
      habitat:
          'Found in deep lakes and slow rivers across Interior and Southcentral Alaska, '
          'including the Tanana River drainage and many lakes near Fairbanks and the Susitna Valley.',
      size: 'Typically 2-5 lbs, up to 10+ lbs',
      season: 'Best fishing through the ice from December through March',
      facts: [
        'Burbot are the only freshwater member of the cod family found in Alaska.',
        'They are mostly nocturnal, feeding heavily after dark on fish and invertebrates.',
        'A single barbel (whisker) on the chin helps them locate food on murky bottoms.',
        'Burbot are popular ice-fishing targets and are considered excellent table fare.',
      ],
      tips:
          'Set baited rods or jigs on or near the bottom in deep holes through the ice, '
          'using cut fish, herring, or sucker meat for scent. Fishing overnight or after dark '
          'greatly increases success since burbot feed most actively at night. Keep bait pinned '
          'tight to bottom, as burbot rarely chase food far off the substrate.',
      baits: [
        'Cut Fish Bait',
        'Herring',
        'Sucker Meat',
        'Jigs Tipped With Bait',
        'Whitefish Chunks',
      ],
    ),
    Species(
      id: 'arctic-char',
      name: 'Arctic Char',
      scientificName: 'Salvelinus alpinus',
      emoji: '🐠',
      subcategory: 'Fish Species',
      overview:
          'Arctic char are stunning, brightly colored char found in remote northern and western '
          'Alaska waters, often considered a true trophy by traveling anglers. Lake-resident '
          'populations can grow large and display brilliant orange and red spawning colors.',
      habitat:
          'Found in remote lakes and rivers of Arctic and Western Alaska, including the Brooks '
          'Range, Wood-Tikchik area, and drainages of the Seward Peninsula.',
      size: 'Typically 3-8 lbs, trophy fish over 15 lbs in select lakes',
      season: 'July through September, with peak coloration in late summer and fall',
      facts: [
        'Arctic char are among the most colorful freshwater fish in Alaska, especially when spawning.',
        'Some populations are landlocked and never enter saltwater, growing large in deep lakes.',
        'Char closely resemble Dolly Varden but typically have larger, fewer spots.',
        'They are highly sought by fly anglers visiting remote Arctic lodges.',
      ],
      tips:
          'Cast or strip streamers and spoons along rocky shorelines and river mouths where char '
          'feed on baitfish and insects. In lakes, trolling flashy spoons or flies near drop-offs '
          'and inlet streams covers water effectively. Bright, flashy presentations that mimic '
          'small fish or eggs draw the most consistent strikes.',
      baits: [
        'Spoons',
        'Streamers',
        'Egg Patterns',
        'Small Spinners',
        'Flesh Flies',
      ],
    ),
    Species(
      id: 'pacific-halibut',
      name: 'Pacific Halibut',
      scientificName: 'Hippoglossus stenolepis',
      emoji: '🐡',
      subcategory: 'Fish Species',
      overview:
          'Pacific halibut are massive flatfish and one of Alaska\'s premier saltwater game fish, '
          'capable of growing to several hundred pounds. Bottom-dwelling and powerful, they '
          'provide some of the toughest fights and most rewarding table fare in the state.',
      habitat:
          'Found on sandy and gravel bottoms in nearshore and offshore waters throughout coastal '
          'Alaska, with popular fisheries out of Homer, Seward, Kodiak, and Southeast ports.',
      size: 'Typically 20-50 lbs, with "barn door" fish exceeding 100 lbs and giants over 300 lbs',
      season: 'May through September, with the strongest bite in summer months',
      facts: [
        'Halibut are the largest flatfish in the world, with record fish exceeding 500 lbs.',
        'They lie flat on the seafloor, ambushing prey from below with both eyes on top of their head.',
        'Halibut can live over 25 years and females grow much larger than males.',
        'Alaska\'s halibut fishery is one of the most valuable commercial and sport fisheries in the state.',
      ],
      tips:
          'Fish bait or jigs directly on or near the bottom in areas with current breaks, '
          'underwater humps, or drop-offs, as halibut ambush prey from below. Large circle hooks '
          'baited with herring or salmon heads, or heavy metal jigs bounced off bottom, are '
          'standard tactics. Be patient—halibut often mouth bait before committing to a strong take.',
      baits: [
        'Herring',
        'Salmon Heads',
        'Octopus',
        'Heavy Jigs',
        'Circle Hooks With Bait',
      ],
      caution:
          'Halibut retention is subject to size and bag limits that vary by region and can '
          'change annually—check current IPHC and ADF&G regulations before keeping fish.',
    ),
    Species(
      id: 'lingcod',
      name: 'Lingcod',
      scientificName: 'Ophiodon elongatus',
      emoji: '🐍',
      subcategory: 'Fish Species',
      overview:
          'Lingcod are voracious, toothy predators found around rocky reefs and kelp beds, '
          'known for their aggressive strikes and excellent firm white flesh. Despite the name, '
          'they are not true cod but a member of the greenling family.',
      habitat:
          'Found around rocky reefs, pinnacles, and kelp beds in nearshore waters of Southcentral '
          'and Southeast Alaska, particularly around Prince William Sound, Kodiak, and Sitka.',
      size: 'Typically 10-25 lbs, with large fish exceeding 40-50 lbs',
      season: 'May through September, with spring offering excellent shallow-water action',
      facts: [
        'Lingcod have large mouths with sharp teeth and will aggressively strike jigs and bait.',
        'They are ambush predators that hold tight to rocky structure and kelp.',
        'Lingcod flesh and bones can appear blue-green when raw, which is harmless and cooks white.',
        'Males guard egg masses on rocky reefs during spring spawning season.',
      ],
      tips:
          'Drop large jigs or bait rigs to the bottom near rocky pinnacles and kelp edges, '
          'then jig aggressively with sharp upward strokes to mimic fleeing baitfish. Lingcod '
          'often strike hard on the initial drop, so be ready as soon as your jig hits bottom. '
          'Working structure thoroughly with repeated drops produces the best results.',
      baits: [
        'Large Jigs',
        'Herring',
        'Swimbaits',
        'Octopus',
        'Curl-Tail Grubs',
      ],
      caution:
          'Lingcod have minimum size limits in many areas and specific seasonal closures during '
          'spawning—verify current regulations for your fishing area.',
    ),
    Species(
      id: 'pelagic-rockfish',
      name: 'Pelagic Rockfish',
      scientificName: 'Sebastes spp. (e.g. black, dusky, yellowtail rockfish)',
      emoji: '🐠',
      subcategory: 'Fish Species',
      overview:
          'Pelagic rockfish, including black, dusky, and yellowtail rockfish, school in the '
          'water column above structure and provide fast, fun action for anglers. They are '
          'a popular bonus catch on halibut and lingcod trips throughout coastal Alaska.',
      habitat:
          'Found in schools over rocky banks, reefs, and kelp beds in nearshore and offshore '
          'waters of Southcentral and Southeast Alaska, often suspended well off bottom.',
      size: 'Typically 1-5 lbs, occasionally up to 8 lbs',
      season: 'May through September',
      facts: [
        'Pelagic rockfish school in the mid-water column rather than hugging the bottom.',
        'Black rockfish are among the most commonly caught pelagic rockfish in Alaska.',
        'They have venomous spines on their dorsal fins that can cause painful punctures.',
        'Rockfish are slow-growing and long-lived, with some species living 50+ years.',
      ],
      tips:
          'Locate schools suspended over structure using a fish finder, then drop jigs or '
          'bait to the depth of the school and jig steadily—pelagic rockfish often hit on the '
          'way down or with a short vertical hop. Light tackle with small jigs or shrimp flies '
          'can produce fast, repeated action once a school is located.',
      baits: [
        'Small Jigs',
        'Shrimp Flies',
        'Curl-Tail Grubs',
        'Herring Strips',
        'Swimbaits',
      ],
      caution:
          'Handle rockfish carefully—dorsal spines are venomous and can cause painful wounds. '
          'Many rockfish species are sensitive to barotrauma when brought up from depth.',
    ),
    Species(
      id: 'non-pelagic-rockfish',
      name: 'Non-Pelagic Rockfish',
      scientificName: 'Sebastes spp. (e.g. quillback, copper, china rockfish)',
      emoji: '🐡',
      subcategory: 'Fish Species',
      overview:
          'Non-pelagic rockfish such as quillback, copper, and china rockfish are colorful, '
          'slow-growing bottom dwellers that live closely tied to rocky reef structure. Their '
          'striking patterns and long lifespans make careful handling and conservation especially '
          'important.',
      habitat:
          'Found tight to rocky reefs, crevices, and boulder fields in nearshore waters '
          'throughout Southcentral and Southeast Alaska, typically at moderate depths near structure.',
      size: 'Typically 1-4 lbs, occasionally up to 6-8 lbs',
      season: 'May through September',
      facts: [
        'Non-pelagic rockfish rarely stray far from the rocky structure they call home.',
        'Species like quillback and china rockfish display vivid, intricate color patterns.',
        'Some non-pelagic rockfish species can live well over 80 years.',
        'Because they live near bottom, they are highly susceptible to barotrauma when caught from depth.',
      ],
      tips:
          'Drop bait or jigs directly to the bottom near rocky structure and fish slowly, '
          'keeping your offering close to crevices and boulders where these rockfish hold tight. '
          'A subtle lift-and-drop jigging motion near the bottom is often more effective than '
          'aggressive jigging, since these fish ambush prey from cover rather than chasing it far.',
      baits: [
        'Bait Rigs',
        'Small Jigs',
        'Herring Strips',
        'Shrimp Flies',
        'Curl-Tail Grubs',
      ],
      caution:
          'Due to slow growth and vulnerability to barotrauma, many non-pelagic rockfish species '
          'have strict bag limits and release requirements—use a descending device when releasing '
          'fish caught from deep water.',
    ),
  ];
}
