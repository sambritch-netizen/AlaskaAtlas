/// A rentable gear package from Turnagain Outfitters.
class GearItem {
  final String id;
  final String name;
  final String category;
  final String emoji;
  final String description;
  final double pricePerDay;
  final List<String> includes;
  final List<String> goodFor;

  const GearItem({
    required this.id,
    required this.name,
    required this.category,
    required this.emoji,
    required this.description,
    required this.pricePerDay,
    this.includes = const [],
    this.goodFor = const [],
  });
}
