import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

import '../models/highway.dart';

/// The major named Alaska highways, in Milepost order of appearance — the
/// basis for a highway-by-highway walkthrough.
class HighwaysData {
  HighwaysData._();

  static const List<Highway> highways = [
    Highway(
      slug: 'seward-highway',
      name: 'Seward Highway',
      route: 'AK-1 / AK-9',
      color: Color(0xFFE53935),
      stops: [
        
        HighwayStop(
          mile: 23,
          name: 'Ptarmigan Creek Campground',
          emoji: '🏕️',
          lat: 60.4057,
          lng: -149.3634,
          description:
              'A 16-site Chugach National Forest campground tucked among spruce along Ptarmigan Creek, with a trailhead leading to Ptarmigan Lake. The creek and nearby Kenai Lake offer good bank fishing for Dolly Varden and salmon in season.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 29,
          name: 'Moose Pass',
          emoji: '⛽',
          lat: 60.4878,
          lng: -149.3708,
          description:
              'A small community on the shore of Trail Lake, founded during the early 1900s gold rush era. Known for its summer Solstice Festival and the historic Estes Brothers grocery, it makes a good fuel and snack stop between Seward and Tern Lake.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 37,
          name: 'Tern Lake Junction',
          emoji: '🔀',
          lat: 60.5408,
          lng: -149.5797,
          description:
              'Junction with the Sterling Highway, which heads west toward Cooper Landing, Soldotna, and Homer. Tern Lake itself is a Chugach National Forest day-use area with picnic sites, a fish-viewing platform, and interpretive panels on the surrounding wetlands.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 46,
          name: 'Summit Lake',
          emoji: '⛰️',
          lat: 60.6275,
          lng: -149.6917,
          description:
              'A scenic alpine lake straddling the highway near the Seward Highway\'s high point through the Kenai Mountains. Summit Lake Lodge offers food and lodging, and the surrounding ridges are good places to scan for Dall sheep grazing on the slopes above.',
          category: HighwayStopCategories.scenic,
        ),
        
        HighwayStop(
          mile: 63,
          name: 'Granite Creek Campground',
          emoji: '🏕️',
          lat: 60.7944,
          lng: -149.3489,
          description:
              'A quiet Chugach National Forest campground along Granite Creek near the base of Turnagain Pass, with sites set among cottonwood and spruce. A good base for exploring nearby trails before tackling the climb over the pass toward Anchorage.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 68,
          name: 'Turnagain Pass',
          emoji: '⛰️',
          lat: 60.7711,
          lng: -149.2900,
          description:
              'The highest point on the Seward Highway, with large parking areas on both sides of the road amid open alpine terrain. In winter it is one of Alaska\'s most popular destinations for snowmachining and backcountry skiing; in summer the slopes are carpeted with wildflowers and offer easy off-trail hiking.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 90,
          name: 'Girdwood / Alyeska Junction',
          emoji: '⛽',
          lat: 60.9392,
          lng: -149.1550,
          description:
              'Junction with the Alyeska Highway, leading three miles into the Girdwood valley and Alyeska Resort, Alaska\'s largest ski area with year-round aerial tramway rides. The junction area has gas, food, and lodging, the last full services before Anchorage for southbound travelers.',
          category: HighwayStopCategories.fuel,
        ),
        
        HighwayStop(
          mile: 111,
          name: 'Beluga Point',
          emoji: '🦌',
          lat: 61.0053,
          lng: -149.6942,
          description:
              'A rocky overlook on Turnagain Arm with paved parking, interpretive panels, and coin-operated spotting scopes. Named for the beluga whales sometimes seen chasing salmon up the Arm from mid-July through August; the site was also used historically by Dena\'ina people to spot game.',
          category: HighwayStopCategories.scenic,
        ),
        
      ],
    ),
    Highway(
      slug: 'glenn-highway',
      name: 'Glenn Highway',
      route: 'AK-1',
      color: Color(0xFFFB8C00),
      stops: [
        
        HighwayStop(
          mile: 13,
          name: 'Eagle River',
          emoji: '⛽',
          lat: 61.3257,
          lng: -149.5675,
          description:
              'A bedroom community of Anchorage tucked against the Chugach Mountains, with full services including gas, groceries, and lodging. The Eagle River Nature Center, up Eagle River Road, offers trails and salmon-viewing platforms in season.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 24,
          name: 'Thunderbird Falls',
          emoji: '⛰️',
          lat: 61.4319,
          lng: -149.3953,
          description:
              'A short, well-graded trail near Eklutna leads about one mile to a viewing platform overlooking a multi-tiered waterfall on the Eklutna River. A popular family stop and one of the easiest scenic hikes near Anchorage.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 26,
          name: 'Eklutna Lake Road',
          emoji: '🏕️',
          lat: 61.4536,
          lng: -149.3608,
          description:
              'Exit for Eklutna Lake, the largest lake in Chugach State Park, with a campground, lakeside trails, and access to the Eklutna Glacier farther up the valley. Eklutna Historical Park, with its colorful Athabascan spirit houses, is also reached from this exit.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 42,
          name: 'Palmer (Parks Hwy Junction)',
          emoji: '🔀',
          lat: 61.5994,
          lng: -149.1128,
          description:
              'Heart of the Matanuska Valley farming region and home of the Alaska State Fair every August. Palmer offers full services and connects south via the Glenn Highway spur to the George Parks Highway toward Wasilla and Denali.',
          category: HighwayStopCategories.fuel,
        ),
        
        HighwayStop(
          mile: 76,
          name: 'King Mountain State Recreation Site',
          emoji: '🏕️',
          lat: 61.7744,
          lng: -148.4947,
          description:
              'A quiet campground on the Matanuska River at the base of 5,460-foot King Mountain, with sites tucked among cottonwoods. The river braids and gravel bars here offer good views of the surrounding Chugach peaks.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 101,
          name: 'Matanuska Glacier Viewpoint',
          emoji: '⛰️',
          lat: 61.7833,
          lng: -147.7167,
          description:
              'One of the most accessible glaciers in Alaska, the Matanuska Glacier spills nearly 27 miles down from the Chugach Mountains and is visible from numerous highway pullouts. The adjacent state recreation site offers camping and a closer view of the glacier face, with guided walks available from private operators on the south side.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 113,
          name: 'Sheep Mountain (Dall Sheep Viewing)',
          emoji: '🦌',
          lat: 62.0167,
          lng: -147.4333,
          description:
              'The slopes above Sheep Mountain Lodge are one of the most reliable places along the highway to spot Dall sheep, often visible with the naked eye on the grassy benches above the road. Several pullouts provide safe parking for glassing the mountainside.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 129,
          name: 'Eureka Summit',
          emoji: '⛰️',
          lat: 61.9476,
          lng: -147.1470,
          description:
              'At 3,322 feet, this is the highest point on the Glenn Highway and the divide between the Chugach and Talkeetna mountain ranges. On clear days the view stretches across the Nelchina Basin to Mount Drum and the Wrangell Mountains far to the east.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 160,
          name: 'Lake Louise Road Junction',
          emoji: '🎣',
          lat: 62.1167,
          lng: -146.5667,
          description:
              'Side road leading about 19 miles north to Lake Louise, a large lake in the Nelchina Basin popular for lake trout, burbot, and grayling fishing, with state campgrounds along its shore. A scenic detour through rolling tundra and spruce forest.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 187,
          name: 'Tazlina / Copper River',
          emoji: '🎣',
          lat: 62.0500,
          lng: -145.7167,
          description:
              'The highway crosses the Tazlina River near its confluence with the mighty Copper River, a major salmon artery for the Ahtna Athabascan communities of the Copper Basin. Pullouts near the bridges offer views of the silty, glacier-fed waters and, in season, dipnetters working the banks.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 189,
          name: 'Glennallen (Richardson Hwy Junction)',
          emoji: '🔀',
          lat: 62.1097,
          lng: -145.5573,
          description:
              'Eastern terminus of this segment of the Glenn Highway, where it meets the Richardson Highway in the Copper River Basin. Glennallen is the commercial hub of the region, with fuel, groceries, lodging, and the Copper River Valley visitor information center.',
          category: HighwayStopCategories.fuel,
        ),
      ],
    ),
    Highway(
      slug: 'parks-highway',
      name: 'George Parks Highway',
      route: 'AK-3',
      color: Color(0xFF8E24AA),
      stops: [
        
        HighwayStop(
          mile: 52,
          name: 'Big Lake / Houston',
          emoji: '⛽',
          lat: 61.6280,
          lng: -149.8260,
          description:
              'A cluster of gas stations, motels, and restaurants near the turnoff for Big Lake, one of the Mat-Su Valley\'s most popular boating and fishing lakes. A good last stop for fuel before the highway leaves the bulk of the valley\'s development behind.',
          category: HighwayStopCategories.food,
        ),
        HighwayStop(
          mile: 69,
          name: 'Willow',
          emoji: '⛽',
          lat: 61.7544,
          lng: -150.0461,
          description:
              'Small community that briefly served as the planned site of Alaska\'s capital in a 1976 ballot measure that was never funded. Today it\'s the ceremonial restart point of the Iditarod Trail Sled Dog Race and offers fuel, lodging, and access to the Willow Creek State Recreation Area.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 96,
          name: 'Montana Creek',
          emoji: '🎣',
          lat: 62.2960,
          lng: -150.0680,
          description:
              'A popular roadside spot where Montana Creek crosses the highway, known for strong runs of king, silver, and pink salmon. Several private campgrounds and fishing guide outfits cluster around the bridge during summer salmon season.',
          category: HighwayStopCategories.campground,
        ),
        
        HighwayStop(
          mile: 115,
          name: 'Trapper Creek',
          emoji: '⛽',
          lat: 62.3140,
          lng: -150.1980,
          description:
              'A rural crossroads community at the junction with the Petersville Road, which heads west toward old gold-mining country and views of the Alaska Range. Trapper Creek has fuel, lodging, and a public library serving the surrounding homestead area.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 134.5,
          name: "K'esugi Ken Campground",
          emoji: '🏕️',
          lat: 62.5910,
          lng: -150.2300,
          description:
              'The flagship campground of Denali State Park, opened in 2017 with paved RV and walk-in sites, public-use cabins, and an interpretive pavilion. A network of trails climbs onto the K\'esugi Ridge alpine tundra, with some of the best non-park views of Denali on the entire highway.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 135.2,
          name: 'South Denali Viewpoint',
          emoji: '⛰️',
          lat: 62.6040,
          lng: -150.2330,
          description:
              'A signed pullout in Denali State Park offering one of the closest unobstructed views of Denali (20,310 ft) accessible from the road, weather permitting. On clear days the entire south face of the Alaska Range, including the Tokositna and Ruth Glacier valleys, dominates the western horizon.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 147,
          name: 'Byers Lake Campground',
          emoji: '🏕️',
          lat: 62.7000,
          lng: -150.0270,
          description:
              'A forested Denali State Park campground on the shore of Byers Lake, with a 4.8-mile loop trail circling the lake through spruce and birch forest. Canoeing and lake-trout fishing are popular, and on clear days the lake reflects Denali to the northwest.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 188,
          name: 'Hurricane Gulch Bridge',
          emoji: '⛰️',
          lat: 63.0210,
          lng: -149.5970,
          description:
              'A dramatic steel arch bridge spanning a 260-foot-deep gorge cut by Hurricane Creek, one of the highest bridges in Alaska. The pullouts at either end give views down into the gulch and west toward the Alaska Range foothills.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 210,
          name: 'Cantwell (Denali Highway Junction)',
          emoji: '🔀',
          lat: 63.3920,
          lng: -148.9500,
          description:
              'A small Athabascan community at the eastern end of the Denali Highway, which heads 134 miles east to Paxson through remote tundra and mountain scenery. Cantwell has fuel, lodging, and is the last services before the climb toward Denali National Park.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 237.4,
          name: 'Denali National Park Entrance',
          emoji: '🦌',
          lat: 63.7284,
          lng: -148.8866,
          description:
              'Main entrance to Denali National Park and Preserve, home to grizzly bears, caribou, moose, wolves, and Dall sheep across 6 million acres of taiga and tundra. The park visitor center, sled dog kennels, and the start of the restricted-access park road are all near this junction.',
          category: HighwayStopCategories.visitorCenter,
        ),
        HighwayStop(
          mile: 238,
          name: 'Nenana Canyon',
          emoji: '⛽',
          lat: 63.7350,
          lng: -148.8950,
          description:
              'The dense strip of hotels, restaurants, and rafting outfitters just north of the park entrance, nicknamed "Glitter Gulch," sits above the Nenana River\'s canyon. A rest area at the river bridge is a good spot to watch outfitters launch Class III-IV whitewater rafting trips through the gorge.',
          category: HighwayStopCategories.food,
        ),
        HighwayStop(
          mile: 248.7,
          name: 'Healy',
          emoji: '🏺',
          lat: 63.8714,
          lng: -148.9683,
          description:
              'Home to the Usibelli Coal Mine, Alaska\'s only operating commercial coal mine, founded in 1943 and still supplying interior power plants. Healy has year-round fuel, groceries, and lodging, serving as a quieter alternative base for visiting Denali.',
          category: HighwayStopCategories.fuel,
        ),
        
        
      ],
    ),
    Highway(
      slug: 'sterling-highway',
      name: 'Sterling Highway',
      route: 'AK-1',
      color: Color(0xFF43A047),
      stops: [
        HighwayStop(
          mile: 37,
          name: 'Tern Lake Junction',
          emoji: '🔀',
          lat: 60.4731,
          lng: -149.5256,
          description:
              'Northern terminus and Milepost 37 of the Sterling Highway, where it splits from the Seward Highway about 90 miles south of Anchorage. The small lake here is a popular spot to see nesting Arctic terns and grebes against a backdrop of the Kenai Mountains.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 48,
          name: 'Cooper Landing & Kenai River',
          emoji: '🎣',
          lat: 60.4906,
          lng: -149.7944,
          description:
              'A small community at the outlet of Kenai Lake, where the famously turquoise Kenai River begins its run to Cook Inlet. Rafting outfitters, lodges, and riverside pullouts make this one of the most popular stretches on the whole highway, especially during salmon season.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 52,
          name: 'Russian River Campground & Ferry',
          emoji: '🎣',
          lat: 60.4869,
          lng: -150.0030,
          description:
              'Access point for the Russian River, whose confluence with the Kenai River hosts one of the most concentrated sockeye salmon dipnetting scenes in Alaska during the June and July runs. A foot ferry shuttles anglers across the Kenai River to the confluence trails.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 58,
          name: 'Kenai NWR Visitor Contact Station',
          emoji: '🦌',
          lat: 60.4419,
          lng: -150.3225,
          description:
              'Eastern entrance to the 19-mile Skilak Lake Road loop through the Kenai National Wildlife Refuge, with a visitor contact station near the highway. The gravel loop offers a quieter alternative route past Skilak and Hidden Lakes, with frequent sightings of moose, trumpeter swans, and occasionally bears.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 75,
          name: 'Skilak Lake Viewpoint',
          emoji: '⛰️',
          lat: 60.4972,
          lng: -150.6244,
          description:
              'Western junction where the Skilak Loop Road rejoins the Sterling Highway. Pullouts near Skilak Lake offer wide views across glacier-fed turquoise water toward the Harding Icefield, and the lake is a popular put-in for guided fishing floats targeting rainbow trout and Dolly Varden.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 83,
          name: 'Sterling',
          emoji: '⛽',
          lat: 60.5258,
          lng: -150.8669,
          description:
              'A small unincorporated community along the Kenai River that gave the highway its name, originally after a railroad surveyor. Gas stations, RV parks, and bait shops cluster here to serve the steady stream of anglers heading to and from the river\'s middle stretches.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 94,
          name: 'Soldotna (Kenai Spur Hwy Junction)',
          emoji: '🔀',
          lat: 60.4878,
          lng: -151.0583,
          description:
              'The commercial hub of the central Kenai Peninsula, where the Kenai Spur Highway splits off toward the city of Kenai. Soldotna offers the last major concentration of gas stations, grocery stores, and lodging before Homer, plus easy public access to the Kenai River for king and silver salmon fishing.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 110,
          name: 'Kenai Old Town & Holy Assumption Church',
          emoji: '🏺',
          lat: 60.5531,
          lng: -151.2675,
          description:
              'A short detour north on the Kenai Spur Highway leads to Old Town Kenai, a bluff overlooking Cook Inlet continuously inhabited since the Dena\'ina founded the village of Shk\'ituk\'t. The Holy Assumption of the Virgin Mary Church, completed in 1896, is the oldest standing Russian Orthodox church in Alaska and anchors a National Historic Landmark district.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 117,
          name: 'Clam Gulch State Recreation Area',
          emoji: '🏕️',
          lat: 60.2256,
          lng: -151.4011,
          description:
              'A bluff-top campground with a steep road down to broad tidal flats on Cook Inlet, long famous for razor clamming during low tides (regulations permitting). The beach also offers sweeping views across the inlet to the volcanoes of the Aleutian Range.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 135,
          name: 'Ninilchik & Holy Transfiguration Chapel',
          emoji: '🏺',
          lat: 60.0547,
          lng: -151.6731,
          description:
              'One of the oldest villages on the Kenai Peninsula, founded in the 1840s by retired Russian-American Company employees and their Alutiiq families. Above the old village, the white Holy Transfiguration of Our Lord Chapel (built 1901) sits in a hilltop cemetery overlooking the river mouth and Cook Inlet, a frequently photographed landmark.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 138,
          name: 'Deep Creek State Recreation Area',
          emoji: '🎣',
          lat: 60.0531,
          lng: -151.7972,
          description:
              'Home to one of the busiest halibut and salmon charter fleets on the Kenai Peninsula, where boats are launched and retrieved directly off the beach using tractors. The campground and beach also draw surf fishermen and razor clam diggers along this stretch of Cook Inlet shoreline.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 157,
          name: 'Anchor Point',
          emoji: '⛰️',
          lat: 59.7750,
          lng: -151.8536,
          description:
              'Marketed as the westernmost point on the contiguous North American highway system, with a small park at the mouth of the Anchor River. The river is a popular spot for king and silver salmon and steelhead fishing, and the beach offers clear views across Cook Inlet to Mount Iliamna and Mount Redoubt.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 170,
          name: 'Baycrest Hill Overlook',
          emoji: '⛰️',
          lat: 59.6750,
          lng: -151.5550,
          description:
              'A signed wayside atop the bluff just before the highway drops into Homer, offering one of the best panoramic views on the entire route across Kachemak Bay to the Kenai Mountains and Augustine Volcano. Watch for whales, sea otters, and Steller sea lions in the waters far below on clear days.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 172,
          name: 'Homer & the Homer Spit',
          emoji: '⛽',
          lat: 59.6019,
          lng: -151.4172,
          description:
              'Southern terminus of the Sterling Highway, a fishing and arts town on the shore of Kachemak Bay known as the "Halibut Fishing Capital of the World." The 4.5-mile Homer Spit juts into the bay with the boat harbor, halibut charter docks, campgrounds, and seafood restaurants, with fuel and lodging available throughout town.',
          category: HighwayStopCategories.food,
        ),
      ],
    ),
    Highway(
      slug: 'richardson-highway',
      name: 'Richardson Highway',
      route: 'AK-2 / AK-4',
      color: Color(0xFF1E88E5),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Valdez (Southern Terminus)',
          emoji: '⛽',
          lat: 61.1308,
          lng: -146.3483,
          description:
              'Mile 0 of the Richardson Highway, Alaska\'s oldest highway, at the ice-free port town of Valdez on Prince William Sound. Full services including fuel, lodging, groceries, and the Alaska Marine Highway ferry terminal.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 13.5,
          name: 'Keystone Canyon Waterfalls',
          emoji: '⛰️',
          lat: 61.1736,
          lng: -146.0744,
          description:
              'Horsetail Falls (MP13.5) and Bridal Veil Falls (MP13.9) tumble straight down the sheer canyon walls beside the road, remnants of the old Valdez Goat Trail and Trans-Alaska Military Road carved through this narrow gorge.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 26.1,
          name: 'Thompson Pass',
          emoji: '⛰️',
          lat: 61.1175,
          lng: -145.7575,
          description:
              'At 2,678 feet, one of the snowiest places in Alaska, having recorded over 974 inches in a single winter. Open alpine tundra surrounds the highway here, with sweeping views back down toward Keystone Canyon and Valdez Arm.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 28.7,
          name: 'Worthington Glacier State Recreation Site',
          emoji: '⛰️',
          lat: 61.1703,
          lng: -145.7633,
          description:
              'A paved path leads from the parking area to within walking distance of this roadside glacier flowing off the Chugach Mountains. One of the most accessible glaciers in the state, with restrooms and interpretive signs about its retreat.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 79.4,
          name: 'Squirrel Creek State Recreation Site',
          emoji: '🏕️',
          lat: 61.7825,
          lng: -145.4836,
          description:
              'A small forested campground along Squirrel Creek near the Tonsina River, offering a quiet overnight stop with picnic tables and fire rings roughly midway between Valdez and Glennallen.',
          category: HighwayStopCategories.campground,
        ),
        
        HighwayStop(
          mile: 115,
          name: 'Glennallen',
          emoji: '⛽',
          lat: 62.1083,
          lng: -145.5500,
          description:
              'The commercial hub of the Copper River Basin and junction with the Glenn Highway to Anchorage. Travelers find fuel, groceries, lodging, and a regional airstrip here, with the Wrangell Mountains often visible to the east.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 147.5,
          name: 'Sourdough Creek Campground',
          emoji: '🏕️',
          lat: 62.6147,
          lng: -145.5183,
          description:
              'A campground along Sourdough Creek near the historic site of the Sourdough Roadhouse, one of the original stage stops on the Valdez-to-Fairbanks trail. Wooded sites sit close to the Gulkana River drainage.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 185.5,
          name: 'Paxson (Denali Highway Junction)',
          emoji: '🔀',
          lat: 63.0293,
          lng: -145.4962,
          description:
              'A small outpost at the western end of the Denali Highway, which runs 135 miles to Cantwell. Paxson Lodge has historically offered the last fuel for travelers heading west toward Denali National Park.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 190.5,
          name: 'Gulkana River Overlook',
          emoji: '🎣',
          lat: 63.0844,
          lng: -145.4392,
          description:
              'A paved pullout with a viewing platform overlooking the Gulkana River near Summit Lake, with the Trans-Alaska Pipeline running alongside. In late summer, sockeye and king salmon can be seen spawning in the clear water below, framed by views of the Alaska Range to the north.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 225.4,
          name: 'Black Rapids Glacier Overlook',
          emoji: '🏺',
          lat: 63.5050,
          lng: -145.8200,
          description:
              'A roadside view of the "Galloping Glacier," which surged nearly 3 miles down its valley in the winter of 1936-37, threatening to dam the Delta River and bury the highway. On clear days the glacier\'s ice is visible at the head of the valley to the southwest.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 238,
          name: 'Donnelly Creek State Recreation Site',
          emoji: '🦌',
          lat: 63.6494,
          lng: -145.8794,
          description:
              'A quiet campground at the foot of Donnelly Dome, a 3,910-foot landmark hill rising abruptly from the flats. The surrounding Delta River valley and Gunnysack Creek drainage are part of a major caribou migration corridor for the Delta herd.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 266,
          name: 'Delta Junction (Alaska Hwy Terminus)',
          emoji: '🔀',
          lat: 64.0411,
          lng: -145.7325,
          description:
              'The official end of the Alaska Highway at Historical Mile 1422, marked by a large milestone monument outside the visitor center. Delta Junction offers full services and sits at the edge of the broad farming flats of the Tanana Valley.',
          category: HighwayStopCategories.visitorCenter,
        ),
        HighwayStop(
          mile: 274.5,
          name: "Big Delta State Historical Park / Rika's Roadhouse",
          emoji: '🏺',
          lat: 64.1552,
          lng: -145.8406,
          description:
              'Preserves Rika\'s Roadhouse, a roadhouse and trading post that served travelers on the Valdez-to-Fairbanks trail from 1909 to 1947 at the crossing of the Tanana River. Restored buildings, a museum, and a campground sit beside the historic river crossing.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 366,
          name: 'Fairbanks (Northern Terminus)',
          emoji: '🏁',
          lat: 64.8378,
          lng: -147.7164,
          description:
              'The Richardson Highway ends in Fairbanks, Alaska\'s second-largest city and the transportation hub of the Interior, where it meets the Alaska Highway corridor and Parks Highway. Full services, an international airport, and the University of Alaska Fairbanks are all here.',
          category: HighwayStopCategories.fuel,
        ),
      ],
    ),
    Highway(
      slug: 'alaska-highway',
      name: 'Alaska Highway',
      route: 'AK-2',
      color: Color(0xFFD81B60),
      stops: [
        
        HighwayStop(
          mile: 7,
          name: 'Tetlin NWR Visitor Center',
          emoji: '🦌',
          lat: 62.6667,
          lng: -141.8333,
          description:
              'A seasonal Fish and Wildlife Service visitor center overlooking wetlands and boreal forest that make up one of Alaska\'s richest waterfowl breeding areas. Trumpeter swans, sandhill cranes, and dozens of duck species nest in the refuge\'s ponds, visible right from highway pullouts in spring and summer.',
          category: HighwayStopCategories.visitorCenter,
        ),
        HighwayStop(
          mile: 42,
          name: 'Northway Junction',
          emoji: '⛽',
          lat: 63.0064,
          lng: -141.7781,
          description:
              'A small highway junction community that grew up as a WWII-era Army supply point during construction of the Alaska Highway, named for Athabascan chief Walter Northway. A side road leads south a few miles to the village of Northway and its airport, one of the original 1940s airfields on the route.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 87,
          name: 'Tok River State Recreation Site',
          emoji: '🏕️',
          lat: 63.3253,
          lng: -142.8316,
          description:
              'A 27-site state campground on the east bank of the Tok River, a few miles before Tok. The river offers easy float trips and bank fishing, and the campground makes a convenient overnight stop for travelers arriving from the Canadian border before continuing into town.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 92,
          name: 'Tok (Tok Cutoff Junction)',
          emoji: '🔀',
          lat: 63.3367,
          lng: -142.9855,
          description:
              'The Alaska Highway\'s main service hub in this region and the junction with the Tok Cutoff, which connects south to the Glenn Highway toward Anchorage. Tok has long billed itself as the "Dog Mushing Capital of Alaska," with a busy mix of fuel stations, motels, and a visitor center.',
          category: HighwayStopCategories.visitorCenter,
        ),
        HighwayStop(
          mile: 104,
          name: 'Moon Lake State Recreation Site',
          emoji: '🎣',
          lat: 63.3757,
          lng: -143.5477,
          description:
              'A clear, spring-fed lake just off the highway near Tanacross, popular for canoeing, swimming, and fishing for stocked rainbow trout. The state campground sits at the base of the Alaska Range foothills with views across the water toward distant peaks.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 142,
          name: 'Dot Lake',
          emoji: '🏺',
          lat: 63.6586,
          lng: -144.0658,
          description:
              'A small Athabascan community along the highway between Tok and Delta Junction, home to fewer than 30 year-round residents. The village church and roadside lake are visible from the highway, marking one of the few settlements along this lonely stretch.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 200,
          name: 'Delta Junction (End of the Alaska Hwy)',
          emoji: '🏁',
          lat: 64.0478,
          lng: -145.7186,
          description:
              'The official end of the Alaska Highway, where it meets the Richardson Highway. The "End of the Alaska Highway" monument and visitor center mark the spot, a popular photo stop for travelers who have driven the full route from Dawson Creek, British Columbia.',
          category: HighwayStopCategories.visitorCenter,
        ),
      ],
    ),
    Highway(
      slug: 'tok-cutoff',
      name: 'Tok Cutoff',
      route: 'AK-1',
      color: Color(0xFF6D4C41),
      stops: [
        HighwayStop(
          mile: 125,
          name: 'Tok (Alaska Hwy Junction)',
          emoji: '🔀',
          lat: 63.3370,
          lng: -142.9855,
          description:
              'Western terminus of the Tok Cutoff at its junction with the Alaska Highway, marking Milepost 125. This crossroads town is the last major fuel, lodging, and supply stop before heading southwest toward Glennallen and the Copper River Valley.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 109.5,
          name: 'Eagle Trail State Recreation Site',
          emoji: '🏕️',
          lat: 63.2280,
          lng: -143.1990,
          description:
              'A wooded campground about 16 miles south of Tok, with sites tucked into spruce and birch overlooking the Tok River valley. A network of hiking trails climbs into the surrounding hills, offering a quiet overnight stop just off the highway.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 79.4,
          name: 'Mentasta Summit',
          emoji: '⛰️',
          lat: 62.9029,
          lng: -143.6694,
          description:
              'At roughly 2,434 feet, this pass through the Mentasta Mountains is the highway\'s high point and a striking transition between the Tanana drainage and the Copper River basin. Wide pullouts give views of glacier-carved ridgelines and, in late summer, fireweed-covered slopes.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 70,
          name: 'Mentasta Lake',
          emoji: '🦌',
          lat: 62.9239,
          lng: -143.5333,
          description:
              'A small Native village on the shore of Mentasta Lake, just off the highway on the west side of Mentasta Pass. The surrounding wetlands and lake margins are good places to spot waterfowl, and the area sits within range used by Dall sheep and caribou moving through the pass.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 60,
          name: 'Slana / Nabesna Road Junction',
          emoji: '🔀',
          lat: 62.7048,
          lng: -143.9462,
          description:
              'Gateway to Wrangell-St. Elias National Park & Preserve, where the gravel Nabesna Road heads southeast for 42 miles into the park\'s northern reaches. The Slana Ranger Station near the junction offers backcountry information, with open views toward the Wrangell and Mentasta mountains.',
          category: HighwayStopCategories.visitorCenter,
        ),
        
        HighwayStop(
          mile: 18,
          name: 'Chistochina River Fishing Access',
          emoji: '🎣',
          lat: 62.5500,
          lng: -144.8500,
          description:
              'The highway crosses several clearwater tributaries of the Copper River system between Chistochina and Gakona, including grayling streams favored by anglers fishing from gravel bars and bridge pullouts. Watch for soft shoulders and reduced sightlines on the older, narrower bridge spans along this stretch.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 0,
          name: 'Gakona Junction (Richardson Hwy)',
          emoji: '🔀',
          lat: 62.3028,
          lng: -145.3042,
          description:
              'Eastern end of the Tok Cutoff, Milepost 0, where the route meets the Richardson Highway between Glennallen and Delta Junction. The historic Gakona Roadhouse, one of Alaska\'s oldest continuously operated lodges, sits just north of the junction along the Copper River.',
          category: HighwayStopCategories.fuel,
        ),
      ],
    ),
    Highway(
      slug: 'dalton-highway',
      name: 'Dalton Highway',
      route: 'AK-11',
      color: Color(0xFFFFB300),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Livengood (Elliott Hwy Junction)',
          emoji: '🔀',
          lat: 65.5314,
          lng: -148.5464,
          description:
              'Southern terminus of the Dalton Highway, 84 miles north of Fairbanks via the Elliott Highway. There are no services at the junction itself; fuel up in Fairbanks before heading north, as Yukon Crossing is the next stop with gas.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 56,
          name: 'Yukon River Bridge',
          emoji: '⛽',
          lat: 65.8747,
          lng: -149.7107,
          description:
              'The E.L. Patton Bridge carries the highway and the trans-Alaska pipeline across the mighty Yukon River on a steep wooden deck. A seasonal visitor contact station, fuel, and a small cafe sit on the north bank, the first services since Fairbanks.',
          category: HighwayStopCategories.food,
        ),
        HighwayStop(
          mile: 98,
          name: 'Finger Mountain Wayside',
          emoji: '⛰️',
          lat: 66.3828,
          lng: -150.4997,
          description:
              'A granite tor rises above the tundra at this wayside, part of a landscape of ancient rock outcrops eroded into fingers and pillars. Short interpretive trails lead among the formations, with sweeping views toward the Brooks Range foothills.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 115,
          name: 'Arctic Circle Wayside',
          emoji: '🏺',
          lat: 66.5594,
          lng: -150.8000,
          description:
              'A rest area marks crossing latitude 66°33\' N, the Arctic Circle, complete with an interpretive sign and the highway\'s most popular photo op. A primitive campground and pit toilets make it a common overnight stop for southbound and northbound travelers alike.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 132,
          name: 'Gobblers Knob',
          emoji: '⛰️',
          lat: 66.7706,
          lng: -150.6800,
          description:
              'A high pullout with one of the best panoramic views on the southern Dalton, looking across rolling spruce-covered hills toward the distant Brooks Range. A worthwhile stretch-the-legs stop before the highway descends toward the Koyukuk valley.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 175,
          name: 'Coldfoot',
          emoji: '⛽',
          lat: 67.2514,
          lng: -150.1761,
          description:
              'The only full services between Yukon Crossing and Deadhorse, built on the site of a 1900s mining supply camp. The Coldfoot Camp truck stop has fuel, lodging, and meals, and the adjacent Arctic Interagency Visitor Center is the gateway for trips into Gates of the Arctic National Park.',
          category: HighwayStopCategories.visitorCenter,
        ),
        
        HighwayStop(
          mile: 203,
          name: 'Sukakpak Mountain',
          emoji: '⛰️',
          lat: 67.6034,
          lng: -149.7418,
          description:
              'A dramatic 4,459-ft peak of exposed marble and limestone that dominates the view along the Middle Fork Koyukuk valley. A pullout and short trail near its base offer classic photo angles and access for hikers.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 235,
          name: 'Chandalar Shelf',
          emoji: '🦌',
          lat: 67.9728,
          lng: -149.4886,
          description:
              'The broad alpine bench at the south approach to Atigun Pass, often grazed by Dall sheep on the steep slopes above. The road begins its climb in earnest here, leaving the last spruce trees behind as it enters true Arctic tundra.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 244,
          name: 'Atigun Pass',
          emoji: '🚧',
          lat: 68.1294,
          lng: -149.4758,
          description:
              'At 4,739 ft, the highest highway pass in Alaska and the only route through the Brooks Range, crossing the continental divide between Arctic and Pacific drainages. Steep grades, sharp curves, and frequent high winds make this the most hazardous stretch of the Dalton, especially in winter.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 275,
          name: 'Galbraith Lake',
          emoji: '🏕️',
          lat: 68.4670,
          lng: -149.4170,
          description:
              'A campground sits a few miles west of the highway on the shore of this glacial lake, ringed by the dramatic peaks of the eastern Brooks Range. The open tundra here offers some of the best backcountry hiking access along the entire Dalton corridor.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 286,
          name: 'Toolik Lake',
          emoji: '🦌',
          lat: 68.6285,
          lng: -149.5994,
          description:
              'Home to the University of Alaska\'s Toolik Field Station, a major Arctic research center studying tundra ecology and climate change. The surrounding rolling tundra is prime habitat for caribou from the Central Arctic herd, frequently seen crossing the highway.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 334,
          name: 'Happy Valley',
          emoji: '🦌',
          lat: 69.1500,
          lng: -148.8000,
          description:
              'Site of a former pipeline-construction camp on the North Slope, now a seasonal airstrip and informal pullout. The highway here crosses vast, flat tundra where musk ox and caribou are commonly spotted near the road.',
          category: HighwayStopCategories.restArea,
        ),
        
        HighwayStop(
          mile: 414,
          name: 'Deadhorse / Prudhoe Bay',
          emoji: '🏁',
          lat: 70.2056,
          lng: -148.5117,
          description:
              'Northern terminus of the Dalton Highway and a working oil-field service town supporting the Prudhoe Bay fields on the Arctic Ocean. Visitors can fuel up, stay in industrial-style hotels, and book a shuttle tour to dip a toe in the Arctic Ocean at the coast, since the shoreline itself is on restricted oil-field land.',
          category: HighwayStopCategories.fuel,
        ),
      ],
    ),
    Highway(
      slug: 'steese-highway',
      name: 'Steese Highway',
      route: 'AK-6',
      color: Color(0xFF3949AB),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Fairbanks (Southern Terminus)',
          emoji: '🔀',
          lat: 64.8378,
          lng: -147.7164,
          description:
              'Mile 0 of the Steese Highway, in downtown Fairbanks where it begins as the Steese Expressway before narrowing to a two-lane road. Last stop for major fuel, groceries, and services before heading into the gold-rush country of the Goldstream and Chatanika valleys.',
          category: HighwayStopCategories.fuel,
        ),
        
        HighwayStop(
          mile: 20.5,
          name: 'Cleary Summit',
          emoji: '⛰️',
          lat: 65.0206,
          lng: -147.3917,
          description:
              'At about 2,233 feet, this is the first true highway summit north of Fairbanks, with wide views over the Goldstream Valley and the gold-bearing hills that drew thousands of stampeders after 1902. Pullouts here are popular for aurora-watching on clear winter nights.',
          category: HighwayStopCategories.restArea,
        ),
        
        HighwayStop(
          mile: 39,
          name: 'Upper Chatanika River State Recreation Site',
          emoji: '🎣',
          lat: 65.1592,
          lng: -147.3389,
          description:
              'A quiet state campground along the clear-running Chatanika River, popular with grayling anglers and canoeists putting in for floats downstream. A good base camp for exploring the lower Steese before the road climbs into higher, more remote country.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 60,
          name: 'Cripple Creek Campground',
          emoji: '🏕️',
          lat: 65.2762,
          lng: -146.6478,
          description:
              'A campground on the Chatanika River with about 18 sites, a riverside day-use area, and a short interpretive trail through tall white spruce. It marks the transition from the wooded lower valley into the open, treeless tundra summits ahead.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 85.5,
          name: 'Twelvemile Summit',
          emoji: '🦌',
          lat: 65.4083,
          lng: -145.9417,
          description:
              'A 2,982-foot pass and the southern trailhead for the 27-mile Pinnell Mountain Trail, a National Recreation Trail that traverses alpine ridgelines to Eagle Summit. The open tundra here is prime habitat for Dall sheep and caribou of the Steese National Conservation Area.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 107,
          name: 'Eagle Summit',
          emoji: '⛰️',
          lat: 65.4844,
          lng: -145.4036,
          description:
              'At 3,685 feet, this is the highest point on the Steese Highway and one of the few spots in Interior Alaska accessible by car where the midnight sun is visible around the summer solstice. Dall sheep are frequently spotted on the surrounding ridges, and the road can hold snow into early summer.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 127,
          name: 'Central',
          emoji: '⛽',
          lat: 65.5733,
          lng: -144.8083,
          description:
              'A small mining community founded as a supply hub for the Circle Mining District, Central remains an active center for placer gold mining and offers the last fuel, food, and lodging before Circle. The Circle District Historical Society museum here covers the area\'s mining heritage.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 128,
          name: 'Circle Hot Springs',
          emoji: '⛽',
          lat: 65.4833,
          lng: -144.6342,
          description:
              'A natural hot springs resort reached via an 8-mile side road from the Steese Highway near Central, developed since the early 1900s as a respite for gold miners. The mineral springs and historic lodge remain a popular detour for soaking after the long drive north.',
          category: HighwayStopCategories.fuel,
        ),
        
      ],
    ),
    Highway(
      slug: 'taylor-highway',
      name: 'Taylor Highway',
      route: 'AK-5',
      color: Color(0xFF7CB342),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Tetlin Junction (Alaska Hwy Junction)',
          emoji: '🔀',
          lat: 63.3117,
          lng: -142.6030,
          description:
              'Southern terminus and Milepost 0 of the Taylor Highway, where it branches north from the Alaska Highway about 12 miles east of Tok. There are no services here, so top off fuel in Tok before heading north toward Chicken and Eagle.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 35,
          name: 'Mount Fairplay Wayside',
          emoji: '⛰️',
          lat: 63.7800,
          lng: -142.3400,
          description:
              'A roadside viewing platform and rest area with interpretive signs looking out over the broad alpine shoulders of 5,541 ft Mount Fairplay. On clear days the rolling, treeless ridgelines of the Yukon-Tanana uplands stretch for miles in every direction, a striking contrast to the spruce forest below.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 49,
          name: 'West Fork BLM Campground',
          emoji: '🏕️',
          lat: 63.9500,
          lng: -142.0500,
          description:
              'A small, free campground tucked along the West Fork of the Dennison Fork of the Fortymile River, with a handful of gravel pull-through sites for tents and small RVs. A quiet, no-frills overnight stop roughly midway between Tetlin Junction and Chicken, with no potable water or services.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 66,
          name: 'Chicken, Alaska',
          emoji: '⛽',
          lat: 64.0730,
          lng: -141.9370,
          description:
              'A famously named former gold-rush town that still has an active mining community today, plus a seasonal cafe, saloon, gift shop, fuel, and lodging during the summer months. The Pedro Gold Dredge sits just outside town and offers tours of historic dredging equipment from the early 1900s.',
          category: HighwayStopCategories.food,
        ),
        HighwayStop(
          mile: 75,
          name: 'South Fork Fortymile River Bridge',
          emoji: '🎣',
          lat: 64.1000,
          lng: -141.8000,
          description:
              'The highway crosses the South Fork of the Fortymile River here, part of the Fortymile National Wild and Scenic River system known for grayling fishing and float trips through gold-mining history. This stretch also crosses seasonal range of the Fortymile caribou herd, so watch for animals near the road in fall and spring.',
          category: HighwayStopCategories.scenic,
        ),
        
        
        HighwayStop(
          mile: 113,
          name: 'North Fork Fortymile River Bridge',
          emoji: '🎣',
          lat: 64.3300,
          lng: -141.5000,
          description:
              'A scenic bridge crossing of the North Fork of the Fortymile River, another braided tributary within the Fortymile Wild and Scenic River system. The surrounding hills show extensive evidence of historic placer mining, with old tailings piles and abandoned equipment visible from pullouts near the crossing.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 143,
          name: 'American Summit',
          emoji: '⛰️',
          lat: 64.5990,
          lng: -141.3000,
          description:
              'At about 3,650 feet, this is the highest point on the Taylor Highway and one of the windiest, often holding snow and ice well into late spring. The exposed alpine tundra at the summit offers sweeping views toward the Yukon River valley and is a favorite stop for photos before the long descent toward Eagle.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 158,
          name: 'Steep Grades into Eagle',
          emoji: '🚧',
          lat: 64.7500,
          lng: -141.2300,
          description:
              'The final miles into Eagle descend steeply from American Summit on narrow, winding gravel grades with limited guardrails and tight switchbacks. Trailers and large RVs should descend slowly and watch for loose gravel, washboarding, and oncoming traffic on blind curves.',
          category: HighwayStopCategories.scenic,
        ),
        
      ],
    ),
    Highway(
      slug: 'elliott-highway',
      name: 'Elliott Highway',
      route: 'AK-2',
      color: Color(0xFF00ACC1),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Fox (Steese Hwy Junction)',
          emoji: '🔀',
          lat: 64.9656,
          lng: -147.6203,
          description:
              'Milepost 0 of the Elliott Highway, where it splits from the Steese Highway about 10 miles north of Fairbanks. The small community of Fox has the last gas stations and services before the long, mostly remote run to Manley Hot Springs, 152 miles northwest.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 11,
          name: 'Olnes Pond / Lower Chatanika SRA',
          emoji: '🎣',
          lat: 65.0762,
          lng: -147.7438,
          description:
              'A short side road leads to Olnes Pond, a stocked fishing pond and campground within the Lower Chatanika River State Recreation Area. Grayling and salmon can also be fished along the nearby Chatanika River, and the campground makes a convenient first-night stop out of Fairbanks.',
          category: HighwayStopCategories.campground,
        ),
        HighwayStop(
          mile: 28,
          name: 'Wickersham Dome Trailhead',
          emoji: '⛰️',
          lat: 65.2172,
          lng: -148.0567,
          description:
              'Trailhead for the Summit Trail into the White Mountains National Recreation Area, a 1-million-acre tract of limestone peaks managed by the BLM. The climb above treeline opens onto sweeping views of the White Mountains and, on clear days, the distant Alaska Range.',
          category: HighwayStopCategories.scenic,
        ),
        
        HighwayStop(
          mile: 73,
          name: 'Livengood / Dalton Hwy Junction',
          emoji: '🔀',
          lat: 65.4900,
          lng: -148.5467,
          description:
              'Junction with the Dalton Highway (AK-11), the haul road to Prudhoe Bay and the only road crossing of the Yukon River. Livengood itself is a small, mostly residential mining community with no public fuel; top off the tank in Fox or Fairbanks before heading this far.',
          category: HighwayStopCategories.fuel,
        ),
        
        HighwayStop(
          mile: 110,
          name: 'Minto Flats Overlook',
          emoji: '🦌',
          lat: 65.1167,
          lng: -149.3667,
          description:
              'The highway crosses the eastern edge of the Minto Flats State Game Refuge, a vast wetland of lakes and sloughs along the Tolovana and Chatanika Rivers. The flats are a major waterfowl breeding area and also support moose, black bears, and one of the region\'s best sport fisheries for northern pike.',
          category: HighwayStopCategories.scenic,
        ),
        
        HighwayStop(
          mile: 152,
          name: 'Manley Hot Springs',
          emoji: '🏺',
          lat: 65.0078,
          lng: -150.6267,
          description:
              'The western terminus of the Elliott Highway, a small Tanana River community founded around a 1900s roadhouse and natural hot springs. The historic Manley Roadhouse offers the last fuel and lodging on the route, and a public parking area near the river marks the literal end of the road.',
          category: HighwayStopCategories.fuel,
        ),
      ],
    ),
    Highway(
      slug: 'denali-highway',
      name: 'Denali Highway',
      route: 'AK-8',
      color: Color(0xFF00897B),
      stops: [
        HighwayStop(
          mile: 0,
          name: 'Paxson (Richardson Hwy Junction)',
          emoji: '🔀',
          lat: 63.0293,
          lng: -145.4962,
          description:
              'Eastern terminus and Milepost 0 of the Denali Highway, where it meets the Richardson Highway. Paxson Lodge is the last fuel before MacLaren River Lodge, 42 miles west.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 16,
          name: 'Swede Lake Area',
          emoji: '🦌',
          lat: 63.0402,
          lng: -145.8659,
          description:
              'Swede Lake Trailhead on the south side of the highway, within the Tangle Lakes Archaeological District. Rolling tundra and scattered lakes make good spot-and-stalk caribou country when the Nelchina herd is moving through GMU 13.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 20,
          name: 'Tangle Lakes / Tangle River Inn',
          emoji: '⛽',
          lat: 63.0523,
          lng: -145.9835,
          description:
              'A chain of clear lakes straddling the road. Tangle River Inn offers fuel, food, and rooms, and is also a put-in for the Delta Wild and Scenic River canoe route.',
          category: HighwayStopCategories.fuel,
        ),
        
        HighwayStop(
          mile: 25,
          name: 'Tangle Lakes Archaeological District',
          emoji: '🏺',
          lat: 63.0744,
          lng: -146.1120,
          description:
              'One of the densest concentrations of prehistoric sites in Alaska, spanning roughly Milepost 15 to 37 on both sides of the highway. Surface collection and digging are prohibited — respect closure signs.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 37,
          name: 'MacLaren Summit',
          emoji: '⛰️',
          lat: 63.0886,
          lng: -146.4356,
          description:
              'At 4,086 ft, the second-highest highway pass in Alaska. Alpine tundra benches hold caribou; rocky basins above hold Dall sheep. Popular glassing pullouts near the summit.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 42,
          name: 'MacLaren River Lodge',
          emoji: '⛽',
          lat: 63.1189,
          lng: -146.5388,
          description:
              'One of just a handful of fuel, food, and lodging stops on the highway. Fills up fast in caribou season — call ahead for rooms or fuel.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 55,
          name: 'High Tundra & Sheep Country',
          emoji: '🐏',
          lat: 63.0431,
          lng: -146.8637,
          description:
              'The long stretch between MacLaren River Lodge and Alpine Creek Lodge runs through open alpine tundra with eastern Alaska Range peaks to the north. No services for 25+ miles — carry extra fuel.',
          category: HighwayStopCategories.fuel,
        ),
        HighwayStop(
          mile: 80,
          name: 'Susitna River Bridge',
          emoji: '🌉',
          lat: 63.1044,
          lng: -147.5269,
          description:
              'A roughly 1,000-foot bridge carries the highway over the upper Susitna River — a small, clear headwaters stream here, and a handy landmark for orienting on GMU 13 maps.',
          category: HighwayStopCategories.scenic,
        ),
        HighwayStop(
          mile: 82,
          name: 'Clearwater Creek',
          emoji: '🎣',
          lat: 63.1338,
          lng: -147.5389,
          description:
              'Clearwater drainage crossing near Clearwater Mountain Lodge, popular with grayling anglers and a common pull-off for glassing hillsides for caribou movement in late summer.',
          category: HighwayStopCategories.restArea,
        ),
        HighwayStop(
          mile: 104,
          name: 'Brushkana Creek Campground',
          emoji: '🏕️',
          lat: 63.2843,
          lng: -148.0617,
          description:
              'BLM campground right on Brushkana Creek — grayling fishing in reach and a good base for the GMU 13E drainages to the north.',
          category: HighwayStopCategories.campground,
        ),
        
      ],
    ),
  ];
}

