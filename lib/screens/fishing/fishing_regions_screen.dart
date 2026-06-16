import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/fishing_regs_data.dart';
import '../../data/fishing_species_profiles.dart';
import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';
import '../../widgets/topo_background.dart';
import 'fishing_common.dart';

/// Top-level "Fishing" tab — search, browse-by-species, and the four
/// ADF&G regulatory regions. Modeled on modern fishing apps: a prominent
/// search, a species shortcut strip, then the regulation regions.
class FishingRegionsScreen extends StatefulWidget {
  const FishingRegionsScreen({super.key});

  @override
  State<FishingRegionsScreen> createState() => _FishingRegionsScreenState();
}

class _FishingRegionsScreenState extends State<FishingRegionsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  // Flattened index of every regulated water for search.
  late final List<_WaterHit> _allWaters = [
    for (final region in FishingRegsData.regions)
      for (final sub in region.subRegions)
        for (final water in sub.waters)
          _WaterHit(water: water, subName: sub.name, regionName: region.name),
  ];

  List<String> get _speciesNames =>
      FishingSpeciesProfiles.byName.keys.toList();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searching = _query.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: TopoBackground(
        opacity: 0.3,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _Header(),
              _SearchBar(
                controller: _searchCtrl,
                onChanged: (v) => setState(() => _query = v),
                onClear: () {
                  _searchCtrl.clear();
                  setState(() => _query = '');
                },
              ),
              Expanded(
                child: searching
                    ? _SearchResults(
                        query: _query,
                        waters: _allWaters,
                        species: _speciesNames,
                      )
                    : _Browse(speciesNames: _speciesNames),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Header & search
// ────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: FishingStyle.water.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: FishingStyle.water.withValues(alpha: 0.4)),
            ),
            child: const Icon(Icons.phishing, color: FishingStyle.water, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'FISHING',
                style: TextStyle(
                  fontFamily: 'MudTrack',
                  fontSize: 30,
                  letterSpacing: 1.0,
                  color: AppColors.textPrimary,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Alaska Waters · Species · Regulations',
                style: TextStyle(
                  fontSize: 11,
                  color: FishingStyle.water,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search waters or fish species…',
            hintStyle:
                const TextStyle(color: AppColors.textMuted, fontSize: 14),
            prefixIcon:
                const Icon(Icons.search, color: FishingStyle.water, size: 20),
            suffixIcon: controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close,
                        color: AppColors.textMuted, size: 18),
                    onPressed: onClear,
                  ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Default browse view
// ────────────────────────────────────────────────────────────────────────

class _Browse extends StatelessWidget {
  final List<String> speciesNames;
  const _Browse({required this.speciesNames});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10, bottom: 28),
      children: [
        // Browse by species ------------------------------------------------
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: FishingSectionHeader('BROWSE BY SPECIES'),
        ),
        SizedBox(
          height: 148,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: speciesNames.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) => TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 220 + i * 35),
              curve: Curves.easeOutCubic,
              builder: (context, v, child) => Opacity(
                opacity: v,
                child: Transform.translate(
                  offset: Offset(0, 10 * (1 - v)),
                  child: child,
                ),
              ),
              child: _SpeciesCard(species: speciesNames[i]),
            ),
          ),
        ),
        const SizedBox(height: 22),
        // Regulations by region -------------------------------------------
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: FishingSectionHeader('REGULATIONS BY REGION'),
        ),
        for (final region in FishingRegsData.regions)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: _RegionCard(region: region),
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: _RegsDisclaimer(),
        ),
      ],
    );
  }
}

class _SpeciesCard extends StatelessWidget {
  final String species;
  const _SpeciesCard({required this.species});

  @override
  Widget build(BuildContext context) {
    final profile = FishingSpeciesProfiles.byName[species];
    final c = FishingStyle.colorFor(species);
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.go('/fishing/species', extra: species),
        child: Container(
          width: 114,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.withValues(alpha: 0.38)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpeciesBadge(species: species, size: 46),
              const Spacer(),
              Text(
                FishingStyle.shortFor(species),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                profile?.scientificName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 9.5,
                  fontStyle: FontStyle.italic,
                  color: c.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionCard extends StatelessWidget {
  final FishingRegion region;
  const _RegionCard({required this.region});

  int get _waterCount =>
      region.subRegions.fold(0, (sum, sub) => sum + sub.waters.length);

  @override
  Widget build(BuildContext context) {
    final disabled = region.comingSoon;
    final title = region.name.replaceAll(' Regulations', '');

    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: disabled
              ? null
              : () => context.go('/fishing/region', extra: region),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tinted header band — full-width water accent, no stripe
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 13, 14, 13),
                  decoration: BoxDecoration(
                    color: FishingStyle.water.withValues(alpha: 0.10),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'MudTrack',
                            fontSize: 20,
                            letterSpacing: 0.5,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (disabled)
                        _Pill(label: 'COMING SOON', color: AppColors.textMuted)
                      else
                        const Icon(Icons.chevron_right,
                            color: FishingStyle.water, size: 20),
                    ],
                  ),
                ),
                // Content zone
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        region.summary,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (!disabled) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _StatChip(
                              icon: Icons.layers_outlined,
                              label: '${region.subRegions.length} sub-regions',
                            ),
                            const SizedBox(width: 8),
                            _StatChip(
                              icon: Icons.water_drop_outlined,
                              label: '$_waterCount waters',
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Search results
// ────────────────────────────────────────────────────────────────────────

class _SearchResults extends StatelessWidget {
  final String query;
  final List<_WaterHit> waters;
  final List<String> species;
  const _SearchResults({
    required this.query,
    required this.waters,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    final q = query.trim().toLowerCase();
    final speciesHits =
        species.where((s) => s.toLowerCase().contains(q)).toList();
    final waterHits =
        waters.where((w) => w.water.name.toLowerCase().contains(q)).toList();

    if (speciesHits.isEmpty && waterHits.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'No waters or species match "$query".',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        if (speciesHits.isNotEmpty) ...[
          const FishingSectionHeader('SPECIES'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in speciesHits)
                SpeciesChip(
                  species: s,
                  onTap: () => context.go('/fishing/species', extra: s),
                ),
            ],
          ),
          const SizedBox(height: 22),
        ],
        if (waterHits.isNotEmpty) ...[
          FishingSectionHeader('WATERS · ${waterHits.length}'),
          const SizedBox(height: 10),
          for (final hit in waterHits) ...[
            _WaterResultRow(hit: hit),
            const SizedBox(height: 8),
          ],
        ],
      ],
    );
  }
}

class _WaterResultRow extends StatelessWidget {
  final _WaterHit hit;
  const _WaterResultRow({required this.hit});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.go('/fishing/water', extra: hit.water),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.water_drop_outlined,
                  color: FishingStyle.water, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hit.water.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hit.subName,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Small bits
// ────────────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: FishingStyle.water),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _RegsDisclaimer extends StatelessWidget {
  const _RegsDisclaimer();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline, size: 15, color: AppColors.textMuted),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Summaries of ADF&G sport-fishing regulations. Bag/length '
              'limits are omitted — emergency orders supersede published '
              'regs. Always check adfg.alaska.gov/sf/EONR before you cast.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A regulated water plus where it sits, for the flattened search index.
class _WaterHit {
  final FishingWater water;
  final String subName;
  final String regionName;
  const _WaterHit({
    required this.water,
    required this.subName,
    required this.regionName,
  });
}
