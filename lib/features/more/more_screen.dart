import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/topo_background.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopoBackground(
        opacity: 0.2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                title: const Text(
                  'More',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Emergency Info ──────────────────────────────────────
                    _SectionLabel(label: 'Safety'),
                    _MoreCard(
                      icon: '🚨',
                      iconColor: AppColors.danger,
                      title: 'Emergency Info',
                      subtitle: 'Alaska rescue, bear safety, weather alerts',
                      onTap: () => _showEmergencySheet(context),
                    ),
                    _MoreCard(
                      icon: '🐻',
                      iconColor: AppColors.warning,
                      title: 'Bear Safety Guide',
                      subtitle: 'What to do in bear country',
                      onTap: () {},
                    ),

                    const SizedBox(height: 16),

                    // ── Offline Maps ────────────────────────────────────────
                    _SectionLabel(label: 'Offline Access'),
                    _MoreCard(
                      icon: '⬇️',
                      iconColor: AppColors.accent,
                      title: 'Downloaded Maps',
                      subtitle: 'Manage offline map regions',
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Coming Soon',
                          style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                        ),
                      ),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Offline maps coming in Phase 2')),
                      ),
                    ),
                    _MoreCard(
                      icon: '📡',
                      iconColor: AppColors.secondary,
                      title: 'Satellite Communicator',
                      subtitle: 'Rent a SPOT or Garmin inReach',
                      onTap: () {},
                    ),

                    const SizedBox(height: 16),

                    // ── Settings ────────────────────────────────────────────
                    _SectionLabel(label: 'Settings'),
                    _MoreCard(
                      icon: '⚙️',
                      iconColor: AppColors.textSecondary,
                      title: 'App Settings',
                      subtitle: 'Units, notifications, display',
                      onTap: () => _showSettingsSheet(context),
                    ),
                    _MoreCard(
                      icon: '👤',
                      iconColor: AppColors.textSecondary,
                      title: 'Account',
                      subtitle: 'Sign in to sync your trips',
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Coming Soon',
                          style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                        ),
                      ),
                      onTap: () {},
                    ),

                    const SizedBox(height: 16),

                    // ── About ───────────────────────────────────────────────
                    _SectionLabel(label: 'About'),
                    _MoreCard(
                      icon: '🏔️',
                      iconColor: AppColors.accent,
                      title: 'About Alaska Atlas',
                      subtitle: 'Version 1.0.0 · Built for adventurers',
                      onTap: () {},
                    ),
                    _MoreCard(
                      icon: '⭐',
                      iconColor: AppColors.warning,
                      title: 'Rate the App',
                      subtitle: 'Help us improve Alaska Atlas',
                      onTap: () {},
                    ),

                    const SizedBox(height: 32),

                    // ── Footer ──────────────────────────────────────────────
                    Center(
                      child: Column(
                        children: [
                          const Text('🏔️', style: TextStyle(fontSize: 28)),
                          const SizedBox(height: 6),
                          const Text(
                            'Alaska Atlas',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Text(
                            'Your guide to the Last Frontier',
                            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Gear provided by Turnagain Outfitters',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.secondary.withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmergencySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _EmergencySheet(),
    );
  }

  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _SettingsSheet(),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _MoreCard extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const _MoreCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(child: Text(icon, style: const TextStyle(fontSize: 18))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                trailing ??
                    const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmergencySheet extends StatelessWidget {
  const _EmergencySheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(
              color: AppColors.borderColor, borderRadius: BorderRadius.circular(2),
            )),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text('🚨', style: TextStyle(fontSize: 24)),
              SizedBox(width: 10),
              Text(
                'Emergency Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _EmergencyRow(label: 'Alaska State Troopers', value: '911 or 907-269-5511'),
          _EmergencyRow(label: 'Coast Guard (SE Alaska)', value: '907-463-2000'),
          _EmergencyRow(label: 'AK Mountain Rescue', value: '907-745-3090'),
          _EmergencyRow(label: 'Poison Control', value: '1-800-222-1222'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.danger.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
            ),
            child: const Text(
              '🐻 Bear encounter: Stand tall, speak calmly, back away slowly. Use bear spray if attacked. Do NOT run.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyRow extends StatelessWidget {
  final String label;
  final String value;
  const _EmergencyRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.danger,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSheet extends StatefulWidget {
  const _SettingsSheet();

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  bool _imperialUnits = true;
  bool _pushNotifications = true;
  bool _offlineModeHint = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(
              color: AppColors.borderColor, borderRadius: BorderRadius.circular(2),
            )),
          ),
          const SizedBox(height: 20),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 20),
          _SettingsToggle(
            label: 'Imperial units (miles, °F)',
            value: _imperialUnits,
            onChanged: (v) => setState(() => _imperialUnits = v),
          ),
          _SettingsToggle(
            label: 'Push notifications',
            value: _pushNotifications,
            onChanged: (v) => setState(() => _pushNotifications = v),
          ),
          _SettingsToggle(
            label: 'Offline mode hints',
            value: _offlineModeHint,
            onChanged: (v) => setState(() => _offlineModeHint = v),
          ),
        ],
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggle({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.accent,
      ),
    );
  }
}
