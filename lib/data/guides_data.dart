import '../models/guide.dart';

/// Curated, Alaska-specific field guides. Every guide is written for
/// conditions, species, and terrain found in Alaska — nothing generic.
class GuidesData {
  GuidesData._();

  static const List<GuideCategory> categories = [
    GuideCategory(name: 'Camping', emoji: '⛺', imagePath: 'assets/category_icons/camping.jpg'),
    GuideCategory(name: 'Fishing', emoji: '🎣', imagePath: 'assets/category_icons/fishing.jpg'),
    GuideCategory(name: 'Survival', emoji: '🧭'),
    GuideCategory(name: 'Wildlife', emoji: '🐻', imagePath: 'assets/category_icons/wildlife.jpg'),
    GuideCategory(name: 'Aurora', emoji: '🌌', imagePath: 'assets/category_icons/aurora.jpg'),
    GuideCategory(name: 'Hiking', emoji: '🥾'),
    GuideCategory(name: 'Food', emoji: '🍲', imagePath: 'assets/category_icons/food.jpg'),
    GuideCategory(name: 'Harvesting', emoji: '🫐'),
  ];

  static Guide byId(String id) => guides.firstWhere((g) => g.id == id);

  static const List<Guide> guides = [
    // ── Camping ───────────────────────────────────────────────────────────
    Guide(
      id: 'camp-backcountry',
      title: 'Backcountry Camping in Alaska',
      category: 'Camping',
      emoji: '⛺',
      summary:
          'How to pick a site, rig your camp, and sleep easy in true Alaskan backcountry — from the Kenai to the Brooks Range.',
      difficulty: 'Intermediate',
      readMinutes: 8,
      season: 'May – September',
      sections: [
        GuideSection(
          heading: 'Choosing a Site',
          body:
              'Camp at least 100 yards from salmon streams and game trails — both are bear highways. Look for elevated, well-drained ground; Alaskan muskeg can swallow a tent floor overnight. Above treeline, tuck behind glacial moraines or alder breaks for wind protection, and never pitch in dry river braids — glacial rivers can rise feet in hours on a warm day.',
        ),
        GuideSection(
          heading: 'The Bear Triangle',
          body:
              'Set up camp in a triangle: tent, cooking area, and food storage each 100 yards apart, with the tent upwind. Cook and eat in your "kitchen," store everything with scent (food, toothpaste, sunscreen, fuel) in a bear canister or hung cache, and keep the tent strictly scent-free. Bear canisters are required in Denali, Gates of the Arctic, and on most of the Kenai backcountry.',
        ),
        GuideSection(
          heading: 'Weather-Proofing Camp',
          body:
              'Alaska summer means rain. Pitch your tent with the foot into the prevailing wind, guy out every line, and dig small drainage channels only where regulations allow. A tarp over the kitchen keeps morale up through multi-day soakers. In June and July, expect near-24-hour daylight — an eye mask earns its weight.',
        ),
        GuideSection(
          heading: 'Leave No Trace, Alaska Edition',
          body:
              'Pack out everything, including fish waste near camps — bury it deep in fast water instead of on shore. Use existing fire rings or a fire pan on gravel bars; tundra scars last decades. In coastal Alaska, camp below the wrack line on beaches only if you know the tide tables cold.',
        ),
      ],
      proTips: [
        'Bring 30% more tent stakes than you think you need — gravel bars eat them.',
        'A small bottle of unscented camp soap doubles for dishes and fish-smell removal.',
        'Mosquito head nets cost ounces and save your sanity in June.',
      ],
      safetyNote:
          'Always file a trip plan with someone in town. Cell coverage is nonexistent in most of the Alaskan backcountry — carry a satellite communicator.',
    ),
    Guide(
      id: 'camp-food-storage',
      title: 'Bear-Proof Food Storage',
      category: 'Camping',
      emoji: '🛢️',
      summary:
          'Canisters, hangs, and electric fences — keeping your food yours in brown and black bear country.',
      difficulty: 'Beginner',
      readMinutes: 5,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Bear Canisters',
          body:
              'Hard-sided canisters are the gold standard in Alaska and legally required in many parks. Store them 100 yards downwind of your tent, wedged against rocks or brush so a bear can\'t roll them into a river. Don\'t clip anything to the outside — straps give bears a handle.',
        ),
        GuideSection(
          heading: 'Food Hangs',
          body:
              'Classic hangs are hard in Alaska: much of the state has no trees tall enough. Where you can, hang 12 feet up and 6 feet out from the trunk. North of the Brooks Range or out on the tundra, a canister or Ursack tied to low willows is your realistic option.',
        ),
        GuideSection(
          heading: 'Electric Fences',
          body:
              'Portable electric fences are standard kit for base camps, rafting trips, and hunting camps in brown bear country like Katmai and Kodiak. Test the charger daily and keep the fence taut — a sagging wire is a useless wire.',
        ),
      ],
      proTips: [
        'Freeze-dried meals minimize odor and trash weight.',
        'Your "smellables" list is longer than you think: chapstick, sunscreen, even citronella.',
      ],
      safetyNote:
          'A fed bear is a dead bear. Sloppy food storage gets bears destroyed and campers hurt — it\'s the most preventable accident in Alaska.',
    ),
    Guide(
      id: 'camp-public-cabins',
      title: 'Booking and Using Public Use Cabins',
      category: 'Camping',
      emoji: '🛖',
      summary:
          'How to snag a state or federal cabin, pack it in right, and leave it better than you found it — from Chugach trailheads to Kachemak Bay.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Booking the Cabin',
          body:
              'Most Forest Service cabins in the Chugach and Tongass go through Recreation.gov, while Alaska State Parks runs its own reservation system for cabins in Chugach State Park, Kachemak Bay, and the Mat-Su. Popular cabins — especially ski-in winter cabins near Anchorage and float-plane cabins on Prince William Sound — book out the full six-month window within minutes of release, so set a calendar reminder and have backup dates ready. Always print or screenshot your permit; rangers do check.',
        ),
        GuideSection(
          heading: 'Packing In and Packing Out',
          body:
              'Cabins are shelters, not stocked lodges — bring your own stove, cookware, water filter, and light source even if the listing mentions a wood stove or lantern. Trash does not magically disappear because you are inside four walls: pack out every scrap, including food waste, foil, and burned cans, which do not fully incinerate in a cabin stove. If the trail in involves a boat, ATV, or ski haul, weigh your loads beforehand — most cabin trails were not built for wheeled coolers.',
        ),
        GuideSection(
          heading: 'Firewood and Water',
          body:
              'Cutting standing timber near cabins is prohibited in nearly every unit, and downed wood close to the cabin gets stripped fast in winter. Bring a folding saw and plan to range farther out, or pack in your own supply on long-haul trips. For water, most cabins sit near a lake or stream — filter or boil regardless of how clear it looks, since beaver fever (giardia) is common even in remote drainages. If you melt snow for water in winter, budget more fuel and time than you think.',
        ),
        GuideSection(
          heading: 'The Cabin Logbook',
          body:
              'Nearly every public cabin keeps a logbook in a drawer or nailed to the wall, often going back decades. Reading through old entries is part of the experience — weather notes, wildlife sightings, trail conditions, and the occasional rescue story. Leave your own entry with date, group size, conditions, and anything the next party should know, like a washed-out creek crossing or a bear working the area. It is an old Alaska tradition, and rangers sometimes use these logs to track usage and conditions.',
        ),
      ],
      proTips: [
        'Screenshot your reservation confirmation — phone service is nonexistent at almost every cabin.',
        'A roll of replacement stovepipe gasket tape or wire fixes the most common cabin wood-stove complaint.',
        'Check the agency website the week before your trip; cabin closures for bear activity or maintenance happen with little notice.',
      ],
    ),
    Guide(
      id: 'camp-winter',
      title: 'Winter Camping Skills',
      category: 'Camping',
      emoji: '❄️',
      summary:
          'Snow shelters, wall tents, and the small gear details that decide whether a night out at -20°F is miserable or comfortable.',
      difficulty: 'Advanced',
      readMinutes: 8,
      season: 'November – March',
      sections: [
        GuideSection(
          heading: 'Snow Shelters: Quinzees, Caves, and Trenches',
          body:
              'A quinzee — piling snow into a mound, letting it sinter for an hour or two, then hollowing it out — works almost anywhere there is enough snow, even on the flats around Fairbanks. True snow caves need a deep, stable drift, common on lee slopes in the Chugach and Talkeetna Mountains, and offer better headroom for longer stays. A snow trench is the fastest option when you are exhausted or daylight is running out: dig a body-width slot, roof it with skis or branches and a snow layer, and crawl in. All three trap your body heat far better than a tent, often holding 20-30°F warmer than outside air.',
        ),
        GuideSection(
          heading: 'Canvas Wall Tents and Wood Stoves',
          body:
              'A canvas wall tent with a small titanium or steel wood stove is the classic setup for multi-day winter trips by snowmachine or dog team across the Interior. Titanium stovepipe sections pack down small and resist warping from heat cycling far better than stainless. Run the pipe through a stove jack — a fire-resistant collar sewn into the canvas — and never through a tarp or nylon fly. Keep the stove away from gear and sleeping bags, and assign someone to feed it through the night if you want to wake up warm rather than just alive.',
        ),
        GuideSection(
          heading: 'Managing Condensation and Frost',
          body:
              'A heated tent in deep cold creates its own weather: warm, moist air hits the cold canvas or nylon and frosts solid, then showers down as you bump the walls. Crack a vent near the stovepipe and a low vent on the opposite wall to keep air moving. Wipe down tent walls before bed if frost has built up, and never bring wet gear fully into a sleeping bag to dry — it just transfers the moisture to your insulation. Vapor-barrier liners inside your sleeping bag cut down on this dramatically over multi-day trips.',
        ),
        GuideSection(
          heading: 'Stoves, Fuel, and Water in the Cold',
          body:
              'Below about 20°F, canister stoves lose pressure and sputter; switch to a liquid-fuel stove with white gas, and keep the fuel bottle warm in your jacket before lighting. Insulate your water bottles upside down (ice forms at the top first, away from the cap) and sleep with them inside your sleeping bag liner so they do not freeze solid overnight. Any water line, hose, or filter left exposed will freeze and can crack — drain filters completely and store them in your sleeping bag too. Melting snow for water burns far more fuel than people expect; budget at least double your summer estimate.',
        ),
      ],
      proTips: [
        'Sleep with tomorrow\'s socks, batteries, and your water filter inside your sleeping bag.',
        'A foam pad under your inflatable pad doubles your insulation from the snow and is cheap insurance against a puncture.',
        'Mark your snow shelter entrance with a ski pole or wand — drifting snow can erase it by morning.',
      ],
      safetyNote:
          'Carbon monoxide from stoves inside snow shelters or tents is a real killer — always keep ventilation clear, never run a stove unattended, and crack a vent even when it feels colder. Tell someone your route and expected return; winter rescues in Alaska are slow and weather-dependent.',
    ),

    // ── Fishing ───────────────────────────────────────────────────────────
    Guide(
      id: 'fish-salmon',
      title: 'Salmon Fishing 101: Kings, Reds & Silvers',
      category: 'Fishing',
      emoji: '🐟',
      summary:
          'When and where to chase all five Pacific salmon species, from the Kenai River to Bristol Bay.',
      difficulty: 'Beginner',
      readMinutes: 9,
      season: 'May – October',
      sections: [
        GuideSection(
          heading: 'Know Your Runs',
          body:
              'Kings (Chinook) run mid-May through July; reds (sockeye) peak June–July; chums and pinks fill mid-summer; silvers (coho) run strong August into October. Runs vary by river — check the ADF&G run counts online before you commit to a drainage. Pink salmon run big in even years in Southcentral.',
        ),
        GuideSection(
          heading: 'Gear & Technique',
          body:
              'For reds, "flossing" with a sparse fly, short leader and weight is the river standard — sockeye rarely bite, you\'re drifting line into open mouths. Silvers smash bright spinners, spoons, and eggs. Kings demand heavy rods (30–50 lb class on big water) and stout hooks. Always pinch barbs where required.',
        ),
        GuideSection(
          heading: 'Combat Fishing Etiquette',
          body:
              'On the Russian and Kenai in July you\'ll fish shoulder-to-shoulder. Match the rhythm of the anglers beside you, yell "FISH ON!" and let your fish run downstream out of the line, and never cross lines without apologizing. Land fish fast, bleed them immediately, and get them on ice.',
        ),
        GuideSection(
          heading: 'Regulations',
          body:
              'Alaska regs change by emergency order mid-season. Carry a current license, know bag limits for your drainage, and check whether bait or treble hooks are legal on your water. King stamps are required for Chinook. When in doubt, call the local ADF&G office.',
        ),
      ],
      proTips: [
        'Polarized glasses turn invisible sockeye schools into visible ones.',
        'Bring a second rod setup — re-rigging in a hot bite costs fish.',
        'Stringers attract bears; use a fish bag and keep it close.',
      ],
      safetyNote:
          'You are sharing every salmon stream with bears. Make noise, keep fish off stringers in the water, and never fight a bear for a fish — cut the line.',
    ),
    Guide(
      id: 'fish-halibut',
      title: 'Halibut Fishing Out of Homer & Seward',
      category: 'Fishing',
      emoji: '🚤',
      summary:
          'Deep-water tactics for Alaska\'s favorite flatfish — charters, gear, and getting your barn door over the rail.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'May – September',
      sections: [
        GuideSection(
          heading: 'Charter or DIY',
          body:
              'Most visitors book a charter out of Homer ("Halibut Capital of the World"), Seward, Ninilchik, or Valdez. Full-day trips reach better grounds than half-days. If you run your own boat, watch Cook Inlet\'s extreme tides — 20-foot exchanges create currents that pin gear to the bottom.',
        ),
        GuideSection(
          heading: 'Gear & Bait',
          body:
              'Standard setup: stout 5½–6½ ft rod, conventional reel with 80–100 lb braid, circle hooks on wire spreader bars, and 1–3 lb of lead depending on current. Herring, octopus, and salmon heads are top baits. Let the circle hook load up — don\'t swing like a bass angler.',
        ),
        GuideSection(
          heading: 'Landing Big Fish',
          body:
              'Anything over 100 lbs ("barn door") gets harpooned or shot by the crew before it comes over the rail — a green halibut can break legs in a boat. Most eating-size fish run 15–40 lbs. Bleed and ice immediately; halibut meat is why you came.',
        ),
      ],
      proTips: [
        'Take a half-second of slack out and reel — never jerk — when a halibut mouths the bait.',
        'Book charters months ahead for July and August.',
        'Motion-sickness tabs the night before AND morning of. Cook Inlet swell is real.',
      ],
    ),
    Guide(
      id: 'fish-fly',
      title: 'Fly Fishing: Grayling, Dollies & Rainbows',
      category: 'Fishing',
      emoji: '🪶',
      summary:
          'Wild Arctic grayling, Dolly Varden, and leopard rainbows — Alaska\'s world-class fly water beyond the salmon crowds.',
      difficulty: 'Intermediate',
      readMinutes: 7,
      season: 'June – September',
      sections: [
        GuideSection(
          heading: 'Arctic Grayling',
          body:
              'The sailfish of the north rises eagerly to dry flies all summer. Interior streams off the Denali, Steese and Dalton highways hold eager fish — a 5-weight, a box of Parachute Adams and Elk Hair Caddis in 12–16, and you\'re in business. Grayling are slow-growing; handle gently and release quickly.',
        ),
        GuideSection(
          heading: 'Dolly Varden & Char',
          body:
              'Dollies follow salmon runs to gorge on eggs. Swing or dead-drift bead imitations behind spawning salmon in August–September. Coastal streams from Southeast to Kotzebue hold sea-run fish that hit flesh flies and smolt patterns hard in spring.',
        ),
        GuideSection(
          heading: 'Trophy Rainbows',
          body:
              'The Bristol Bay and Kenai drainages grow rainbow trout over 30 inches on a diet of salmon eggs and flesh. Mouse patterns skated at dawn in June produce savage takes. These fisheries are heavily regulated — many waters are single-hook, artificial-only, catch-and-release. Know before you go.',
        ),
      ],
      proTips: [
        'Match your bead color to the salmon species spawning in that reach.',
        'A stripping basket helps on brushy banks where backcasts go to die.',
      ],
      safetyNote:
          'Egg-eating Dollies and rainbows mean you\'re fishing behind spawning salmon — which means bears are too. Stay loud and alert.',
    ),
    Guide(
      id: 'fish-ice',
      title: 'Ice Fishing Alaska\'s Lakes',
      category: 'Fishing',
      emoji: '🧊',
      summary:
          'Hard-water tactics for landlocked salmon, lake trout, burbot, and rainbows from Big Lake to Fairbanks.',
      difficulty: 'Intermediate',
      readMinutes: 6,
      season: 'December – March',
      sections: [
        GuideSection(
          heading: 'Safe Ice',
          body:
              '4 inches of clear ice for walking, 5+ for snowmachines. Alaska lakes freeze unevenly — springs, inlets, and overflow zones stay thin all winter. Drill test holes as you go and carry ice picks around your neck. Overflow (water on top of ice under snow) soaks boots and causes frostbite fast.',
        ),
        GuideSection(
          heading: 'Target Species',
          body:
              'Stocked lakes around Anchorage, the Mat-Su, and Fairbanks hold rainbows, landlocked Chinook, and Arctic char. Bigger water like Lake Louise produces lake trout and burbot. Small jigs tipped with shrimp or single eggs work for trout; glow jigs near bottom after dark for burbot.',
        ),
        GuideSection(
          heading: 'Comfort Is Endurance',
          body:
              'At -20°F your session lasts as long as your warmth does. A pop-up shelter and small propane heater transform the day. Keep your auger blades sharp and batteries warm — lithium packs die fast in deep cold.',
        ),
      ],
      proTips: [
        'Punch holes at multiple depths; winter fish school tight to structure.',
        'ADF&G stocking reports tell you exactly which lakes hold fish.',
      ],
      safetyNote:
          'No fish is worth going through the ice at -10°F. When in doubt about ice thickness, stay off.',
    ),
    Guide(
      id: 'fish-processing',
      title: 'Processing & Preserving Your Catch',
      category: 'Fishing',
      emoji: '🔪',
      summary:
          'From field-bleeding a king on the bank to vacuum-sealed fillets in the freezer — getting your Alaska catch home in top shape.',
      difficulty: 'Intermediate',
      readMinutes: 7,
      season: 'June – September',
      sections: [
        GuideSection(
          heading: 'Field Bleeding & Gutting',
          body:
              'Quality starts the moment the fish is in the boat. Bleed salmon immediately by cutting the gill rakers or severing the artery at the throat, then get the guts out within minutes — a fish left to sit warm with a full belly softens fast and can taint the meat. Halibut should be bled and the body cavity opened the same way. A quick rinse in clean water after gutting removes blood and slime that otherwise sour the flesh on a long ride back to the dock.',
        ),
        GuideSection(
          heading: 'Filleting Salmon',
          body:
              'Run the knife behind the head and pectoral fin down to the backbone, then turn the blade and run it flat along the spine to the tail, lifting the fillet as you go. Once both sides are off, lay each fillet skin-down and feel for the row of pin bones along the centerline — pluck them with needle-nose pliers, working from the thick end toward the tail where they\'re easiest to grab. Trim the dark, fatty belly strip separately if you don\'t want it; it\'s excellent smoked.',
        ),
        GuideSection(
          heading: 'Halibut: The 4-Fillet Method and the Cheeks',
          body:
              'A halibut is flat, so it yields four fillets — two off the top side, two off the bottom — cut along the lateral line and lifted off the bone in long sheets. Don\'t skip the cheeks: two thick, scallop-like medallions of meat behind each eye, removed with a circular cut around the cheek muscle. Many anglers consider cheeks the best part of the fish, and they\'re often left behind by anyone who doesn\'t know to look for them.',
        ),
        GuideSection(
          heading: 'Keeping It Cold, Then Keeping It',
          body:
              'On the water, fish should go straight into a cooler layered with ice, not just tossed in a fish bag in the sun — every hour above 40°F is an hour working against you. Once home, vacuum sealing and flash freezing locks in quality for months; lay fillets flat until frozen solid before stacking. For variety, brine fillets in a salt-sugar solution before hot smoking for a firm, ready-to-eat product, or cold smoke for a more delicate, lox-like result that still needs cooking or freezing. Pressure canning is the only safe way to jar fish for shelf storage — it\'s the one preservation method here where there\'s no shortcut.',
        ),
      ],
      proTips: [
        'Bring a roll of paper towels and a dedicated fillet board — fish slime makes every surface a hazard.',
        'Vacuum-seal in meal-sized portions; resealing a half-used bag never works as well as the first seal.',
        'Smoked salmon vacuum-seals and freezes beautifully — make extra.',
      ],
      safetyNote:
          'Home canning fish requires a pressure canner, not a water-bath canner — low-acid foods like fish processed without enough heat and pressure can support botulism growth. Follow USDA/Extension Service pressure-canning times exactly; don\'t improvise on this one.',
    ),

    // ── Survival ──────────────────────────────────────────────────────────
    Guide(
      id: 'surv-essentials',
      title: 'The Alaska Survival Kit',
      category: 'Survival',
      emoji: '🧭',
      summary:
          'What actually belongs in your pack when the nearest road is fifty miles away and rescue is a day out.',
      difficulty: 'Beginner',
      readMinutes: 7,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'The Non-Negotiables',
          body:
              'Satellite communicator (inReach or SPOT), bear spray on your hip — not in your pack, fire kit ×2 (lighter + ferro rod, with vaseline cotton or fatwood), fixed-blade knife, 50 ft of cordage, water purification, insulation layer beyond what you plan to wear, and a real first-aid kit with blister care and a SAM splint.',
        ),
        GuideSection(
          heading: 'Why Doubles Matter',
          body:
              'Alaska\'s rule: gear that gets wet stays wet. Carry fire-starting redundancy in two different pockets. Map AND GPS — fog, dead batteries, and featureless tundra defeat each one alone. Hypothermia steals dexterity, so practice every survival task wearing gloves.',
        ),
        GuideSection(
          heading: 'Shelter Priorities',
          body:
              'In wet, 40°F coastal weather, hypothermia kills faster than anything except water itself. An 8×10 silnylon tarp plus a bivy weighs under 2 lbs and turns a soaked night from fatal to miserable. Below treeline, spruce boughs insulate you from cold ground.',
        ),
        GuideSection(
          heading: 'Signaling for Rescue',
          body:
              'Three of anything is the distress signal: whistle blasts, fires, flashes. Orange tarp panels and signal mirrors are visible to aircraft for miles. If you trigger an SOS on a satellite device, stay put unless your position is unsafe — moving targets are hard to find.',
        ),
      ],
      proTips: [
        'Test-fire your ferro rod with cold, wet hands before the trip, not during the emergency.',
        'Trash compactor bags: pack liner, emergency rain skirt, water carrier — 2 oz of insurance.',
      ],
      safetyNote:
          'File a trip plan. Searches in Alaska start where you said you\'d be — if nobody knows, nobody\'s coming.',
    ),
    Guide(
      id: 'surv-hypothermia',
      title: 'Hypothermia & Cold-Water Survival',
      category: 'Survival',
      emoji: '🥶',
      summary:
          'Alaska\'s deadliest hazard isn\'t bears — it\'s cold water and wet cold. Recognize it, prevent it, treat it.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'The Umbles',
          body:
              'Stumbles, mumbles, fumbles, grumbles — early hypothermia announces itself through clumsiness and bad decisions. The victim is the last to know. Watch your partners; if someone stops shivering while still cold, that\'s severe hypothermia and a true emergency.',
        ),
        GuideSection(
          heading: 'Cold Water: 1-10-1',
          body:
              'Fall into 40°F water and you have 1 minute to control your gasping, 10 minutes of meaningful movement, 1 hour before unconsciousness. Alaska\'s lakes, rivers, and ocean are this cold all year. Get out, get dry, get insulated — in that order, immediately.',
        ),
        GuideSection(
          heading: 'Field Treatment',
          body:
              'Strip wet layers, insulate from the ground, add dry layers and a vapor barrier, feed warm sugary drinks if fully conscious. For severe cases, handle gently (rough movement can stop a cold heart), build a hypo-wrap "burrito" of pads and bags, and trigger evacuation.',
        ),
      ],
      proTips: [
        'Wool and synthetics insulate when wet. Cotton kills in Alaska — leave it in town.',
        'Eat constantly in the cold; your furnace needs fuel before you feel hungry.',
      ],
      safetyNote:
          'River crossings: unbuckle your hip belt, face upstream, use a third point of contact. If it\'s above your knees and pushing, walk another mile for a braid.',
    ),
    Guide(
      id: 'surv-navigation',
      title: 'Navigating the Bush',
      category: 'Survival',
      emoji: '🗺️',
      summary:
          'Staying found where there are no trails, no signs, and a magnetic declination that will ruin your day.',
      difficulty: 'Advanced',
      readMinutes: 6,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Declination Matters Here',
          body:
              'Magnetic declination in Alaska runs up to 20°+ east — ignore it and you\'ll be a mile off after an hour\'s walk. Set your compass\'s declination for your specific area, and re-check it; it changes measurably year to year this far north.',
        ),
        GuideSection(
          heading: 'Handrails and Backstops',
          body:
              'Navigate tundra and bush by terrain, not bearings alone: follow rivers, ridgelines, and lake shores as handrails, and pick a "backstop" feature (a road, a major river) that will catch you if you overshoot. Whiteouts and fog erase everything — when visibility dies, stop and wait.',
        ),
        GuideSection(
          heading: 'GPS Discipline',
          body:
              'Download offline maps before you leave cell coverage — most of Alaska has none. Mark your camp, your boat, and every cache as waypoints. Carry a paper map and know where you are on it at all times; batteries are a consumable, terrain memory is not.',
        ),
      ],
      proTips: [
        'In flat tundra, walking a deliberate slight curve beats wandering an accidental circle.',
        'Glacial rivers braid and move yearly — old maps lie about channels.',
      ],
    ),
    Guide(
      id: 'surv-bushcraft',
      title: 'Bushcraft: Fire, Shelter & Calling for Help',
      category: 'Survival',
      emoji: '🪓',
      summary:
          'The unplanned night out is the most common Alaska emergency. Fire, shelter, and signaling skills that turn it into a story instead of a tragedy.',
      difficulty: 'Intermediate',
      readMinutes: 7,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Finding Fuel in a Wet Forest',
          body:
              'Alaska\'s forests are wet most of the year, but dry tinder is always there if you know where to look: dead lower branches still attached to spruce trunks ("squaw wood"), the papery curls of birch bark, and the fibrous inner bark of standing dead trees. Split larger wood to expose the dry core — the outside of a soaked log is rarely a fair test of the inside. Birch bark burns even when damp thanks to its natural oils, and a fistful makes a reliable fire starter.',
        ),
        GuideSection(
          heading: 'Building a Shelter That Works',
          body:
              'Heat loss to the ground and wind kills faster than cold air alone. A thick bed of boughs, dry grass, or moss under you insulates more than most people expect — get off the ground before you do anything else. A simple lean-to angled away from the wind, tarp or space blanket over a ridgeline, traps body heat and blocks precipitation. In open tundra with no trees, a low wall of stacked sod, packs, or snow blocks the wind enough to matter.',
        ),
        GuideSection(
          heading: 'Signaling and Staying Connected',
          body:
              'Three of anything — three fires, three whistle blasts, three flashes — is the universal distress signal. A signal fire built ahead of time (with green boughs ready to throw on for smoke) can be lit fast when a plane or boat appears. Bright clothing or a tarp laid out in the open helps aircraft spot you against brush and snow. A satellite communicator or PLB (personal locator beacon) is the single biggest upgrade to your odds — register it, test it before every trip, and know its battery life in the cold.',
        ),
        GuideSection(
          heading: 'Who Comes Looking for You',
          body:
              'Alaska State Troopers coordinate most search and rescue, often with the Alaska Air National Guard\'s 176th Wing for air assets, plus local volunteer SAR groups. They search based on the information you left behind — your trip plan, vehicle location, and the time someone reported you overdue. A trip plan left with a reliable contact, including your route and turn-around time, is worth more than almost any piece of gear.',
        ),
      ],
      proTips: [
        'Process firewood before dark — fumbling with a knife or saw by headlamp in the cold is when injuries happen.',
        'A handful of cotton ball and petroleum jelly, sealed in a film canister, lights even in wind and rain.',
        'Practice your fire-starting kit at home, in the rain, before you need it for real.',
      ],
      safetyNote:
          'If you trigger an SOS on a PLB or satellite communicator, stay put unless moving to a safer or more visible location is clearly better — rescuers search the coordinates you sent, and a moving target is much harder to find.',
    ),
    Guide(
      id: 'winter-layering',
      title: 'Layering for Deep Cold',
      category: 'Survival',
      emoji: '🧥',
      summary:
          'Dressing for -20°F and colder, Interior-style: the system that keeps Alaskans working outside all winter.',
      difficulty: 'Beginner',
      readMinutes: 5,
      season: 'October – April',
      sections: [
        GuideSection(
          heading: 'The Three-Layer Rule',
          body:
              'Wicking base (merino or synthetic, never cotton), insulating mid (fleece, wool, or active-insulation), and shell or parka. The skill is venting BEFORE you sweat — sweat is wet, wet is cold, cold is dangerous. Start a ski or hike slightly chilly; you\'ll warm in ten minutes.',
        ),
        GuideSection(
          heading: 'Extremities Win or Lose It',
          body:
              'Mittens beat gloves below 0°F; carry liner gloves for dexterity tasks. Double up on socks only if your boots have room — compression kills circulation. A quality hat, neck gaiter, and goggles handle the wind on exposed skin that frostbites in minutes at -30°F with wind.',
        ),
        GuideSection(
          heading: 'The Puffy Rule',
          body:
              'The moment you stop moving — trail break, fishing hole, photo stop — the big parka goes ON, before you cool down. Experienced Alaskans size their parka to fit over every other layer for exactly this reason.',
        ),
      ],
      proTips: [
        'Chemical toe warmers fade fast in tight boots; loosen laces in deep cold.',
        'Keep water bottles upside down — they freeze from the top.',
      ],
    ),

    // ── Wildlife ──────────────────────────────────────────────────────────
    Guide(
      id: 'wild-bears',
      title: 'Bear Safety: Browns & Blacks',
      category: 'Wildlife',
      emoji: '🐻',
      summary:
          'Alaska has more brown bears than the rest of the U.S. combined. How to hike, camp, and fish among them.',
      difficulty: 'Beginner',
      readMinutes: 8,
      season: 'April – November',
      sections: [
        GuideSection(
          heading: 'Avoid the Encounter',
          body:
              'Make noise constantly in brush, near streams, and into the wind — "Hey bear!" every minute beats a surprise at ten yards. Travel in groups; no group of four or more making noise has ever been seriously hurt by a bear in Alaska. Watch for fresh sign: tracks, scat, diggings, and day beds.',
        ),
        GuideSection(
          heading: 'If You Meet a Bear',
          body:
              'Stand your ground, speak calmly, wave your arms slowly, and back away at an angle when it disengages. NEVER run — you trigger a chase you cannot win. A bear standing on hind legs is curious, not charging. Most charges are bluffs that veer off; hold your ground with spray ready.',
        ),
        GuideSection(
          heading: 'Spray Beats Everything',
          body:
              'Bear spray stops attacks more reliably than firearms in the data. Carry it on your chest or hip, practice the draw, and know it\'s a 7–9 yard tool. Spray a one-second burst slightly downward into a charge. Wind matters — angle accordingly.',
        ),
        GuideSection(
          heading: 'If Contact Happens',
          body:
              'Brown/grizzly defensive attack: play dead — flat on stomach, hands on neck, legs spread, stay still until it leaves. Black bear attack, or ANY bear that stalks you or enters your tent: fight back with everything, targeting the face and nose. Predatory attacks are rare but you do not play dead in them.',
        ),
      ],
      proTips: [
        'Check spray expiration dates and never store canisters in a hot car.',
        'Bells are nearly useless — your voice carries farther and identifies you as human.',
      ],
      safetyNote:
          'Distinguish them right: brown bears have a shoulder hump and dished face; black bears have a straight "Roman" profile and taller ears. Color is meaningless — black bears come in cinnamon, browns come in blond.',
    ),
    Guide(
      id: 'wild-moose',
      title: 'Moose: The Most Dangerous Animal You\'ll Meet',
      category: 'Wildlife',
      emoji: '🫎',
      summary:
          'Moose injure more Alaskans than bears every year. Reading the warning signs and giving the right of way.',
      difficulty: 'Beginner',
      readMinutes: 5,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Why Moose Are Different',
          body:
              'A bull can top 1,600 lbs and a cow with calves is the most aggressive animal in the state. Moose don\'t bluff-charge for show like bears — they stomp. Urban moose in Anchorage and Fairbanks are habituated, not tame, and winter-stressed moose in deep snow have hair triggers.',
        ),
        GuideSection(
          heading: 'Warning Signs',
          body:
              'Ears pinned back, hackles raised on the hump, licking lips, head lowered, swaying — back off NOW. Unlike with bears, running from a moose is correct: get behind a tree, a car, anything solid. Moose rarely pursue far.',
        ),
        GuideSection(
          heading: 'Calving Season & Rut',
          body:
              'Mid-May through June, cows with newborn calves will charge anything that approaches — give them a city block, and never get between cow and calf. September–October rut makes bulls unpredictable and territorial. Dogs trigger moose attacks; keep them leashed on trails.',
        ),
      ],
      proTips: [
        'A moose blocking the trail owns the trail. Detour wide or wait it out.',
        'Driving at dusk: scan ditches. A moose strike at highway speed is often fatal for both parties.',
      ],
    ),
    Guide(
      id: 'wild-viewing-areas',
      title: 'Best Wildlife Viewing Spots & Sanctuaries',
      category: 'Wildlife',
      emoji: '🔭',
      summary:
          'Where Alaska\'s wildlife concentrates and is used to an audience — from bear-viewing platforms to roadside pullouts.',
      difficulty: 'Beginner',
      readMinutes: 7,
      season: 'May – September',
      sections: [
        GuideSection(
          heading: 'Brooks Falls, McNeil River & Anan',
          body:
              'Katmai\'s Brooks Falls is the iconic image of brown bears catching leaping salmon, viewable from elevated platforms during the July sockeye run and again in September. McNeil River State Game Sanctuary requires a permit lottery but offers some of the closest, most relaxed bear viewing on earth. Anan Wildlife Observatory near Wrangell is a quieter option for watching both black and brown bears fish a pink salmon stream from a viewing structure.',
        ),
        GuideSection(
          heading: 'Kenai Fjords, Prince William Sound & Glacier Bay',
          body:
              'Day-boat tours out of Seward, Whittier, and Juneau put you among tidewater glaciers, breaching humpback whales, Steller sea lion rookeries, and rafts of sea otters. Glacier Bay National Park combines all of this with a chance at orcas and occasionally minke whales. Binoculars and a warm layer matter more than a long lens — the wind off the water is real even on sunny days.',
        ),
        GuideSection(
          heading: 'Denali Highway, Potter Marsh & Chilkat Eagle Preserve',
          body:
              'The Denali Highway\'s open tundra holds caribou, Dall sheep on the high slopes near MacLaren Summit, and the occasional grizzly working a hillside — bring a spotting scope and glass from pullouts. Potter Marsh on the south edge of Anchorage is a boardwalk wetland with nesting trumpeter swans, arctic terns, and spawning salmon visible from the path. The Chilkat Bald Eagle Preserve near Haines hosts one of the largest gatherings of bald eagles on the continent each fall, drawn by a late chum salmon run.',
        ),
        GuideSection(
          heading: 'Wildlife Centers: AWCC, the Alaska SeaLife Center & More',
          body:
              'For guaranteed sightings and close looks, the Alaska Wildlife Conservation Center in Girdwood houses rescued bears, moose, musk oxen, and wood bison in large enclosures. The Alaska SeaLife Center in Seward focuses on marine species — puffins, seals, and a giant Pacific octopus — and doubles as a rehabilitation facility. The Musk Ox Farm in Palmer and the Large Animal Research Station (LARS) near Fairbanks both offer close-up looks at musk oxen and reindeer that are nearly impossible to get in the wild.',
        ),
      ],
      proTips: [
        'Early morning and evening "golden hours" are when most animals are active and the light is best.',
        'A spotting scope on a tripod beats a long camera lens for actually finding distant animals first.',
        'Bear-viewing platforms fill up — book well ahead for Brooks Falls and McNeil River.',
      ],
    ),
    Guide(
      id: 'wild-marine',
      title: 'Marine Mammals & Seabirds of the Alaska Coast',
      category: 'Wildlife',
      emoji: '🐋',
      summary:
          'Whales, seals, sea lions, otters, and the seabird colonies that fill Alaska\'s coastal waters every summer.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'May – September',
      sections: [
        GuideSection(
          heading: 'Whales',
          body:
              'Humpback whales feed in Southeast and South-central waters all summer, often bubble-net feeding in cooperative groups — a spectacle worth a dedicated tour. Orcas (both resident fish-eating pods and transient mammal-hunters) range widely through the Inside Passage and Kenai Fjords. Gray whales pass through on their spring migration, and minke whales and Dall\'s porpoises show up as bonus sightings on most boat tours.',
        ),
        GuideSection(
          heading: 'Seals, Sea Lions & Sea Otters',
          body:
              'Harbor seals haul out on floating ice near tidewater glaciers — a boat slowing near a glacier face is often watching for seals as much as ice. Steller sea lions gather in noisy, smelly rookeries on rocky islets; their numbers and roars are best appreciated from a respectful distance. Sea otters, once hunted to near-extinction for their fur, are now common in calm bays and estuaries, often floating on their backs cracking shellfish on their chests.',
        ),
        GuideSection(
          heading: 'Coastal & Seabird Life',
          body:
              'Tufted and horned puffins nest in burrows on coastal cliffs and islands, visible on tours out of Seward, Whittier, and Kodiak. Bald eagles are common enough along the coast to barely warrant a second glance from locals, but a tree full of them near a salmon stream is still a sight. Kittiwakes, murres, and cormorants crowd cliff colonies in the tens of thousands during nesting season, filling the air with noise.',
        ),
        GuideSection(
          heading: 'Viewing Ethics & Rules',
          body:
              'Federal law requires staying at least 100 yards from whales and 50 yards from other marine mammals such as seals, sea lions, and sea otters — closer approaches by boat or drone are both illegal and stressful to the animals. Never approach a hauled-out seal pup; mothers leave pups alone on beaches and rocks while feeding, and a "stranded" pup is usually fine. Report marine mammals that appear entangled, injured, or genuinely stranded to NOAA\'s marine mammal hotline rather than intervening yourself.',
        ),
      ],
      proTips: [
        'A pair of binoculars turns a "maybe that was a whale" boat ride into an actual wildlife tour.',
        'Calm, glassy water in early morning makes distant blows and fins far easier to spot.',
      ],
      safetyNote:
          'Stay at least 100 yards from whales and 50 yards from other marine mammals — these distances are federal law (Marine Mammal Protection Act), not just etiquette.',
    ),

    // ── Aurora ────────────────────────────────────────────────────────────
    Guide(
      id: 'winter-aurora',
      title: 'Hunting the Northern Lights',
      category: 'Aurora',
      emoji: '🌌',
      summary:
          'When, where, and how to catch the aurora borealis — Fairbanks, the Interior, and beyond.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'late August – mid April',
      sections: [
        GuideSection(
          heading: 'Timing the Show',
          body:
              'Aurora season runs late August to mid-April; peak viewing is 10 PM–2 AM around the equinoxes. Fairbanks sits directly under the auroral oval — statistically your best odds in the state. Check the UAF Geophysical Institute forecast and aim for Kp 3+ with clear skies.',
        ),
        GuideSection(
          heading: 'Where to Watch',
          body:
              'Escape city glow: Cleary Summit and Murphy Dome near Fairbanks, Eureka and the Glenn Highway pullouts from Anchorage, or splurge on Chena Hot Springs and watch from the rocks. The Dalton Highway offers zero light pollution if you\'re equipped for serious cold.',
        ),
        GuideSection(
          heading: 'Photographing It',
          body:
              'Tripod, wide lens (f/2.8 or faster), ISO 1600–3200, 2–8 second exposures, manual focus set to infinity on a star before your fingers freeze. Phone night modes now do respectably on a tripod. Batteries die fast at -20°F — keep spares inside your jacket.',
        ),
      ],
      proTips: [
        'A faint grey arc on the northern horizon is often aurora your camera will reveal in color.',
        'Watch a dark sky for 15+ minutes before giving up — displays come in waves.',
      ],
      safetyNote:
          'Aurora chasing means standing still at -20°F or colder. Dress like you\'re winter camping, not like you\'re walking to the car.',
    ),
    Guide(
      id: 'aurora-forecast',
      title: 'Reading the Aurora Forecast: Space Weather 101',
      category: 'Aurora',
      emoji: '📡',
      summary:
          'Decode the Kp index, solar wind data, and Bz readings so you know when to actually bother going outside.',
      difficulty: 'Intermediate',
      readMinutes: 6,
      season: 'late August – mid April',
      sections: [
        GuideSection(
          heading: 'The Kp Index Decoded',
          body:
              'The Kp index (0–9) measures global geomagnetic disturbance. Fairbanks sits far enough north that even Kp 1–2 can produce overhead aurora on a clear night, while Anchorage and the Kenai usually need Kp 4+ to see much, and Kp 6+ for a show worth a long drive. Forecasts from the UAF Geophysical Institute and NOAA\'s Space Weather Prediction Center give a 30-minute and 3-day Kp outlook — treat the 3-day number as a rough heads-up and the 30-minute number as your "go now" signal.',
        ),
        GuideSection(
          heading: 'Solar Wind: Speed, Density & Lead Time',
          body:
              'Real-time solar wind data from NOAA\'s ACE/DSCOVR satellites, positioned about an hour upstream of Earth, gives roughly 30–60 minutes of warning before conditions change. Higher solar wind speed (above ~400 km/s) and density generally mean stronger aurora — but speed alone isn\'t the whole story. A fast solar wind stream with the wrong magnetic orientation can still produce a quiet night.',
        ),
        GuideSection(
          heading: 'Bz and the IMF: The Real Switch',
          body:
              'The single most useful number for short-notice chasing is Bz — the north-south component of the interplanetary magnetic field. When Bz goes negative (southward), it connects with Earth\'s magnetic field and lets solar wind energy pour in, often triggering a substorm within 30–60 minutes. A strongly negative Bz reading on a real-time monitor is the closest thing to a "the lights are about to turn on" alert.',
        ),
        GuideSection(
          heading: 'Putting the Forecasts Together',
          body:
              'Start with the 3-day Kp outlook to decide if a trip is worth planning around. The night of, check cloud cover first — clear skies with modest Kp beat overcast skies with a geomagnetic storm. Then watch real-time Bz and Kp in the hours before you head out, and again once you\'re outside; substorms can ramp up and fade within an hour, so patience and re-checking pay off.',
        ),
      ],
      proTips: [
        'A negative Bz combined with rising solar wind speed is the best short-notice signal to get outside.',
        'Apps that push real-time Kp and Bz alerts beat refreshing a website at 1 AM.',
        'Even a "low" forecast night can produce a surprise substorm — check before writing off a clear sky.',
      ],
    ),

    // ── Hiking ────────────────────────────────────────────────────────────
    Guide(
      id: 'hike-tundra',
      title: 'Off-Trail Travel: Tundra, Talus & Alders',
      category: 'Hiking',
      emoji: '🥾',
      summary:
          'Most of Alaska has no trails. How to move efficiently across tussocks, scree, and the dreaded alder thickets.',
      difficulty: 'Advanced',
      readMinutes: 7,
      season: 'June – September',
      sections: [
        GuideSection(
          heading: 'Tussocks & Muskeg',
          body:
              'Tussock tundra — basketball-sized grass heads over ankle-deep water — is Alaska\'s most hated walking surface. Step between them in the muck or balance on top, but budget half your normal pace either way. Gaiters and trekking poles are mandatory; waterproof boots are optimism.',
        ),
        GuideSection(
          heading: 'The Alder War',
          body:
              'Alder thickets choke gullies and avalanche paths below treeline. Route AROUND them: follow ridgelines, gravel bars, or game trails, even when it doubles the distance. If you must push through, keep your group tight and loud — alders are where you surprise bears.',
        ),
        GuideSection(
          heading: 'Ridges and River Bars',
          body:
              'Alaska\'s highways are dry ridgelines above brush and gravel river bars below it. Caribou and moose trails are usually the best line through bad terrain — animals optimize the same things you do. Scout your route from every high point.',
        ),
        GuideSection(
          heading: 'Pace Math',
          body:
              'On-trail Lower 48 pace: 3 mph. Alaska off-trail: 1 mph through brush, 1.5 on tundra, 2+ on ridges and bars. Plan distances accordingly or plan an unplanned bivy.',
        ),
      ],
      proTips: [
        'Cross glacial streams early morning when overnight cold has dropped the meltwater level.',
        'Game trails braid — keep your compass bearing honest while you borrow them.',
      ],
      safetyNote:
          'Tell someone your route corridor, not just your destination. Off-trail searches need a line to follow.',
    ),
    Guide(
      id: 'hike-classic-trails',
      title: 'Alaska\'s Classic Day Hikes',
      category: 'Hiking',
      emoji: '🏔️',
      summary:
          'Reliable, rewarding trails near the road system — from Anchorage overlooks to Southeast rainforest.',
      difficulty: 'Beginner',
      readMinutes: 7,
      season: 'May – September',
      sections: [
        GuideSection(
          heading: 'Anchorage-Area Classics',
          body:
              'Flattop Mountain is the most-climbed peak in Alaska for a reason — a short, steep trail from the Glen Alps trailhead to sweeping views of the city, the Chugach, and on clear days Denali itself. The Glen Alps and Powerline Pass trails offer longer options into alpine tundra with frequent Dall sheep sightings. Closer to downtown, the Tony Knowles Coastal Trail is a flat, paved option along Cook Inlet with good odds of spotting beluga whales in season.',
        ),
        GuideSection(
          heading: 'Hatcher Pass & Mat-Su',
          body:
              'Hatcher Pass, an hour from Anchorage, offers alpine hiking without the crowds — the trail to the historic Independence Mine buildings is an easy stroll, while routes up Bald Mountain or Gold Mint Trail climb into open tundra with wildflowers in July. The Matanuska Glacier, off the Glenn Highway, offers guided walks onto the ice itself for those wanting a hands-on glacier experience.',
        ),
        GuideSection(
          heading: 'Kenai Peninsula',
          body:
              'The Harding Icefield Trail near Exit Glacier in Seward is a strenuous climb that rewards with a view over an icefield the size of a small country. Closer to the road, the Russian Lakes and Resurrection Pass trail systems offer everything from easy lakeside walks to multi-day backpacking through prime bear country — fish counts on the Russian River draw both anglers and bears in midsummer.',
        ),
        GuideSection(
          heading: 'Girdwood & Southeast',
          body:
              'Near Girdwood, the Winner Creek Trail winds through old-growth rainforest to a hand-tram crossing over a gorge — a fun, family-friendly outing. In Southeast, Juneau\'s Mount Roberts and Perseverance trails climb quickly from sea level into alpine terrain with views over the channel, while Ketchikan\'s Deer Mountain offers a similar rainforest-to-alpine transition close to town.',
        ),
      ],
      proTips: [
        'Weekday mornings mean empty trailheads even at the most popular spots.',
        'Pack rain gear even on a forecast-sunny day — Southeast and coastal weather changes fast.',
        'Trailhead parking fills early at Flattop and Exit Glacier in peak season; arrive before 9 AM.',
      ],
    ),
    Guide(
      id: 'hike-navigation-terrain',
      title: 'Reading the Terrain: Navigation & River Crossings',
      category: 'Hiking',
      emoji: '🧭',
      summary:
          'The skills that separate a good off-trail day from a bad one: reading ground, timing rivers, and crossing safely.',
      difficulty: 'Advanced',
      readMinutes: 7,
      season: 'June – September',
      sections: [
        GuideSection(
          heading: 'Reading Micro-Terrain',
          body:
              'Small terrain features dictate your pace far more than the map suggests. A subtle bench above a creek often holds firmer ground and a game trail; a gully choked with brush usually isn\'t worth the fight. Learn to spot the difference between dry tundra (firm, hummocky) and wet tundra or muskeg (spongy, often hiding standing water) from a distance by color and texture — darker, greener patches are usually wetter.',
        ),
        GuideSection(
          heading: 'Glacial Rivers: Timing Is Everything',
          body:
              'Glacial and snowmelt-fed rivers rise through the day as the sun melts ice and snow upstream, often peaking in late afternoon and dropping back overnight. The same crossing that\'s knee-deep at 7 AM can be thigh-deep and pushy by 4 PM. Plan crossings for early morning when possible, and treat a rising, cloudy, debris-laden river as a sign to wait rather than push through.',
        ),
        GuideSection(
          heading: 'Crossing Technique',
          body:
              'Unbuckle your pack\'s hip belt and sternum strap before entering the water — a pack that drags you under is far more dangerous than wet gear. Face slightly upstream and angle across, using trekking poles for a stable tripod stance and shuffling rather than crossing steps. Look for a wide, braided section rather than a narrow, deep chute; wide usually means shallower and slower per channel.',
        ),
        GuideSection(
          heading: 'Devil\'s Club, Crevasses & Moraines',
          body:
              'Devil\'s club — a spiny-stemmed plant common in wet forest understory — leaves painful, infection-prone splinters; avoid grabbing anything green for balance in thick brush. Near glaciers, snow-covered ice can hide crevasses even where the surface looks flat — that\'s rope-team terrain. Ice-cored moraines (gravel-covered hills near glacier margins) can collapse without warning as the buried ice melts; don\'t camp or linger on them.',
        ),
      ],
      proTips: [
        'If a river crossing feels wrong, it probably is — backtrack and look for a better braid or wait it out.',
        'A topo map with recent satellite overlay catches river channel changes that paper maps miss.',
        'Trekking poles double as crevasse probes and crossing aids — worth the weight.',
      ],
      safetyNote:
          'Never cross a glacial river alone if you can avoid it, and never attempt glacier travel on snow-covered ice without rope-team training and a partner. Both are leading causes of backcountry fatalities in Alaska.',
    ),

    Guide(
      id: 'hike-glacier',
      title: 'Glacier Viewing & Travel Basics',
      category: 'Hiking',
      emoji: '🧊',
      summary:
          'Enjoying Exit, Matanuska, Mendenhall and friends without becoming a rescue statistic.',
      difficulty: 'Intermediate',
      readMinutes: 5,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'The Toe Is a Trap',
          body:
              'Glacier faces calve without warning — tons of ice fall silently until the second they don\'t. Stay out of ice caves and off the terminus face unless you\'re with a guided, equipped party. At tidewater glaciers like those in Kenai Fjords, calving waves can swamp kayaks far from the face: keep ½ mile back.',
        ),
        GuideSection(
          heading: 'Walking on Ice',
          body:
              'White ice (snow-free, late summer) is grippy with microspikes and reasonably safe near maintained access points like Matanuska\'s guided routes. Snow-covered glaciers hide crevasses — that\'s rope-team terrain, full stop. Book a guide; the gear and rescue skills aren\'t optional up there.',
        ),
        GuideSection(
          heading: 'Moraine and Outwash Hazards',
          body:
              'The gray gravel hills near glaciers are often ice-cored — slopes collapse underfoot. Outburst floods (jökulhlaups) can raise glacial rivers in minutes; don\'t linger in braided channels below glacier-dammed lakes.',
        ),
      ],
      proTips: [
        'Overcast days make glacier ice glow its deepest blue for photos.',
        'Microspikes rent cheap in Anchorage and turn icy viewpoint trails into easy walking.',
      ],
    ),

    // ── Food ──────────────────────────────────────────────────────────────
    Guide(
      id: 'food-wild-game',
      title: 'Cooking Wild Game: From Field to Table',
      category: 'Food',
      emoji: '🍳',
      summary:
          'Getting the most from moose, caribou, salmon, and other wild Alaska protein — without the gamey reputation.',
      difficulty: 'Intermediate',
      readMinutes: 7,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Why Wild Game Tastes Different',
          body:
              'Wild game is lean — moose and caribou carry a fraction of the fat of beef — which means it cooks faster and dries out faster. Most "gamey" flavor complaints actually come from poor field handling: meat that sat warm too long, or was left in contact with hide and hair. Quick cooling, clean butchering, and trimming silver skin and fat (which can carry off-flavors in some species) solve most of the problem before the meat ever hits a pan.',
        ),
        GuideSection(
          heading: 'Cuts and Their Best Uses',
          body:
              'Treat backstrap and tenderloin like the prime cuts they are — quick, hot cooking (sear and rest) is all they need. Shoulder, neck, and shank cuts are full of connective tissue and reward long, slow, moist cooking: braises, stews, and pot roasts break them down into something far better than a quick pan-fry would. Ground meat from trim is endlessly versatile but benefits from added fat (bacon, butter, or beef fat) since wild game ground meat has almost none of its own.',
        ),
        GuideSection(
          heading: 'Avoiding the Dry, Tough Plate',
          body:
              'Because wild game lacks marbling, it goes from perfectly cooked to overdone in a narrow window — pull steaks and roasts a few degrees earlier than you would with beef and let them rest. Marinades won\'t tenderize tough cuts (they barely penetrate the surface) but they do add flavor and help with moisture during cooking. A meat thermometer is the single best tool for not ruining an expensive cut.',
        ),
        GuideSection(
          heading: 'Salmon and Other Fish',
          body:
              'Fresh-caught salmon needs very little — a hot pan or grill, skin-side down first, and a few minutes per side until it just turns opaque. Smoking and canning extend the season: a basic brine of salt, sugar, and water followed by a low, slow smoke produces shelf-stable fish that keeps for months. Halibut\'s mild flavor takes well to simple preparations — a light dust of flour and a hot pan, or baked with butter and lemon.',
        ),
      ],
      proTips: [
        'Cool meat fast and keep it clean in the field — that\'s 90% of "how it tastes" decided before you get home.',
        'Add fat to ground wild game (bacon, suet, butter) for burgers and meatballs that don\'t fall apart or dry out.',
        'A meat thermometer and a willingness to pull things early are the two cheapest upgrades to wild game cooking.',
      ],
    ),
    Guide(
      id: 'food-sourdough',
      title: 'Alaska Sourdough: Starters, Pancakes & Bread',
      category: 'Food',
      emoji: '🍞',
      summary:
          'A living tradition from the gold rush days — keeping a starter alive and putting it to work.',
      difficulty: 'Beginner',
      readMinutes: 5,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'A Gold Rush Tradition',
          body:
              'Sourdough earned its place in Alaska history because it didn\'t need commercial yeast — prospectors and trappers kept a starter alive through long winters, sometimes carrying it next to their bodies in cold camps to keep it from freezing. "Sourdough" became slang for a longtime Alaskan, a nod to how central the starter was to daily life and how long some have been kept going.',
        ),
        GuideSection(
          heading: 'Keeping a Starter Alive',
          body:
              'A starter is just flour and water fermented by wild yeast and bacteria — feed it roughly equal parts flour and water on a regular schedule (daily at room temperature, weekly if refrigerated) and it will keep indefinitely. A healthy starter smells pleasantly sour and tangy, not like nail polish or alcohol (a sign it\'s hungry and needs feeding, easily fixed with a feed and a little patience). In a cold cabin, keeping the starter near a heat source — but not too close — matters more than any other variable.',
        ),
        GuideSection(
          heading: 'Pancakes, Bread & Beyond',
          body:
              'Sourdough pancakes are the classic starting point — discard starter (the portion you\'d otherwise throw away when feeding) mixed with an egg, a little oil, and a pinch of baking soda makes pancakes with a distinctive tang and excellent texture. From there, sourdough bread, biscuits, and even waffles all use the same basic principle: active starter provides both rise and flavor, often with a small boost from commercial yeast or baking soda for a more reliable rise in a home kitchen.',
        ),
      ],
      proTips: [
        'A starter that\'s been neglected in the fridge for weeks usually bounces back with two or three daily feeds.',
        'Glass or plastic containers work better than metal, which can react with the acidic starter over time.',
        'Save a little starter in a separate jar before a big baking day, in case something goes wrong with the main batch.',
      ],
    ),
    Guide(
      id: 'food-local-delicacies',
      title: 'Alaska Local Delicacies Worth Trying',
      category: 'Food',
      emoji: '🐟',
      summary:
          'From smoked salmon to reindeer sausage — the foods that define eating in Alaska.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Salmon, Every Way',
          body:
              'Smoked salmon — whether the soft, candy-like "salmon candy" cured with sugar and brine, or firmer hard-smoked strips — is the food most associated with Alaska, and for good reason. Salmon roe (often called "salmon eggs" or, when prepared a certain way, "ikura") shows up cured and served over rice in many local restaurants, a nod to the strong Alaska Native and Russian influences on the state\'s food culture.',
        ),
        GuideSection(
          heading: 'Reindeer and Other Game Sausage',
          body:
              'Reindeer sausage — found everywhere from gas station hot dog rollers to fine dining menus — is a mild, slightly sweet sausage that\'s become a default Alaska snack. It\'s often farmed reindeer (a domesticated caribou) rather than wild game, but the flavor profile is similar to other lean red meats. Look for it at street carts in Anchorage and Fairbanks alongside more standard hot dog toppings.',
        ),
        GuideSection(
          heading: 'King Crab & Other Seafood',
          body:
              'Alaska king crab, snow crab, and Dungeness crab are seasonal but worth seeking out fresh near the ports they\'re landed in — Kodiak, Dutch Harbor, and Southeast towns in particular. Spot prawns, a brief spring fishery, are a local favorite that rarely makes it to markets outside the state. Halibut cheeks — small, scallop-like morsels from the fish\'s head — are a prized cut often reserved by fishermen rather than sold.',
        ),
        GuideSection(
          heading: 'Berries, Birch Syrup & Akutaq',
          body:
              'Wild berries — blueberries, salmonberries, and especially low-bush cranberries — show up in jams, pies, and sauces throughout late summer and fall. Birch syrup, tapped and boiled down like maple syrup but requiring far more sap per gallon, has a distinctive caramel-and-molasses flavor and is produced by a handful of small Alaska operations. Akutaq, sometimes called "Eskimo ice cream," is a traditional Alaska Native dish blending berries, fat (historically seal or reindeer fat, often shortening today), and sometimes fish — a food with deep cultural significance worth learning about respectfully.',
        ),
      ],
      proTips: [
        'Farmers markets in Anchorage, Fairbanks, and Homer are the best place to find small-batch birch syrup and local jams.',
        'Ask where seafood was caught — "local" and "Alaska" on a menu don\'t always mean the same boat or even the same season.',
        'If you\'re offered akutaq or other traditional foods, accepting graciously is appreciated — it\'s often shared as a gesture of hospitality.',
      ],
    ),
    Guide(
      id: 'food-backcountry-kitchen',
      title: 'The Backcountry Kitchen: Cooking Away from Home',
      category: 'Food',
      emoji: '🍲',
      summary:
          'Simple, efficient meals for camp, cabin, and boat — built around what packs light and what you might catch or shoot along the way.',
      difficulty: 'Beginner',
      readMinutes: 5,
      season: 'Year-round',
      sections: [
        GuideSection(
          heading: 'Planning Around What You Might Catch',
          body:
              'A smart backcountry menu plans a few meals around fish or game you might bring in, with simple shelf-stable backups if you don\'t. A bag of rice, some dehydrated vegetables, and a few seasoning packets turn a fresh-caught grayling or a grouse into a real meal with almost no added weight. Building meals this way means you\'re never disappointed by an empty stringer — the planned meal still happens, just without the bonus protein.',
        ),
        GuideSection(
          heading: 'One-Pot Efficiency',
          body:
              'A single pot that can boil water, simmer a stew, and double as a serving bowl cuts down on both weight and cleanup — critical when water for washing dishes might mean a cold walk to a creek. One-pot meals (pasta with dehydrated sauce, rice and beans, soups) also cook faster at altitude and in cold temperatures than multi-pot meals, where heat is constantly being lost to a second cold pot.',
        ),
        GuideSection(
          heading: 'Fuel and Cold-Weather Cooking',
          body:
              'White gas (liquid fuel) stoves perform far better than canister stoves in cold temperatures — canister fuel loses pressure and can fail outright below freezing, while liquid fuel stoves keep working. Pre-warming a canister in a jacket pocket helps in a pinch but isn\'t a long-term fix for serious cold. Always cook with ventilation — carbon monoxide from stoves in enclosed tents or shelters is a real and sometimes fatal risk.',
        ),
      ],
      proTips: [
        'Pre-mix spice blends at home in small bags — it saves carrying six separate containers.',
        'A foil packet of butter or oil adds enormous flavor and calories for almost no weight.',
        'Test a new stove or fuel setup at home in the cold before relying on it in the field.',
      ],
    ),

    // ── Harvesting ────────────────────────────────────────────────────────
    Guide(
      id: 'harvest-berries',
      title: 'Berry Picking: Alaska\'s Wild Bounty',
      category: 'Harvesting',
      emoji: '🫐',
      summary:
          'From blueberries to salmonberries — what to pick, where, and the few plants in the woods you should leave alone.',
      difficulty: 'Beginner',
      readMinutes: 6,
      season: 'July – September',
      sections: [
        GuideSection(
          heading: 'The Big Three: Blueberries, Salmonberries & Cranberries',
          body:
              'Wild blueberries ripen on low shrubs in alpine and subalpine areas from late July through August, often in the same areas you\'d hike for views. Salmonberries — bright orange to red, related to raspberries — ripen earlier, in July, in coastal and rainforest areas, especially Southeast and South-central. Low-bush cranberries (lingonberries) ripen last, often improving after the first frosts in September, and persist on the plant well into winter, making them a late-season or even snow-season harvest.',
        ),
        GuideSection(
          heading: 'Where and How to Pick',
          body:
              'South-facing slopes and recently burned or cleared areas often produce the heaviest blueberry crops, since the shrubs thrive with more sun. A berry rake can speed up blueberry and cranberry picking dramatically but takes some practice to use without crushing too much fruit or stripping leaves. Always pick with an eye on bears — berry patches are prime bear feeding grounds in late summer, and making noise while you pick is as important here as anywhere else.',
        ),
        GuideSection(
          heading: 'Storage and Simple Uses',
          body:
              'Most wild berries freeze well with no preparation beyond a rinse and a spread on a tray to freeze individually before bagging, which keeps them from clumping. Salmonberries are best used quickly — fresh, in jam, or baked — as they don\'t hold up to freezing as well as blueberries or cranberries. A basic jam (berries, sugar, a little lemon juice, cooked down) is the most forgiving way to preserve a big haul.',
        ),
      ],
      proTips: [
        'Pick into a container with a lid you can close one-handed — you\'ll want a free hand for trekking poles or bear spray.',
        'Cranberries left on the plant after frost are often sweeter than berries picked earlier in the season.',
        'A berry-stained map of "your" patches is worth keeping — good patches reliably produce year after year.',
      ],
      safetyNote:
          'Learn to identify and avoid baneberry (white or red berries on a single stalk with a black "eye," highly toxic) and water hemlock (a deadly plant sometimes found near berry patches in wet areas) — when in doubt, don\'t pick or eat an unfamiliar plant.',
    ),
    Guide(
      id: 'harvest-mushrooms',
      title: 'Foraging Wild Mushrooms Safely',
      category: 'Harvesting',
      emoji: '🍄',
      summary:
          'Alaska\'s forests produce excellent edible mushrooms — and a few that can kill you. Caution and a field guide are non-negotiable.',
      difficulty: 'Advanced',
      readMinutes: 7,
      season: 'July – September',
      sections: [
        GuideSection(
          heading: 'Why Caution Comes First',
          body:
              'Mushroom identification is unforgiving — some edible species have toxic look-alikes, and a mistake can mean serious illness or death with no antidote for some toxins. Never eat a wild mushroom based on a single feature or a photo match alone; confirm with multiple field marks (spore print, gill attachment, habitat, smell) and ideally a second opinion from an experienced forager before your first bite of any new species.',
        ),
        GuideSection(
          heading: 'King Boletes, Hedgehogs & Chanterelles',
          body:
              'King boletes (porcini) grow in association with spruce and birch and are prized for their rich, nutty flavor — look for a thick stem, a cap that doesn\'t bruise blue, and a sponge-like pore surface rather than gills underneath. Hedgehog mushrooms have a distinctive toothed underside instead of gills or pores, making them relatively easy to confirm and very few dangerous look-alikes exist. Chanterelles, golden and trumpet-shaped with shallow false gills, are common in Southeast\'s rainforests and have a fruity aroma that\'s a useful identification clue.',
        ),
        GuideSection(
          heading: 'Morels After Fire',
          body:
              'Morels — honeycomb-capped mushrooms — often fruit prolifically in the first year or two after a wildfire, drawing foragers to recent burn areas in the Interior. They have a few toxic look-alikes (false morels), so confirm the hollow interior and true honeycomb cap structure rather than relying on shape alone from a distance.',
        ),
        GuideSection(
          heading: 'Processing and Preservation',
          body:
              'Most wild mushrooms benefit from a quick brush-clean (avoid soaking, which makes them waterlogged) and cooking thoroughly — many wild mushrooms are mildly toxic raw or undercooked even if fine when cooked properly. Drying is the most common preservation method for boletes and morels, concentrating their flavor; a dehydrator or even a warm, airy spot works. Sautéing in butter and freezing the cooked mushrooms also preserves chanterelles and hedgehogs well.',
        ),
      ],
      proTips: [
        'Carry mushrooms in a basket or paper bag, not a plastic bag — plastic accelerates spoilage and can hide spores you\'d want to drop for the next patch.',
        'Photograph the whole mushroom, including the base and underside, before picking — it helps with identification later.',
        'Join a local mycological society or guided foray before foraging alone — learning in person from experienced foragers is invaluable.',
      ],
      safetyNote:
          'Never eat a wild mushroom you cannot identify with full confidence. Some Amanita species (including Amanita muscaria, the red-and-white "toadstool" common in Alaska) and several other genera contain toxins that can cause organ failure or death, sometimes with symptoms delayed by a day or more.',
    ),
    Guide(
      id: 'harvest-wild-plants',
      title: 'Wild Greens, Teas & Spring Harvest',
      category: 'Harvesting',
      emoji: '🌿',
      summary:
          'Fiddleheads, fireweed, and wild teas — the edible plants that mark the start of an Alaska spring and summer.',
      difficulty: 'Intermediate',
      readMinutes: 6,
      season: 'April – August',
      sections: [
        GuideSection(
          heading: 'Spring Greens: Fiddleheads & Beach Greens',
          body:
              'Fiddleheads — the tightly coiled young fronds of certain ferns — are one of the first wild edibles of spring, harvested while still curled before they unfurl. Only ostrich fern fiddleheads are widely considered safe and palatable; other fern species can be bitter or carry stomach-upsetting compounds, so positive identification matters. Along the coast, beach greens like goosetongue and beach lovage grow in tidal meadows and add a salty, herbal note to salads, though they should be harvested away from areas with pollution or heavy waterfowl traffic.',
        ),
        GuideSection(
          heading: 'Fireweed: Shoots to Flowers',
          body:
              'Fireweed, the tall pink-flowered plant that carpets roadsides and burned areas all summer, is edible at every stage in a different way. Young spring shoots can be harvested and cooked like asparagus while still tender. Later, the leaves make a fermented or dried tea, and the flowers themselves are often used to make jelly or infused into honey and syrup. Fireweed blooming from the bottom to the top of its stalk is also a traditional informal marker of how much summer remains.',
        ),
        GuideSection(
          heading: 'Wild Teas: Labrador Tea, Chaga & Devil\'s Club',
          body:
              'Labrador tea, a low evergreen shrub common in muskeg and tundra, has aromatic leaves traditionally steeped for tea — but should be used in moderation and identified carefully, as it contains compounds that can cause issues in large quantities. Chaga, a dark, charcoal-like fungus that grows on birch trees, is harvested year-round (often easiest to spot in winter against snow) and simmered for a long time to make an earthy tea valued in many northern cultures. Devil\'s club root bark has a long history of traditional medicinal use, but the plant\'s spines make harvesting hazardous and it\'s best learned from someone experienced.',
        ),
      ],
      proTips: [
        'Harvest fiddleheads while tightly coiled and unfurl-test a few at home — uncurled fronds are past their prime.',
        'Fireweed shoots are best picked when under about 6 inches tall and still tender enough to snap easily.',
        'Always harvest greens away from roadsides and areas treated with herbicides.',
      ],
    ),
    Guide(
      id: 'harvest-subsistence',
      title: 'Subsistence Hunting: GMUs, Permits & Field Care',
      category: 'Harvesting',
      emoji: '🦌',
      summary:
          'The regulatory basics every hunter needs before heading into Alaska\'s Game Management Units.',
      difficulty: 'Intermediate',
      readMinutes: 7,
      season: 'August – November (varies by species and unit)',
      sections: [
        GuideSection(
          heading: 'Game Management Units (GMUs)',
          body:
              'Alaska is divided into Game Management Units (GMUs), numbered zones that each have their own seasons, bag limits, and sometimes permit requirements for the same species. A regulation that applies in GMU 14 may not apply a few miles away in GMU 13 — always confirm which unit (and often subunit, like 13A vs 13E) you\'ll actually be hunting in, since boundaries often follow rivers, ridgelines, or roads rather than anything obvious on the ground.',
        ),
        GuideSection(
          heading: 'Permit Types: General Season, Draw, Registration & Tier II',
          body:
              'General season hunts require only a harvest ticket for many species and units. Draw permits are awarded through an annual lottery for limited-entry hunts, often for higher-demand areas or trophy species. Registration permits require signing up (sometimes in person or online) before hunting a specific hunt, often with quotas that close the season early once met. Tier II permits are reserved for subsistence hunters who can demonstrate a customary and direct dependence on the resource, used in areas where populations can\'t support general hunting.',
        ),
        GuideSection(
          heading: 'Proxy Hunting',
          body:
              'Proxy hunting allows a designated hunter to take an animal on behalf of someone who is unable to hunt themselves — typically due to age, disability, or active military service — under specific permit conditions set by the Alaska Department of Fish and Game (ADF&G). Both the proxy hunter and the permit holder must meet eligibility requirements, and the harvested animal legally belongs to the permit holder, not the proxy. Rules vary by unit and species, so check current ADF&G guidance before relying on this option.',
        ),
        GuideSection(
          heading: 'Field Care & Wanton Waste',
          body:
              'Alaska law requires salvaging the edible meat of big game animals — failing to do so is "wanton waste," a serious offense. This means field-dressing promptly, cooling meat quickly (quartering and hanging in shade or a breeze), and packing out all edible portions as defined by regulation for that species, which often includes meat from the ribs, neck, and other areas hunters sometimes skip. Plan your trip around the reality that a successful hunt means substantially more pack weight on the way out — many hunts fail not from lack of game but from being unprepared to move it.',
        ),
      ],
      proTips: [
        'Download the current ADF&G hunting regulations for your specific GMU before every season — rules change year to year.',
        'Register harvest tickets and report hunts promptly; many permits require harvest reports even if you didn\'t fill the tag.',
        'Carry a saw and extra bags — field care for a moose or caribou takes far more gear than most first-timers pack.',
      ],
    ),
  ];
}
