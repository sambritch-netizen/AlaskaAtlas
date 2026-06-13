import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/guide.dart';
import '../models/gear_item.dart';
import '../models/lake.dart';
import '../screens/map/lake_profile_screen.dart';
import '../screens/explore/explore_screen.dart';
import '../screens/gear/gear_detail_screen.dart';
import '../screens/gear/gear_screen.dart';
import '../screens/guides/guide_detail_screen.dart';
import '../screens/guides/guides_screen.dart';
import '../screens/map/map_screen.dart';
import '../screens/shell_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/explore',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ShellScreen(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => const ExploreScreen(),
            ),
          ]),
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
                  path: 'detail',
                  builder: (context, state) =>
                      GuideDetailScreen(guide: state.extra as Guide),
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
        ],
      ),
    ],
  );
});
