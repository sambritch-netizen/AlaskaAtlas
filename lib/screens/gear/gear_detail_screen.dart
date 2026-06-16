import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/gear_data.dart';
import '../../models/gear_item.dart';
import '../../services/turnagain_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';
import 'gear_screen.dart';

class GearDetailScreen extends StatelessWidget {
  final GearItem item;

  const GearDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopoBackground(
        opacity: 0.25,
        child: CustomScrollView(
          slivers: [
            // ── Hero photo ──────────────────────────────────────────
            SliverAppBar(
              pinned: true,
              expandedHeight: 280,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    GearImage(item: item),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x33000000),
                            Colors.transparent,
                            Color(0xCC0B120C),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Row(
                          children: [
                            if (item.isPackage) ...[
                              _Tag(
                                  label: 'PACKAGE',
                                  color: AppColors.rustDark),
                              const SizedBox(width: 8),
                            ],
                            _Tag(
                                label: item.category.toUpperCase(),
                                color: AppColors.rust),
                            if (item.noFly) ...[
                              const SizedBox(width: 8),
                              _Tag(
                                  label: 'NO-FLY',
                                  color: AppColors.danger,
                                  icon: Icons.no_transfer),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '\$${item.pricePerDay.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppColors.rust,
                          ),
                        ),
                        const Text(' per day',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textMuted)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(item.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.5)),

                    if (item.includes.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text('What\'s Included',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      ...item.includes.map((inc) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_outline,
                                    color: AppColors.rust, size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(inc,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ],
                            ),
                          )),
                    ],

                    if (item.specs.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text('Specs',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      ...item.specs.map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(s.label,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textMuted)),
                                ),
                                Expanded(
                                  child: Text(s.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ],
                            ),
                          )),
                    ],

                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                            backgroundColor: AppColors.rust,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14)),
                        onPressed: () => _showBookingSheet(context),
                        icon: const Icon(Icons.event_available),
                        label: const Text('Request to Book'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'Anchorage-based · book at turnagainoutfitters.com',
                        style: Theme.of(context).textTheme.bodySmall,
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

  void _showBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 0, 24, 24 + MediaQuery.of(sheetContext).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHandle(),
            const SizedBox(height: 12),
            Text('Book with ${GearData.outfitterName}',
                style: Theme.of(sheetContext).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Reservations are handled directly by Turnagain Outfitters. '
              'Tap below to open turnagainoutfitters.com and lock in your dates.',
              style: Theme.of(sheetContext).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.rust,
                    foregroundColor: Colors.white),
                onPressed: () {
                  launchUrl(
                    Uri.parse(TurnagainService.websiteUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open Turnagain Outfitters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const _Tag({required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 12),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
