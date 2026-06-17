import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/alaska_cities_data.dart';
import '../models/fishing_regs.dart';
import '../models/guide.dart';
import '../models/gear_item.dart';
import '../models/lake.dart';
import '../models/species.dart';
import '../screens/map/lake_profile_screen.dart';
import '../screens/fishing/fish_species_screen.dart';
import '../screens/fishing/fishing_regions_screen.dart';
import '../screens/fishing/fishing_subregion_screen.dart';
import '../screens/fishing/fishing_subregions_screen.dart';
import '../screens/fishing/fishing_water_screen.dart';
import '../screens/gear/gear_detail_screen.dart';
import '../screens/gear/gear_screen.dart';
import '../screens/guides/guide_category_screen.dart';
import '../screens/guides/guide_detail_screen.dart';
import '../screens/guides/guides_screen.dart';
import '../screens/guides/species_detail_screen.dart';
import '../screens/guides/species_list_screen.dart';
import '../screens/map/map_screen.dart';
import '../screens/shell_screen.dart';
import '../screens/trip/trip_activities_screen.dart';
import '../screens/trip/trip_cities_screen.dart';
import '../screens/trip/trip_planner_screen.dart';
import '../screens/trip/trip_setup_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/map',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ShellScreen(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapScreen(),
              routes: [
                GoRoute(
                  path: 'lake',
                  builder: (context, state) =>
                      LakeProfileScreen(lake: state.extra as Lake),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/guides',
              builder: (context, state) => const GuidesScreen(),
              routes: [
                GoRoute(
                  path: 'category',
                  builder: (context, state) =>
                      GuideCategoryScreen(category: state.extra as String),
                ),
                GoRoute(
                  path: 'detail',
                  builder: (context, state) =>
                      GuideDetailScreen(guide: state.extra as Guide),
                ),
                GoRoute(
                  path: 'species-list',
                  builder: (context, state) {
                    final extra =
                        state.extra as Map<String, Object?>;
                    return SpeciesListScreen(
                      title: extra['title'] as String,
                      species: extra['species'] as List<Species>,
                    );
                  },
                ),
                GoRoute(
                  path: 'species',
                  builder: (context, state) =>
                      SpeciesDetailScreen(species: state.extra as Species),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/fishing',
              builder: (context, state) => const FishingRegionsScreen(),
              routes: [
                GoRoute(
                  path: 'region',
                  builder: (context, state) => FishingRegionScreen(
                    region: state.extra as FishingRegion,
                  ),
                ),
                GoRoute(
                  path: 'subregion',
                  builder: (context, state) => FishingSubRegionScreen(
                    sub: state.extra as FishingSubRegion,
                  ),
                ),
                GoRoute(
                  path: 'water',
                  builder: (context, state) => FishingWaterScreen(
                    water: state.extra as FishingWater,
                  ),
                ),
                GoRoute(
                  path: 'species',
                  builder: (context, state) => FishSpeciesScreen(
                    speciesName: state.extra as String,
                  ),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/gear',
              builder: (context, state) => const GearScreen(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) =>
                      GearDetailScreen(item: state.extra as GearItem),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/trip',
              builder: (context, state) => const TripPlannerScreen(),
              routes: [
                GoRoute(
                  path: 'setup',
                  builder: (context, state) => const TripSetupScreen(),
                ),
                GoRoute(
                  path: 'cities',
                  builder: (context, state) => const TripCitiesScreen(),
                ),
                GoRoute(
                  path: 'city',
                  builder: (context, state) => TripActivitiesScreen(
                    city: state.extra as AlaskaCity,
                  ),
                ),
                GoRoute(
                  path: 'route',
                  builder: (context, state) {
                    final extra = state.extra as List<AlaskaCity>;
                    return TripActivitiesScreen(
                      city: extra[0],
                      routeTo: extra[1],
                    );
                  },
                ),
              ],
            ),
          ]),
        ],
      ),
    ],
  );
});
