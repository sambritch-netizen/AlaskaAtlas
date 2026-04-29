class Restaurant {
  final String id;
  final String name;
  final String cuisineType;
  final String description;
  final double latitude;
  final double longitude;
  final String priceRange;
  final Map<String, String> hours;
  final List<String> images;
  final double? rating;
  final int? reviewCount;
  final String? phone;
  final String? website;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisineType,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.priceRange,
    required this.hours,
    required this.images,
    this.rating,
    this.reviewCount,
    this.phone,
    this.website,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      cuisineType: json['cuisine_type'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      priceRange: json['price_range'] as String,
      hours: Map<String, String>.from(json['hours'] as Map),
      images: List<String>.from(json['images'] as List),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cuisine_type': cuisineType,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'price_range': priceRange,
        'hours': hours,
        'images': images,
        'rating': rating,
        'review_count': reviewCount,
        'phone': phone,
        'website': website,
      };
}
