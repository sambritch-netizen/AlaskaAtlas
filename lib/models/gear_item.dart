/// A single spec row (label / value) shown on a gear detail page.
class GearSpec {
  final String label;
  final String value;

  const GearSpec({required this.label, required this.value});
}

/// A rentable gear package or item from Turnagain Outfitters.
///
/// Fields mirror the Turnagain Outfitters Base44 `Product` entity so the
/// catalog can sync live. `id` is the real Base44 product id.
class GearItem {
  final String id;
  final String name;
  final String category;
  final String emoji;
  final String description;
  final double pricePerDay;

  /// Product photo from Base44 (null when none is set — UI shows a fallback).
  final String? imageUrl;

  /// True for multi-item bundles (e.g. "Salmon Package").
  final bool isPackage;

  /// Highlighted by the outfitter — surfaced in the featured carousel.
  final bool featured;

  /// Can't be checked on a plane (e.g. bear spray, fuel).
  final bool noFly;

  /// What a package bundles together.
  final List<String> includes;

  /// Spec rows (size, capacity, etc.).
  final List<GearSpec> specs;

  const GearItem({
    required this.id,
    required this.name,
    required this.category,
    required this.emoji,
    required this.description,
    required this.pricePerDay,
    this.imageUrl,
    this.isPackage = false,
    this.featured = false,
    this.noFly = false,
    this.includes = const [],
    this.specs = const [],
  });
}
