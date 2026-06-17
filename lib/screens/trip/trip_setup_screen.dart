import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/alaska_cities_data.dart';
import '../../providers/trip_plan_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/topo_background.dart';

const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _fmtDate(DateTime d) => '${_monthNames[d.month - 1]} ${d.day}, ${d.year}';

/// Step 1 of the trip planner: trip dates, then arrival and departure
/// cities. Saves straight into [tripPlanProvider] as choices are made.
class TripSetupScreen extends ConsumerStatefulWidget {
  const TripSetupScreen({super.key});

  @override
  ConsumerState<TripSetupScreen> createState() => _TripSetupScreenState();
}

class _TripSetupScreenState extends ConsumerState<TripSetupScreen> {
  Future<void> _pickDates() async {
    final plan = ref.read(tripPlanProvider);
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
      initialDateRange: plan.hasDates
          ? DateTimeRange(start: plan.startDate!, end: plan.endDate!)
          : null,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.pine,
            onPrimary: Colors.white,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (range != null) {
      ref.read(tripPlanProvider.notifier).setDates(range.start, range.end);
    }
  }

  void _pickCity({required bool isArrival}) {
    final plan = ref.read(tripPlanProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CityPickerSheet(
        title: isArrival ? 'Arriving Into' : 'Departing From',
        selectedId: isArrival ? plan.arrivalCityId : plan.departureCityId,
        onSelected: (id) {
          ref.read(tripPlanProvider.notifier).setArrivalDeparture(
                arrivalCityId: isArrival ? id : plan.arrivalCityId,
                departureCityId: isArrival ? plan.departureCityId : id,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plan = ref.watch(tripPlanProvider);
    final arrival =
        plan.arrivalCityId != null ? AlaskaCitiesData.byId(plan.arrivalCityId!) : null;
    final departure =
        plan.departureCityId != null ? AlaskaCitiesData.byId(plan.departureCityId!) : null;
    final canContinue = plan.hasDates && arrival != null && departure != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Plan a Trip')),
      body: TopoBackground(
        opacity: 0.3,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text('When are you going?', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickDates,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.pine),
                    const SizedBox(width: 12),
                    Expanded(
                      child: plan.hasDates
                          ? Text(
                              '${_fmtDate(plan.startDate!)} – ${_fmtDate(plan.endDate!)}  ·  ${plan.dayCount} days',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Text('Select travel dates',
                              style: const TextStyle(color: AppColors.textMuted)),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Where does your trip start?',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            _CitySelectTile(
              icon: Icons.flight_land,
              label: arrival?.name ?? 'Select arrival city',
              emoji: arrival?.emoji,
              onTap: () => _pickCity(isArrival: true),
            ),
            const SizedBox(height: 24),
            Text('Where does it end?', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            _CitySelectTile(
              icon: Icons.flight_takeoff,
              label: departure?.name ?? 'Select departure city',
              emoji: departure?.emoji,
              onTap: () => _pickCity(isArrival: false),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canContinue ? () => context.go('/trip/cities') : null,
                child: const Text('Next: Pick Your Cities'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CitySelectTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? emoji;
  final VoidCallback onTap;

  const _CitySelectTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.pine),
            const SizedBox(width: 12),
            if (emoji != null) ...[
              Text(emoji!, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                label,
                style: emoji == null
                    ? const TextStyle(color: AppColors.textMuted)
                    : Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _CityPickerSheet extends StatefulWidget {
  final String title;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  const _CityPickerSheet({
    required this.title,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  State<_CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<_CityPickerSheet> {
  bool _airportOnly = true;

  @override
  Widget build(BuildContext context) {
    final cities = _airportOnly
        ? AlaskaCitiesData.airportCities
        : AlaskaCitiesData.cities;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SheetHandle(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(widget.title,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  FilterChip(
                    label: const Text('Airports only'),
                    selected: _airportOnly,
                    onSelected: (v) => setState(() => _airportOnly = v),
                    selectedColor: AppColors.pine.withValues(alpha: 0.2),
                    labelStyle: TextStyle(
                      color: _airportOnly ? AppColors.pine : AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                        color: _airportOnly ? AppColors.pine : AppColors.border),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: cities.length,
                itemBuilder: (context, i) {
                  final city = cities[i];
                  final isSelected = city.id == widget.selectedId;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? AppColors.pine : AppColors.border,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: ListTile(
                      leading: Text(city.emoji, style: const TextStyle(fontSize: 22)),
                      title: Text(city.name, style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(city.blurb,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.pine)
                          : null,
                      onTap: () {
                        widget.onSelected(city.id);
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
