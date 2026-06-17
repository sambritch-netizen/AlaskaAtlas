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

  /// Sport-fishable species present in this water per the ADF&G booklet.
  /// Use the [Species] constants below for consistency across waters.
  final List<String> species;

  const FishingWater({
    required this.name,
    this.notes,
    this.seasons = const [],
    this.methods = const [],
    this.species = const [],
  });
}

/// Canonical species names used in the ADF&G Southcentral regulations.
class FishSpecies {
  FishSpecies._();

  static const String king = 'King Salmon';
  static const String coho = 'Coho (Silver) Salmon';
  static const String sockeye = 'Sockeye (Red) Salmon';
  static const String pink = 'Pink (Humpy) Salmon';
  static const String chum = 'Chum (Dog) Salmon';
  static const String rainbow = 'Rainbow/Steelhead Trout';
  static const String dolly = 'Arctic Char / Dolly Varden';
  static const String grayling = 'Arctic Grayling';
  static const String lakeTrout = 'Lake Trout';
  static const String burbot = 'Burbot';
  static const String pike = 'Northern Pike (Invasive)';
  static const String whitefish = 'Whitefish';
  static const String otherFinfish = 'Other Finfish';
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
