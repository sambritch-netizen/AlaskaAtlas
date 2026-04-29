import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../screens/main_navigation.dart';
import '../../features/explore/explore_screen.dart';
import '../../features/map/map_screen.dart';
import '../../features/rent_gear/rent_gear_screen.dart';
import '../../features/rent_gear/rental_detail_screen.dart';
import '../../features/trips/trips_screen.dart';
import '../../features/more/more_screen.dart';
import '../../models/rental_item.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/explore',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rent',
                builder: (context, state) => const RentGearScreen(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) {
                      final item = state.extra as RentalItem;
                      return RentalDetailScreen(item: item);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/trips',
                builder: (context, state) => const TripsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                builder: (context, state) => const MoreScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
