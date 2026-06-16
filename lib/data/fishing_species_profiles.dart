import '../models/fishing_regs.dart';

/// Per-species profile content shown on the Fishing tab's species page.
class FishingSpeciesProfile {
  final String name;
  final String scientificName;
  final String summary;
  final List<String> identification;
  final List<String> habitat;
  final String season;
  final List<String> tacticsAndGear;

  const FishingSpeciesProfile({
    required this.name,
    required this.scientificName,
    required this.summary,
    this.identification = const [],
    this.habitat = const [],
    this.season = '',
    this.tacticsAndGear = const [],
  });
}

/// Lookup of [FishingSpeciesProfile] by the canonical name in [FishSpecies].
class FishingSpeciesProfiles {
  FishingSpeciesProfiles._();

  static const Map<String, FishingSpeciesProfile> byName = {
    FishSpecies.king: FishingSpeciesProfile(
      name: FishSpecies.king,
      scientificName: 'Oncorhynchus tshawytscha',
      summary:
          'Alaska\'s state fish and the largest of the Pacific salmon. '
          'Kings (a.k.a. Chinook) anchor the marquee runs on the Kenai, '
          'Kasilof, Susitna, and Copper systems and turn into a once-a-year '
          'tradition for Southcentral anglers.',
      identification: [
        'Heavy, deep-bodied build with black gumline.',
        'Spotted on both lobes of the tail and across the back.',
        'Ocean-bright fish are blue-green over silver; spawners turn maroon to nearly black.',
        'Adults commonly run 15–40 lb; trophies exceed 70 lb.',
      ],
      habitat: [
        'Spawn in large gravel-bottomed rivers; juveniles rear in fresh water 1–2 years before going to sea.',
        'Return as 3–7-year-old adults, holding in deeper runs and tailouts.',
      ],
      season:
          'Mid-May through July is the prime in-river window; many systems are closed in 2026 by emergency order.',
      tacticsAndGear: [
        'Back-bouncing roe or plug-cut herring through deep slots.',
        'Hover-fishing or back-trolling cured eggs and Spin-N-Glos.',
        'Casting heavy spoons or large flies in clear-water reaches.',
      ],
    ),
    FishSpecies.coho: FishingSpeciesProfile(
      name: FishSpecies.coho,
      scientificName: 'Oncorhynchus kisutch',
      summary:
          'The aggressive, acrobatic "silver" — Southcentral\'s most-loved '
          'late-summer salmon. Cohos hammer flashy presentations in '
          'streams, sloughs, and lakes from late July through September.',
      identification: [
        'Black spots on the back and the upper lobe of the tail (not the lower lobe).',
        'White gumline; clean silver flanks in the salt, blushing red as they spawn.',
        'Typical adults 6–12 lb; some Cook Inlet fish push 18+.',
      ],
      habitat: [
        'Spawn in small streams and side channels; juveniles rear in fresh water 1–2 years.',
        'Adults stage in tidal sloughs before pushing upriver.',
      ],
      season: 'Late July through mid-October.',
      tacticsAndGear: [
        'Pink, chartreuse, and orange jigs under a bobber.',
        'Vibrax #4 and Pixee spoons swung through tailouts.',
        'Pink/purple flesh flies and articulated leeches.',
      ],
    ),
    FishSpecies.sockeye: FishingSpeciesProfile(
      name: FishSpecies.sockeye,
      scientificName: 'Oncorhynchus nerka',
      summary:
          'The "red" — the salmon Alaskans put up by the freezer-full. '
          'Sockeye runs into the Kenai and Russian rivers fuel both '
          'subsistence and sport fisheries; they\'re plankton feeders, '
          'so the take is mostly flossing on bottom-bumping rigs.',
      identification: [
        'Slimmer body than other salmon; almost no spotting on the back or tail.',
        'Bright silver in salt; spawners turn crimson red with a green head.',
        'Adults typically 4–8 lb.',
      ],
      habitat: [
        'Require a lake in their natal system for juvenile rearing.',
        'Spawn in inlet/outlet streams of those lakes; adults school heavily in the lower river before moving up.',
      ],
      season:
          'June and July; second run on the Kenai often peaks late July through early August.',
      tacticsAndGear: [
        'Coho fly or short leader with bare hook bumped along bottom (where legal).',
        'Sparse pink, orange, or purple flies on heavy tippet.',
      ],
    ),
    FishSpecies.pink: FishingSpeciesProfile(
      name: FishSpecies.pink,
      scientificName: 'Oncorhynchus gorbuscha',
      summary:
          'The smallest and most abundant Pacific salmon — "humpies" return '
          'on a 2-year cycle (even years are big in Southcentral). They\'re '
          'aggressive, easy to catch, and perfect for getting kids on fish.',
      identification: [
        'Large oval black spots on the back and both lobes of the tail.',
        'Males develop a pronounced hump and hooked jaw on the spawn.',
        'Typical adults 3–5 lb.',
      ],
      habitat: [
        'Spawn in short coastal streams; fry go directly to sea after emergence.',
        '2-year life cycle.',
      ],
      season: 'Mid-July through August.',
      tacticsAndGear: [
        'Small pink spinners, spoons, and jigs.',
        'Pink Hareball leeches and humpy hookers on light fly gear.',
      ],
    ),
    FishSpecies.chum: FishingSpeciesProfile(
      name: FishSpecies.chum,
      scientificName: 'Oncorhynchus keta',
      summary:
          'The "dog" salmon — a workhorse fish with hard-fighting strength '
          'and excellent table quality when caught bright in salt or the '
          'lower river. Often overlooked but a key fall fishery in many '
          'Southcentral systems.',
      identification: [
        'Faint or no spotting; silver in the salt, turning to vertical purple/maroon "calico" bars.',
        'Males develop large canine-like teeth on the spawn (hence "dog salmon").',
        'Adults 8–15 lb common.',
      ],
      habitat: [
        'Spawn in lower mainstem reaches and large tributaries.',
        'Fry go to sea immediately after emergence.',
      ],
      season: 'Mid-July through September.',
      tacticsAndGear: [
        'Chartreuse and purple jigs, Vibrax spinners.',
        'Sparkle flies on a swung sink-tip.',
      ],
    ),
    FishSpecies.rainbow: FishingSpeciesProfile(
      name: FishSpecies.rainbow,
      scientificName: 'Oncorhynchus mykiss',
      summary:
          'Resident rainbows and sea-run steelhead are the same species — '
          'Alaska\'s wild rainbows grow to trophy size in the Kvichak/Bristol '
          'Bay systems, and stocked rainbows are the bread-and-butter of '
          'Anchorage urban lakes.',
      identification: [
        'Distinct pink/red lateral stripe and heavy black spotting head-to-tail.',
        'Spotting on both lobes of the tail.',
        'Stream fish: 10–18"; lake holdovers: 14–22"; trophy wild fish 26+.',
      ],
      habitat: [
        'Cold, clean rivers and lakes statewide; tributaries to salmon-spawning streams hold the biggest fish (feeding on eggs and flesh).',
      ],
      season: 'Best window is post-spawn through fall (June through October).',
      tacticsAndGear: [
        'Bead-and-indicator rigs through salmon-spawn gravel.',
        'Flesh flies and articulated streamers in the fall.',
        'Mepps spinners and small spoons on light spinning gear.',
      ],
    ),
    FishSpecies.dolly: FishingSpeciesProfile(
      name: FishSpecies.dolly,
      scientificName: 'Salvelinus malma / S. alpinus',
      summary:
          'Two species are usually lumped together for regs purposes — Dolly '
          'Varden in coastal and stream systems, Arctic char in deep cold '
          'lakes. Both are eager biters that key in on salmon eggs and fry.',
      identification: [
        'Cream-to-pink spots on dark olive-to-blue bodies (no black spots).',
        'White-leading-edged lower fins.',
        'Stream Dollies typically 10–18"; lake char can exceed 10 lb.',
      ],
      habitat: [
        'Anadromous Dollies use coastal streams; resident populations live in tributaries year-round.',
        'Arctic char prefer cold, deep, well-oxygenated lakes.',
      ],
      season: 'Year-round; peak action follows salmon spawning (July–October).',
      tacticsAndGear: [
        'Single beads in salmon colors.',
        'Egg-sucking leeches and Mickey Finn streamers.',
        'Small spoons and jigs in stillwater.',
      ],
    ),
    FishSpecies.grayling: FishingSpeciesProfile(
      name: FishSpecies.grayling,
      scientificName: 'Thymallus arcticus',
      summary:
          'The sail-finned beauty of Alaska\'s clear interior streams. '
          'Grayling rise eagerly to dry flies on summer evenings and are '
          'one of the most accessible fly-rod targets in the state.',
      identification: [
        'Iridescent purple/blue with a large, spotted, sail-like dorsal fin.',
        'Forked tail.',
        'Typical fish 10–16"; trophy grayling reach 20+.',
      ],
      habitat: [
        'Clear, cold streams and rivers — especially the Tangle Lakes, Denali Highway streams, and tributaries of the upper Susitna and Copper systems.',
      ],
      season: 'June through September; peak surface action June–July.',
      tacticsAndGear: [
        'Parachute Adams #14, Elk Hair Caddis #14–16, ant patterns.',
        'Beadhead nymphs (Pheasant Tail, Hare\'s Ear) when fish are deeper.',
        'Tiny spinners (Mepps #0 or #1).',
      ],
    ),
    FishSpecies.lakeTrout: FishingSpeciesProfile(
      name: FishSpecies.lakeTrout,
      scientificName: 'Salvelinus namaycush',
      summary:
          'Cold-water giants of Alaska\'s deep glacial lakes. Slow-growing '
          'and long-lived — practice catch-and-release on big ones.',
      identification: [
        'Heavily forked tail and a marbled or wormy light pattern on a dark body.',
        'No pink/red lateral stripe (vs. rainbow).',
        'Most fish 3–8 lb; lake-of-a-lifetime fish can exceed 30.',
      ],
      habitat: [
        'Deep, cold lakes — Clarence, Eklutna, Skilak, Kenai Lake, etc.',
        'Hold near the thermocline once surface waters warm.',
      ],
      season:
          'Spring ice-out (May) and fall (September–October) are best; summer trolling for deep fish works year-round.',
      tacticsAndGear: [
        'Trolling spoons (Krocodile, FlatFish) deep with downriggers or lead-core.',
        'Jigging tube jigs and bucktails over structure.',
        'Vertical jigging through the ice in winter.',
      ],
    ),
    FishSpecies.burbot: FishingSpeciesProfile(
      name: FishSpecies.burbot,
      scientificName: 'Lota lota',
      summary:
          'Alaska\'s only freshwater cod — also called "lush" or "loche". '
          'A nocturnal bottom-dweller that bites best through the ice and '
          'is excellent table fare (the "poor man\'s lobster").',
      identification: [
        'Elongated, eel-like body with a single chin barbel.',
        'Mottled tan-and-brown camouflage.',
        '24–32" common; trophies exceed 36".',
      ],
      habitat: [
        'Deep lakes and large slow rivers across Interior and Southcentral Alaska.',
        'Most active at night and under ice.',
      ],
      season: 'November through March (ice-fishing prime).',
      tacticsAndGear: [
        'Set lines baited with cut whitefish, herring, or smelt on the bottom.',
        'Glow jigs tipped with bait — let it sit, then twitch.',
        'Closely-attended set lines per ADF&G rules.',
      ],
    ),
    FishSpecies.pike: FishingSpeciesProfile(
      name: FishSpecies.pike,
      scientificName: 'Esox lucius',
      summary:
          'INVASIVE in Southcentral Alaska. Pike were illegally introduced '
          'to Cook Inlet drainages in the 1950s and have decimated salmon '
          'and trout populations in many lakes. LIVE RELEASE IS PROHIBITED — '
          'all pike caught must be killed.',
      identification: [
        'Elongated, torpedo-shaped body with single dorsal fin set far back.',
        'Olive-green with light bean-shaped spots.',
        'Mouth full of needle teeth.',
        'Average 5–10 lb; trophies exceed 25.',
      ],
      habitat: [
        'Slow weedy lakes, sloughs, and backwaters — Nancy Lake complex, Alexander Creek, Yentna sloughs.',
      ],
      season:
          'Year-round. Best summer action in weed edges; winter ice-fishing very productive.',
      tacticsAndGear: [
        'Large spoons (Daredevle, Five of Diamonds) and bucktail spinners.',
        'Big streamers on 9- or 10-weight fly rods.',
        'Ice fishing: tip-ups with whole bait fish per ADF&G rules.',
        'WIRE LEADER required — pike will bite through mono.',
      ],
    ),
    FishSpecies.whitefish: FishingSpeciesProfile(
      name: FishSpecies.whitefish,
      scientificName: 'Coregonus / Prosopium spp.',
      summary:
          'A family of small-mouthed, schooling fish (round whitefish, '
          'lake whitefish, humpback) that thrive in Alaska\'s clean cold '
          'waters. Often overlooked, but excellent smoked.',
      identification: [
        'Silvery flanks, small mouth, large scales, single dorsal + adipose fin.',
        'Forked tail.',
        'Typically 10–18".',
      ],
      habitat: [
        'Clear rivers and lakes across the state; congregate in deep pools and lake basins.',
      ],
      season: 'Year-round; great winter ice target.',
      tacticsAndGear: [
        'Tiny jigs and ice flies tipped with single eggs or larvae.',
        'Small nymphs and dry flies in summer.',
      ],
    ),
    FishSpecies.otherFinfish: FishingSpeciesProfile(
      name: FishSpecies.otherFinfish,
      scientificName: 'Various',
      summary:
          'Catch-all category in ADF&G regulations for species like '
          'sculpin, suckers, and other native non-game finfish. Limits are '
          'generally none, but always confirm in the current booklet.',
    ),
  };
}
