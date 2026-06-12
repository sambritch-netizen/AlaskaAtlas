import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/gear_data.dart';
import '../../models/gear_item.dart';
import '../../services/turnagain_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

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
            SliverAppBar(
              pinned: true,
              expandedHeight: 170,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.rustDark.withValues(alpha: 0.35),
                        AppColors.background,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(item.emoji,
                                style: const TextStyle(fontSize: 44)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${GearData.outfitterName.toUpperCase()} · ${item.category.toUpperCase()}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.rust,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(item.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${item.pricePerDay.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6, left: 4),
                          child: Text('per day',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.textMuted)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(item.description,
                        style: Theme.of(context).textTheme.bodyMedium),

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
                                    color: AppColors.pine, size: 18),
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

                    if (item.goodFor.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text('Good For',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: item.goodFor
                            .map((g) =>
                                MetaBadge(label: g, color: AppColors.birch))
                            .toList(),
                      ),
                    ],

                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                            backgroundColor: AppColors.rust,
                            foregroundColor: Colors.white),
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
