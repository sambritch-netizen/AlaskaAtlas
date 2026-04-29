class Place {
  final String id;
  final String name;
  final String category;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> images;
  final String? difficulty;
  final String bestSeason;
  final List<String> tags;
  final bool hasFoodNearby;
  final double? rating;
  final int? reviewCount;
  final double? distanceMiles;

  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.images,
    this.difficulty,
    required this.bestSeason,
    required this.tags,
    required this.hasFoodNearby,
    this.rating,
    this.reviewCount,
    this.distanceMiles,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      images: List<String>.from(json['images'] as List),
      difficulty: json['difficulty'] as String?,
      bestSeason: json['best_season'] as String,
      tags: List<String>.from(json['tags'] as List),
      hasFoodNearby: json['has_food_nearby'] as bool,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      distanceMiles: (json['distance_miles'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'images': images,
        'difficulty': difficulty,
        'best_season': bestSeason,
        'tags': tags,
        'has_food_nearby': hasFoodNearby,
        'rating': rating,
        'review_count': reviewCount,
        'distance_miles': distanceMiles,
      };

  Place copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    double? latitude,
    double? longitude,
    List<String>? images,
    String? difficulty,
    String? bestSeason,
    List<String>? tags,
    bool? hasFoodNearby,
    double? rating,
    int? reviewCount,
    double? distanceMiles,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      images: images ?? this.images,
      difficulty: difficulty ?? this.difficulty,
      bestSeason: bestSeason ?? this.bestSeason,
      tags: tags ?? this.tags,
      hasFoodNearby: hasFoodNearby ?? this.hasFoodNearby,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      distanceMiles: distanceMiles ?? this.distanceMiles,
    );
  }
}