/// Loads highway routes from bundled GeoJSON
/// (`assets/highways/highways.geojson`).
///
/// Each route is traced from the Alaska DOT&PF Highway System centerlines
/// (AHS_AKDOT, gis.data.alaska.gov), simplified to one continuous line per
/// highway, so the path follows the actual roadway end-to-end.
class HighwayLoader {
  HighwayLoader._();

  static List<HighwaySegment>? _cache;

  static Future<List<HighwaySegment>> load() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/highways/highways.geojson');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final features =
        (json['features'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

    final segments = <HighwaySegment>[];
    for (final f in features) {
      final props = (f['properties'] as Map?) ?? const {};
      final geom = f['geometry'] as Map<String, dynamic>?;
      if (geom == null || geom['type'] != 'LineString') continue;
      final coords = (geom['coordinates'] as List?) ?? const [];

      final colorHex = props['color'] as String?;
      final color = colorHex != null
          ? Color(int.parse(colorHex, radix: 16))
          : const Color(0xFFE53935);

      segments.add(HighwaySegment(
        slug: props['slug'] as String? ?? '',
        name: props['name'] as String? ?? '',
        route: props['route'] as String? ?? '',
        color: color,
        points: [
          for (final pt in coords)
            LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()),
        ],
      ));
    }
    _cache = segments;
    return segments;
  }
}
