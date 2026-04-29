import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/place_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/topo_background.dart';
import 'explore_provider.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final featuredAsync = ref.watch(featuredPlacesProvider);
    final nearbyAsync = ref.watch(nearbyPlacesProvider);

    return Scaffold(
      body: TopoBackground(
        opacity: 0.35,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // ── App Bar ──────────────────────────────────────────────────────
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alaska Atlas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Explore the Last Frontier',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
                  onPressed: () {},
                ),
                const SizedBox(width: 4),
              ],
            ),

            // ── Search bar ───────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (q) => ref.read(searchQueryProvider.notifier).state = q,
                  decoration: InputDecoration(
                    hintText: 'Search trails, fishing spots, food…',
                    prefixIcon: const Icon(Icons.search, color: AppColors.textMuted, size: 20),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(searchQueryProvider.notifier).state = '';
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),

            // ── Category chips ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                  children: [
                    // "All" chip
                    GestureDetector(
                      onTap: () => ref.read(selectedCategoryProvider.notifier).state = null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: selectedCategory == null
                              ? AppColors.accent.withValues(alpha: 0.15)
                              : AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: selectedCategory == null ? AppColors.accent : AppColors.borderColor,
                            width: selectedCategory == null ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: selectedCategory == null ? AppColors.accent : AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: selectedCategory == null ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    ...MockData.categories.map((cat) => CategoryChip(
                          category: cat,
                          selected: selectedCategory == cat,
                          onTap: () {
                            ref.read(selectedCategoryProvider.notifier).state =
                                selectedCategory == cat ? null : cat;
                          },
                        )),
                  ],
                ),
              ),
            ),

            // ── Featured Places ──────────────────────────────────────────────
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Featured', actionLabel: 'See all'),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 240,
                child: featuredAsync.when(
                  loading: () => const _ShimmerRow(),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (places) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20, right: 8),
                    itemCount: places.length,
                    itemBuilder: (context, i) => PlaceFeaturedCard(place: places[i]),
                  ),
                ),
              ),
            ),

            // ── Nearby ───────────────────────────────────────────────────────
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Nearby', actionLabel: 'See all'),
            ),

            SliverToBoxAdapter(
              child: nearbyAsync.when(
                loading: () => const _ShimmerList(),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (places) => Column(
                  children: places.map((p) => PlaceListCard(place: p)).toList(),
                ),
              ),
            ),

            // ── Turnagain Outfitters Banner ───────────────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: _TurnagainBanner(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _TurnagainBanner extends StatelessWidget {
  const _TurnagainBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondary.withValues(alpha: 0.3),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.4)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('🎒', style: TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Gear Rentals by',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Text(
                        'Turnagain Outfitters',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Everything you need for Alaska adventure',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.secondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  const _ShimmerRow();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20),
      itemCount: 3,
      itemBuilder: (_, __) => Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
