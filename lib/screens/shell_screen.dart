import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class ShellScreen extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ShellScreen({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: (i) => shell.goBranch(
            i,
            initialLocation: i == shell.currentIndex,
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Guides',
            ),
            NavigationDestination(
              icon: Icon(Icons.set_meal_outlined),
              selectedIcon: Icon(Icons.set_meal),
              label: 'Fishing',
            ),
            NavigationDestination(
              icon: Icon(Icons.backpack_outlined),
              selectedIcon: Icon(Icons.backpack),
              label: 'Rent Gear',
            ),
            NavigationDestination(
              icon: Icon(Icons.card_travel_outlined),
              selectedIcon: Icon(Icons.card_travel),
              label: 'Trip',
            ),
          ],
        ),
      ),
    );
  }
}
