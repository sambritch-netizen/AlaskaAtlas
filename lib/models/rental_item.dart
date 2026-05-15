// Maps to the `rental_packages` table — the user-facing gear catalog.
// The lower-level `rental_items` table tracks physical inventory and is
// managed by Turnagain Outfitters staff separately.
class RentalItem {
  final String id;
  final String name;
  final String description;
  final String category;
  final double pricePerDay;
  final List<String> images;
  final List<String> includedItems;
  final List<String> recommendedFor;
  final bool available;

  const RentalItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.pricePerDay,
    required this.images,
    required this.includedItems,
    required this.recommendedFor,
    this.available = true,
  });

  factory RentalItem.fromJson(Map<String, dynamic> json) {
    return RentalItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      pricePerDay: (json['price_per_day'] as num).toDouble(),
      images: List<String>.from((json['images'] as List?) ?? []),
      includedItems: List<String>.from((json['included_items'] as List?) ?? []),
      recommendedFor: List<String>.from((json['recommended_for'] as List?) ?? []),
      available: json['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'price_per_day': pricePerDay,
        'images': images,
        'included_items': includedItems,
        'recommended_for': recommendedFor,
        'active': available,
      };
}
