import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';

class MainNavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  static const List<_NavItem> _items = [
    _NavItem(label: 'Explore', icon: Icons.explore_outlined, activeIcon: Icons.explore),
    _NavItem(label: 'Map', icon: Icons.map_outlined, activeIcon: Icons.map),
    _NavItem(label: 'Trade', icon: Icons.candlestick_chart_outlined, activeIcon: Icons.candlestick_chart),
    _NavItem(label: 'Trips', icon: Icons.bookmark_border, activeIcon: Icons.bookmark),
    _NavItem(label: 'More', icon: Icons.more_horiz),
  ];

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.borderColor, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onItemTapped,
          items: _items
              .map((item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    activeIcon: Icon(item.activeIcon ?? item.icon),
                    label: item.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const _NavItem({required this.label, required this.icon, this.activeIcon});
}
