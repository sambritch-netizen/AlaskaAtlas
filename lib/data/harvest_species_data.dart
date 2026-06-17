import '../models/species.dart';

/// Alaska wild harvest field guide — used by the Guides "Berries",
/// "Mushrooms & Foraging", and "Other Wild Edibles" sub-categories.
class HarvestSpeciesData {
  HarvestSpeciesData._();

  static const List<Species> all = [
    // ===================== BERRIES =====================
    Species(
      id: 'wild-blueberry',
      name: 'Wild Blueberry (Alaska Blueberry)',
      scientificName: 'Vaccinium uliginosum / V. alaskaense',
      emoji: '🫐',
      subcategory: 'Berries',
      overview:
          'The wild blueberry is Alaska\'s most beloved and widely harvested '
          'berry, prized for its sweet, tangy flavor in pies, jams, and pancakes. '
          'Two closely related species — bog blueberry and Alaska blueberry — '
          'are both gathered and used interchangeably across the state.',
      habitat:
          'Found from sea level to alpine tundra throughout Alaska, including '
          'muskeg bogs, open spruce forests, and subalpine slopes from the '
          'Kenai Peninsula to the Brooks Range.',
      size: 'Shrub 6 inches to 2 ft tall, berries 1/4-1/2 inch across',
      season: 'Late July through September, peaking in August',
      facts: [
        'Bushes can carpet entire alpine slopes, turning hillsides blue during peak season.',
        'Berries develop a powdery white "bloom" that helps protect them from sun and dehydration.',
        'Alaska Native peoples have dried and stored blueberries for winter for thousands of years.',
        'Bears rely heavily on blueberries in late summer, so harvesters should make noise and stay alert.',
      ],
      tips:
          'Look for low shrubs with small, oval, slightly leathery leaves and dusty blue-purple berries '
          'growing singly or in small clusters along the stem. The easiest method is to spread a tarp '
          'beneath larger bushes and use a berry rake to comb through the foliage, then winnow out leaves '
          'and twigs by pouring the harvest between containers in a light breeze. Berries are sweetest '
          'after a few cool nights, and they freeze well for year-round use.',
      baits: [],
    ),
    Species(
      id: 'salmonberry',
      name: 'Salmonberry',
      scientificName: 'Rubus spectabilis',
      emoji: '🍇',
      subcategory: 'Berries',
      overview:
          'Salmonberries are large, raspberry-like fruits ranging from golden-orange to deep red, '
          'common in the rainforests of Southeast and South-central Alaska. They are eaten fresh, '
          'made into jams, or mixed with other berries and fat in traditional akutaq.',
      habitat:
          'Thrives in moist, shaded understory along stream banks, forest edges, and clearings '
          'throughout coastal Southeast Alaska, Prince William Sound, and the Kenai Peninsula.',
      size: 'Shrub 3-10 ft tall, berries 3/4-1 inch, raspberry-shaped',
      season: 'Late May through July, earliest of the major berry crops',
      facts: [
        'Color varies from pale yellow to bright red on the same bush, but ripeness is judged by softness, not color.',
        'The young spring shoots can also be peeled and eaten raw, with a flavor similar to cucumber.',
        'Salmonberry got its name because it was traditionally eaten alongside salmon roe.',
        'The bushes have distinctive maple-like, three-lobed leaves and thornless or lightly thorny stems.',
      ],
      tips:
          'Look for tall, cane-like shrubs with thin, peeling bark and bright pink-purple flowers in spring '
          'followed by raspberry-shaped fruit. Ripe berries detach easily from their core with a gentle tug — '
          'if it resists, it needs more time. Harvest into shallow containers since the soft berries crush '
          'easily, and use them quickly or freeze them as they spoil faster than firmer berries.',
      baits: [],
    ),
    Species(
      id: 'lowbush-cranberry',
      name: 'Lowbush Cranberry (Lingonberry)',
      scientificName: 'Vaccinium vitis-idaea',
      emoji: '🔴',
      subcategory: 'Berries',
      overview:
          'Also called lingonberry or "lowbush cranberry," this tart red berry is one of the most '
          'durable wild fruits in Alaska, often persisting under snow and remaining edible into spring. '
          'It is a staple for sauces, jellies, and traditional sourdough or akutaq recipes.',
      habitat:
          'Grows in dry to moderately moist tundra, muskeg, and open coniferous forest across nearly '
          'all of Alaska, from coastal lowlands to alpine ridges.',
      size: 'Low evergreen shrub 2-8 inches tall, berries 1/4-3/8 inch',
      season: 'September through October, and again after snowmelt in spring',
      facts: [
        'Berries that overwinter under snow become softer and sweeter, a treat for early spring foragers.',
        'The small, glossy, evergreen leaves stay green all winter, making the plant easy to spot in any season.',
        'High in vitamin C and natural benzoic acid, which acts as a preservative.',
        'A close relative of the commercial cranberry, but the plant is much smaller and the berries grow on low, woody mats.',
      ],
      tips:
          'Search for dense, low mats of small, round, dark-green leathery leaves with bright red berries '
          'nestled close to the ground, often among reindeer lichen and crowberry. Pick by hand or with a '
          'small comb rake, since the plants hug the ground too closely for standard berry rakes. The tart '
          'berries mellow with cooking and pair well with sugar for jam or as a sauce for game meats.',
      baits: [],
    ),
    Species(
      id: 'wild-raspberry',
      name: 'Wild Raspberry',
      scientificName: 'Rubus idaeus',
      emoji: '🍓',
      subcategory: 'Berries',
      overview:
          'Wild raspberries grow in scattered patches across Alaska\'s interior and coastal regions, '
          'offering the same sweet-tart flavor as cultivated raspberries but in smaller, more intense '
          'fruit. They are excellent fresh, in jams, or baked into desserts.',
      habitat:
          'Found along sunny roadsides, riverbanks, clearings, and burned or disturbed areas, especially '
          'in interior Alaska and the Matanuska-Susitna Valley.',
      size: 'Cane shrub 2-5 ft tall, berries 1/2-3/4 inch',
      season: 'Late July through August',
      facts: [
        'The canes are covered in fine prickles, so long sleeves help during harvest.',
        'Raspberries separate from a central core when ripe, leaving a hollow, thimble-shaped berry.',
        'Wild patches often spread along disturbed ground such as old trails, gravel pits, and burn areas.',
        'Leaves can be dried and brewed into a mild herbal tea.',
      ],
      tips:
          'Look for upright, prickly canes with compound leaves of three to five toothed leaflets and '
          'clusters of red, thimble-shaped berries. Gently pull ripe berries — they should slide off the '
          'white core easily, leaving a hollow center; if it doesn\'t release, let it ripen longer. Pick '
          'into shallow containers to avoid crushing, and check the patch every few days since ripening '
          'happens quickly in warm weather.',
      baits: [],
    ),
    Species(
      id: 'crowberry',
      name: 'Crowberry',
      scientificName: 'Empetrum nigrum',
      emoji: '⚫',
      subcategory: 'Berries',
      overview:
          'Crowberry, also called "blackberry" by some Alaskans, produces small black berries on low, '
          'heather-like evergreen mats across tundra and muskeg. Though somewhat bland alone, it is '
          'commonly mixed with sweeter berries in akutaq and jams to extend the harvest.',
      habitat:
          'Widespread on open tundra, alpine ridges, bogs, and rocky barrens throughout Alaska, including '
          'the Arctic coastal plain and high alpine zones.',
      size: 'Mat-forming evergreen shrub 2-6 inches tall, berries 1/4 inch',
      season: 'August through September, persisting into winter',
      facts: [
        'The needle-like evergreen leaves resemble miniature spruce or juniper foliage.',
        'Berries often persist on the plant through winter and can be harvested from beneath the snow.',
        'Crowberry mats provide important ground cover and food for ptarmigan and other tundra birds.',
        'The juice can stain hands and clothing a deep purple-black.',
      ],
      tips:
          'Identify crowberry by its dense, wiry mats of tiny, dark-green needle-like leaves studded with '
          'shiny black berries that sit directly against the stem. The berries have a mild, slightly resinous '
          'flavor on their own, so most foragers mix them with blueberries or cranberries for better taste. '
          'Pick by hand, rolling berries off the low mats into a container, and rinse well before use.',
      baits: [],
    ),
    Species(
      id: 'cloudberry',
      name: 'Cloudberry (Nagoonberry)',
      scientificName: 'Rubus chamaemorus',
      emoji: '🟠',
      subcategory: 'Berries',
      overview:
          'Cloudberry, known locally as "low-bush salmonberry" or nagoonberry-adjacent in some regions, '
          'is a prized amber-colored tundra berry with a rich, tart-sweet flavor often compared to baked '
          'apples. It is a highly sought-after delicacy used in jams, sauces, and traditional desserts.',
      habitat:
          'Grows in wet, acidic tundra, bogs, and muskeg across much of Alaska, particularly in the '
          'Arctic, Western Alaska, and Southcentral wetlands.',
      size: 'Low herbaceous plant 4-10 inches tall, berries 1/2-3/4 inch',
      season: 'Late July through August',
      facts: [
        'Unripe cloudberries are firm and red; they turn soft, pale amber, and translucent when fully ripe.',
        'Each plant produces only a single berry on a single stem, making harvest slow but rewarding.',
        'Cloudberries are sometimes called "the gold of the marshes" for their color and value.',
        'They are exceptionally high in vitamin C, historically valued by sailors and Arctic travelers.',
      ],
      tips:
          'Search wet, mossy tundra and bog mats for low plants with maple-like, lobed leaves bearing a '
          'single berry per stem — ripe ones are soft, pale orange-amber, and slightly translucent, while '
          'red, firm berries are not yet ready. Pick gently by hand since ripe berries bruise and squash '
          'easily, and place them in a rigid container in a single layer to avoid crushing. Because patches '
          'are scattered and yields per plant are low, plan for a slow, patient harvest across a wide area.',
      baits: [],
    ),

    // ===================== MUSHROOMS & FORAGING =====================
    Species(
      id: 'chanterelle',
      name: 'Chanterelle',
      scientificName: 'Cantharellus formosus',
      emoji: '🍄',
      subcategory: 'Mushrooms & Foraging',
      overview:
          'The golden chanterelle is one of Alaska\'s most prized edible mushrooms, valued for its '
          'fruity aroma, firm texture, and rich flavor that holds up well in sautés and sauces. It is '
          'a favorite among foragers in the coastal rainforests of Southeast Alaska.',
      habitat:
          'Found on the forest floor under mature spruce and hemlock in the moist coastal forests of '
          'Southeast Alaska, Prince William Sound, and parts of the Kenai Peninsula.',
      size: 'Cap 1-4 inches across, stem 1-3 inches tall',
      season: 'Late summer through fall, August to October',
      facts: [
        'True chanterelles have shallow, blunt false gills (ridges) that run down the stem, unlike true gills.',
        'They emit a distinct fruity, apricot-like smell when fresh.',
        'Chanterelles often grow in the same spots year after year, so foragers remember productive patches.',
        'The flesh is solid and white to pale yellow inside, without hollow chambers.',
      ],
      tips:
          'Look for funnel- or trumpet-shaped, golden-orange to yellow mushrooms with wavy cap edges and '
          'blunt, vein-like false gills that run continuously down into the stem. Cut at the base with a '
          'knife rather than pulling to keep the mycelium intact for future growth, and brush off debris '
          'in the field. Always slice specimens in half lengthwise to confirm solid white flesh with no '
          'hollow stem before cooking.',
      baits: [],
      caution:
          'The Jack-o\'-lantern mushroom (Omphalotus species) is a toxic lookalike with a similar orange '
          'color, but it has true, sharp-edged gills (not blunt false ridges), grows in clusters on wood '
          'or buried roots rather than singly on soil, and lacks the fruity chanterelle aroma. When in '
          'doubt, slice the mushroom lengthwise and examine the gill structure closely, or have a '
          'knowledgeable forager confirm the ID before eating.',
    ),
    Species(
      id: 'king-bolete',
      name: 'King Bolete (Porcini)',
      scientificName: 'Boletus edulis',
      emoji: '🍄‍🟫',
      subcategory: 'Mushrooms & Foraging',
      overview:
          'The king bolete, or porcini, is a large, meaty mushroom with a rich nutty flavor highly '
          'prized for drying, sautéing, and use in soups and risottos. It is one of the most sought-after '
          'wild mushrooms in interior and Southcentral Alaska.',
      habitat:
          'Grows in association with spruce and birch roots in mixed boreal forests of interior Alaska, '
          'the Mat-Su Valley, and coastal spruce forests near beaches and dunes.',
      size: 'Cap 3-10 inches across, stem thick and bulbous, 2-6 inches tall',
      season: 'Late July through September, often after rain',
      facts: [
        'The cap has a smooth, sticky brown surface resembling a hamburger bun.',
        'Underneath the cap is a sponge-like layer of fine pores rather than gills.',
        'A thick, bulbous white to tan stem with fine netting (reticulation) is a key identifying feature.',
        'Porcini are often found growing partly buried, so look for slight mounds in the moss or duff.',
      ],
      tips:
          'Look for a smooth brown cap atop a thick, club-shaped white to brown stem covered in a fine '
          'net-like pattern, with a spongy layer of tiny pores (not gills) under the cap. Cut the mushroom '
          'lengthwise in the field — the flesh should be firm and white, turning at most slightly pink or '
          'brown, never blue. Slice and dry larger specimens for long-term storage, as drying intensifies '
          'their nutty flavor.',
      baits: [],
      caution:
          'Several Boletus species are poisonous lookalikes, particularly bitter boletes and species with '
          'red or orange pore surfaces and stem netting. Avoid any bolete whose flesh stains blue quickly '
          'when cut, whose pore surface is red or orange rather than white, cream, or yellow, or whose taste '
          'is intensely bitter (test a tiny piece raw and spit it out — true porcini is mild). If the cut '
          'flesh bruises blue or the pores are reddish, do not eat it.',
    ),
    Species(
      id: 'morel',
      name: 'Morel',
      scientificName: 'Morchella species',
      emoji: '🍄',
      subcategory: 'Mushrooms & Foraging',
      overview:
          'Morels are highly prized spring mushrooms with a distinctive honeycomb-textured cap, sought '
          'after for their meaty, savory flavor in sautés and sauces. In Alaska they are most abundant '
          'the year or two following a forest fire, drawing dedicated "morel hunters" to recent burns.',
      habitat:
          'Found in burned spruce and birch forests of interior Alaska one to three years after wildfire, '
          'as well as occasionally in river floodplains and disturbed soil.',
      size: 'Cap 1-4 inches tall, stem 1-3 inches, entire mushroom 2-6 inches',
      season: 'Late May through June, shortly after snowmelt',
      facts: [
        'Morel populations can explode in burned areas, with some Alaska burns producing massive flushes the following spring.',
        'The cap and stem are both hollow when sliced lengthwise — a critical identification feature.',
        'The honeycomb pattern of pits and ridges is fused to the stem at its base, not hanging free.',
        'Morels must always be cooked before eating; they are mildly toxic raw.',
      ],
      tips:
          'Search burned forest floors the spring after a fire for cone- or egg-shaped mushrooms with a '
          'pitted, honeycomb-textured cap that is attached to the stem along its entire margin (no hanging '
          'skirt or free edge). Cut every specimen in half lengthwise in the field to confirm it is '
          'completely hollow from cap to stem base. Always cook morels thoroughly before eating, and start '
          'with a small portion the first time, as some people have sensitivities even to properly cooked morels.',
      baits: [],
      caution:
          'False morels (Gyromitra species) are dangerous lookalikes that contain gyromitrin, a toxin that '
          'can cause severe illness and, in some cases, be fatal. True morels are completely hollow inside '
          'with a cap fully fused to the stem and a regular pitted honeycomb pattern, while false morels have '
          'a wavy, brain-like or saddle-shaped cap that is only partially attached to the stem and is not '
          'truly hollow (often cottony or chambered inside). Always slice lengthwise to verify the cap is '
          'completely hollow and fully attached before eating.',
    ),
    Species(
      id: 'shaggy-mane',
      name: 'Shaggy Mane',
      scientificName: 'Coprinus comatus',
      emoji: '🍄',
      subcategory: 'Mushrooms & Foraging',
      overview:
          'Shaggy mane is a distinctive, tall, shaggy white mushroom that grows quickly in disturbed '
          'ground and grassy areas around Alaska towns and roadsides. It has a delicate flavor when young '
          'but must be harvested and eaten promptly before it self-digests into black ink.',
      habitat:
          'Common in lawns, gravel roadsides, disturbed soil, and grassy clearings near towns and '
          'communities throughout Southcentral and interior Alaska.',
      size: 'Cap cylindrical, 2-4 inches tall, whole mushroom up to 6 inches',
      season: 'Late summer through fall, especially after rain',
      facts: [
        'The cap starts as a tight white cylinder covered in shaggy, upturned scales, resembling a fuzzy egg or drumstick.',
        'As it matures, the cap edges turn pink, then black, and liquefy into an inky black fluid within hours to a day.',
        'This self-digesting process, called "deliquescence," is how the mushroom disperses its spores.',
        'Shaggy manes often appear in troops, popping up quickly overnight after rain.',
      ],
      tips:
          'Harvest shaggy manes while the cap is still pure white and tightly closed, before any pink or '
          'black coloring appears at the cap edges — this can happen within hours, so check patches daily '
          'during fruiting. Cut or twist at the base and cook the same day, since the mushroom continues to '
          'deliquesce (turn to black ink) even after picking. Avoid mushrooms that already show dark, '
          'inky edges, as the texture and flavor decline rapidly once this begins.',
      baits: [],
      caution:
          'Shaggy mane is generally safe, but it is closely related to common ink cap (Coprinopsis '
          'atramentaria), which contains coprine — a compound that causes a severe reaction (flushing, '
          'nausea, rapid heartbeat) if alcohol is consumed within a day or two of eating it. To be safe, '
          'avoid alcohol for at least 24-48 hours before and after eating any ink cap species, and only '
          'harvest shaggy manes that are pure white with no blackening, as deliquescing specimens are '
          'unpalatable and harder to identify with confidence.',
    ),
    Species(
      id: 'puffball',
      name: 'Puffball',
      scientificName: 'Lycoperdon / Calvatia species',
      emoji: '🍄',
      subcategory: 'Mushrooms & Foraging',
      overview:
          'Puffballs are round, ball-shaped fungi that range from golf-ball to soccer-ball size, prized '
          'for their mild flavor and firm texture when sliced and fried like tofu. They appear in fields, '
          'forests, and lawns across Alaska in late summer and fall.',
      habitat:
          'Found in grassy meadows, forest edges, lawns, and open woodland throughout Southcentral and '
          'interior Alaska, often in groups or "fairy rings."',
      size: 'Ranges from 1 inch (small species) to over 12 inches (giant puffball)',
      season: 'Late summer through fall, August to October',
      facts: [
        'Giant puffballs can grow larger than a basketball and weigh several pounds.',
        'Edible puffballs are solid white throughout when cut open, with no visible internal structures.',
        'As puffballs age, the inside turns yellow, then olive-brown, and finally becomes a mass of dry spores released as a "puff" of dust.',
        'Only pure-white, solid-fleshed specimens should be eaten — any other coloring means it is too old or not a puffball at all.',
      ],
      tips:
          'Look for smooth, round, white to tan fungi with no visible stem, cap, or gills, growing on soil '
          'or grass. The single most important step is to cut every specimen in half from top to bottom: '
          'edible puffballs are uniformly white and solid like marshmallow or fresh mozzarella all the way '
          'through, with no shapes, gills, or developing "mushroom" visible inside. Slice and pan-fry fresh, '
          'firm specimens promptly, as puffballs decline quickly once cut.',
      baits: [],
      caution:
          'The most dangerous lookalike is an immature "egg" stage of an Amanita mushroom (including the '
          'deadly destroying angel), which can also appear as a white ball before it opens. This is why '
          'every puffball MUST be cut in half vertically before eating: an Amanita egg will show the faint '
          'outline of a developing cap, gills, and stem inside, sometimes with a colored interior, while a '
          'true puffball is completely uniform white throughout with no internal structure whatsoever. '
          'Never eat a "puffball" that shows any internal shapes, layers, or coloring when sliced open.',
    ),

    // ===================== OTHER WILD EDIBLES =====================
    Species(
      id: 'fiddlehead-fern',
      name: 'Fiddlehead Ferns (Ostrich Fern)',
      scientificName: 'Matteuccia struthiopteris',
      emoji: '🌿',
      subcategory: 'Other Wild Edibles',
      overview:
          'Fiddleheads are the tightly coiled young fronds of the ostrich fern, harvested in early '
          'spring for a brief window before they unfurl. They have a fresh, slightly nutty, asparagus-like '
          'flavor and are a popular seasonal vegetable sautéed or pickled.',
      habitat:
          'Grows in moist floodplain forests, riverbanks, and shaded alluvial soils, particularly common '
          'in interior and Southcentral Alaska river valleys.',
      size: 'Mature fronds 3-5 ft tall; fiddleheads harvested at 1-3 inches coiled',
      season: 'Early to mid-May, a short 1-2 week window depending on spring warmth',
      facts: [
        'The name "fiddlehead" comes from the tight spiral shape resembling the scroll of a violin.',
        'Ostrich fern fiddleheads have a smooth, papery brown covering and a deep groove on the inner side of the stem.',
        'Only a few fiddleheads should be taken per plant so the fern can continue to grow and reproduce.',
        'Fiddleheads must be cooked thoroughly — boiling or steaming for several minutes — before eating.',
      ],
      tips:
          'Harvest only tightly coiled, unopened fronds covered in a papery brown husk, identifiable by a '
          'deep U-shaped groove running down the inner face of the stem (a key feature distinguishing ostrich '
          'fern from other ferns). Snap or cut fiddleheads close to the ground, rub off the brown husk and '
          'rinse well, then boil or steam for at least 10-15 minutes before sautéing — this destroys natural '
          'toxins that can otherwise cause gastrointestinal upset.',
      baits: [],
    ),
    Species(
      id: 'wild-rhubarb-sourdock',
      name: 'Wild Rhubarb (Sourdock)',
      scientificName: 'Rumex arcticus',
      emoji: '🌱',
      subcategory: 'Other Wild Edibles',
      overview:
          'Sourdock, often called "wild rhubarb," is a tart, leafy plant whose stems and young leaves '
          'are used much like garden rhubarb in sauces, soups, and traditional Alaska Native dishes mixed '
          'with fish or berries.',
      habitat:
          'Common in moist meadows, riverbanks, tundra edges, and disturbed ground across much of Alaska, '
          'including the Arctic and Western coastal regions.',
      size: 'Plant 1-3 ft tall with broad arrow-shaped leaves up to 8 inches',
      season: 'Spring through early summer, May to June, before flowering',
      facts: [
        'The leaves and stems have a tart, lemony flavor due to oxalic acid, similar to garden rhubarb.',
        'Sourdock has been a traditional spring green for Alaska Native communities for generations, often the first fresh vegetable of the year.',
        'Older leaves become tougher and more bitter, so spring harvest of young growth is preferred.',
        'The plant produces tall flower stalks with reddish seed clusters later in summer.',
      ],
      tips:
          'Look for clumps of broad, oval to arrow-shaped leaves with wavy edges and reddish stems emerging '
          'in early spring from moist ground. Harvest young leaves and tender stalks before the plant '
          'flowers, when they are most tender and least bitter; older, tougher leaves can be cooked longer '
          'to soften. The tart flavor works well stewed with sugar like rhubarb, or mixed into soups and '
          'traditional dishes for acidity.',
      baits: [],
      caution:
          'Sourdock contains oxalic acid, like garden rhubarb, so it should be eaten in moderate amounts, '
          'and the leaves of true rhubarb-family plants (never the roots of unrelated toxic plants) should '
          'be used. Be careful not to confuse young sourdock with poisonous plants such as baneberry or '
          'monkshood that can grow in similar moist habitats — confirm the distinctive dock-family leaf '
          'shape and reddish stem before harvesting.',
    ),
    Species(
      id: 'beach-asparagus',
      name: 'Beach Asparagus (Sea Asparagus / Glasswort)',
      scientificName: 'Salicornia species',
      emoji: '🌊',
      subcategory: 'Other Wild Edibles',
      overview:
          'Beach asparagus, also called sea asparagus or glasswort, is a salty, crunchy succulent that '
          'grows along tidal flats. It is eaten raw, pickled, or lightly sautéed, prized for its briny, '
          'ocean flavor that pairs well with seafood.',
      habitat:
          'Grows in coastal salt marshes and tidal mudflats in Southcentral and Southeast Alaska, often '
          'in the zone regularly flooded by high tides.',
      size: 'Low, jointed succulent stems 4-12 inches tall',
      season: 'Summer, June through August',
      facts: [
        'The plant\'s segmented, finger-like stems resemble tiny green cacti or asparagus tips.',
        'Its natural salty flavor comes from growing in salt-saturated tidal soils.',
        'Beach asparagus turns reddish in late summer as it matures.',
        'It is related to plants historically burned for soda ash production, hence the name "glasswort."',
      ],
      tips:
          'Look for low clumps of bright green, jointed, fleshy stems without true leaves growing directly '
          'in salt marsh mud within reach of the tide. Snip the tender upper portions of the stems with '
          'scissors, leaving the woody base intact so the plant can regrow. Rinse thoroughly to remove mud '
          'and grit, then eat raw in salads, pickle, or quickly blanch and sauté — no added salt is needed '
          'given its naturally briny flavor.',
      baits: [],
    ),
    Species(
      id: 'spruce-tips',
      name: 'Spruce Tips',
      scientificName: 'Picea species (Sitka / White Spruce)',
      emoji: '🌲',
      subcategory: 'Other Wild Edibles',
      overview:
          'Spruce tips are the bright green, tender new growth that emerges from spruce branches each '
          'spring, prized for their citrusy, resinous flavor. They are used in syrups, jellies, teas, '
          'seasoning blends, and even brewing, and are a favorite seasonal foraging target across Alaska.',
      habitat:
          'Harvested from Sitka spruce in coastal Southeast and Southcentral Alaska, and white spruce '
          'across interior Alaska\'s boreal forest, wherever mature trees put out new spring growth.',
      size: 'New tip growth 1/2-2 inches long, soft and light green',
      season: 'Late May through June, when new growth is still soft and bright green',
      facts: [
        'New spruce tips are soft, pale green, and often covered in a thin papery brown husk that falls away as they grow.',
        'They contain high levels of vitamin C and were historically used to prevent scurvy.',
        'Spruce tip flavor is bright, citrusy, and resinous, often compared to a cross between pine and lemon.',
        'The harvest window is short — once the new growth hardens and darkens to mature needle color, the tender texture is lost.',
      ],
      tips:
          'In late spring, look for the bright lime-green new growth at the ends of spruce branches, '
          'still soft enough to pinch off easily with your fingers and often wrapped in a loose papery '
          'brown bud sheath. Harvest only a portion of the new tips from any one tree to avoid stressing '
          'it, especially on smaller trees. Use fresh tips immediately for syrups and teas, or freeze them '
          'whole for later use — they lose their bright flavor quickly once fully hardened into mature needles.',
      baits: [],
    ),
  ];
}
