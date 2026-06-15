import '../models/guide.dart';

/// Curated, Alaska-specific field guides. Every guide is written for
/// conditions, species, and terrain found in Alaska — nothing generic.
class GuidesData {
  GuidesData._();

  static const List<GuideCategory> categories = [
    GuideCategory(name: 'Camping', emoji: '⛺'),
    GuideCategory(name: 'Fishing', emoji: '🎣'),
    GuideCategory(name: 'Survival', emoji: '🧭'),
    GuideCategory(name: 'Wildlife', emoji: '🐻'),
    GuideCategory(name: 'Winter', emoji: '❄️'),
    GuideCategory(name: 'Hiking', emoji: '🥾'),
    GuideCategory(name: 'Highways', emoji: '🛣️'),
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

    // ── Winter ────────────────────────────────────────────────────────────
    Guide(
      id: 'winter-aurora',
      title: 'Hunting the Northern Lights',
      category: 'Winter',
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
      id: 'winter-layering',
      title: 'Layering for Deep Cold',
      category: 'Winter',
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
    // ── Highways ──────────────────────────────────────────────────────────
    Guide(
      id: 'hwy-denali',
      title: 'Denali Highway: Mile-by-Mile',
      category: 'Highways',
      emoji: '🛣️',
      summary:
          'Alaska\'s wildest road trip — 135 miles of mostly gravel from Cantwell to Paxson, through the heart of GMU 13\'s caribou and sheep country.',
      difficulty: 'Intermediate',
      readMinutes: 10,
      season: 'Mid-May – mid-September (gated/unmaintained in winter)',
      sections: [
        GuideSection(
          heading: 'Mile 0 – Cantwell (Parks Highway Junction)',
          body:
              'The western end, where the Denali Highway splits off the Parks Highway just south of Denali National Park. Last reliable fuel and groceries before MacLaren River Lodge, 43 miles out — top off here. Pavement runs for roughly the first 21 miles.',
        ),
        GuideSection(
          heading: 'Mile 13 – Brushkana Creek Campground',
          body:
              'A small BLM campground on Brushkana Creek — the only developed campground on the western half of the highway. Sites sit right along the creek with grayling fishing in reach. Good base for hunters working the GMU 13E drainages to the north.',
        ),
        GuideSection(
          heading: 'Mile 21 – Pavement Ends',
          body:
              'The road turns to maintained gravel here and stays that way for the rest of the route. Expect washboard, frost heaves, and dust in dry weather — ease off and give RVs room. Wide views of the Alaska Range open up to the north on clear days, with Denali visible from several pullouts over the next 20 miles.',
        ),
        GuideSection(
          heading: 'Mile 36 – Clearwater Creek',
          body:
              'A clearwater drainage crossing popular with grayling anglers and a common pull-off for glassing the hillsides above for caribou movement in late August and September.',
        ),
        GuideSection(
          heading: 'Mile 42 – Susitna River Bridge',
          body:
              'The road crosses the upper Susitna River here — still a small, clear headwaters stream this far from the coast, a world away from the silty giant it becomes near Talkeetna. Good landmark for orienting yourself on GMU 13 maps.',
        ),
        GuideSection(
          heading: 'Mile 43 – MacLaren River Lodge',
          body:
              'The only fuel, food, and lodging between Cantwell and Paxson. A working roadhouse that fills up fast during caribou season — call ahead if you\'re counting on a room or a fuel top-off. Treat it as your last-chance services westbound or first-chance eastbound.',
        ),
        GuideSection(
          heading: 'Mile 47 – MacLaren Summit',
          body:
              'At 4,086 feet, this is the highest point on the Alaska highway system and the gateway to the best alpine country on the route. Above treeline here on both sides — open tundra benches that hold caribou, and rocky basins above that hold Dall sheep. Pull-offs near the summit are popular glassing points; expect company during open seasons.',
        ),
        GuideSection(
          heading: 'Mile 55 – Tangle Lakes & Tangle River Inn',
          body:
              'A chain of clear lakes straddling the road, with the Tangle River Inn offering fuel, food, and a few rooms — the second (and last) services on the highway. This is also a put-in for the Delta National Wild and Scenic River canoe route, which threads through GMU 13 country popular with float hunters.',
        ),
        GuideSection(
          heading: 'Mile 65 – Tangle Lakes Archaeological District',
          body:
              'One of the densest concentrations of prehistoric sites in Alaska — thousands of years of seasonal hunting camps along these lake chains, which tells you everything about how good the game has always been here. Surface collection and digging are prohibited; respect closure signs in the district.',
        ),
        GuideSection(
          heading: 'Mile 79 – Swede Lake Area',
          body:
              'Rolling tundra and scattered lakes mark the transition toward the Richardson Highway side. Good country for spot-and-stalk caribou hunts when the Nelchina herd is moving through GMU 13 — glass from the road and plan your approach before committing to the walk; distances across open tundra are deceiving.',
        ),
        GuideSection(
          heading: 'Mile 85–110 – High Tundra & Sheep Country',
          body:
              'The longest stretch of true alpine tundra on the highway, with peaks of the eastern Alaska Range visible to the north. Sheep hunters use this section to access drainages on foot or with packraft support; caribou and moose are both present depending on season. No services for the next 25+ miles in either direction — carry extra fuel.',
        ),
        GuideSection(
          heading: 'Mile 135 – Paxson (Richardson Highway Junction)',
          body:
              'The eastern terminus, meeting the Richardson Highway roughly halfway between Glennallen and Delta Junction. Limited services historically (check current status before relying on Paxson Lodge). From here it\'s a straightforward run north to Delta Junction/Fairbanks or south to Glennallen and the Glenn Highway back to Anchorage.',
        ),
      ],
      proTips: [
        'Top off fuel at Cantwell AND MacLaren River Lodge — Tangle River Inn is your last backup, and all three can close or run out during peak season.',
        'Most of the route falls in GMU 13 (subunits B, D, and E) — confirm your specific subunit, drawing permit, and registration requirements before you go; boundaries follow drainages, not the road.',
        'The road is typically passable late May through October depending on snow — call ADOT&PF\'s road conditions line for current status before a spring or fall trip.',
        'Cell coverage is essentially nonexistent past Cantwell. A satellite communicator is standard kit out here, not a luxury.',
        'Pullouts near MacLaren Summit and the high tundra miles (85-110) fill up fast during caribou season — arrive early or plan to glass from less obvious spots a short walk off the road.',
      ],
      safetyNote:
          'This is a remote gravel road with two roadhouses in 135 miles and no cell service. Carry a full-size spare, extra fuel, and recovery gear — a breakdown here means a long wait, not a quick tow.',
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
  ];
}
