/// A single fishable water body (river, creek, lake, drainage) with the
/// non-numeric ADF&G regulation context — what species, when it's open
/// or closed, and what gear/methods are allowed. Numeric bag limits and
/// length limits are intentionally omitted — anglers must consult the
/// current ADF&G regulations for those.
class FishingWater {
  final String name;
  final String? notes;
  final List<String> seasons;
  final List<String> methods;

  const FishingWater({
    required this.name,
    this.notes,
    this.seasons = const [],
    this.methods = const [],
  });
}

/// A drill-down sub-region within a regulatory region (e.g. "Anchorage
/// Bowl" inside Southcentral). Carries the high-level general regulations
/// for the sub-region plus the list of individually-regulated waters.
class FishingSubRegion {
  final String name;
  final String inclusiveWaters;
  final List<String> generalMethods;
  final List<String> generalSeasons;
  final List<FishingWater> waters;

  const FishingSubRegion({
    required this.name,
    required this.inclusiveWaters,
    this.generalMethods = const [],
    this.generalSeasons = const [],
    this.waters = const [],
  });
}

/// One of the four top-level ADF&G sport-fishing regulation regions.
class FishingRegion {
  final String name;
  final String summary;
  final List<FishingSubRegion> subRegions;
  final bool comingSoon;

  const FishingRegion({
    required this.name,
    required this.summary,
    this.subRegions = const [],
    this.comingSoon = false,
  });
}
