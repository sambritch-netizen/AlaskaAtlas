/// A user's in-progress or finalized Alaska trip — dates, the cities
/// they'll visit (in order), how many nights they're spending in each, and
/// which activities they've saved per city.
class TripPlan {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? arrivalCityId;
  final String? departureCityId;

  /// Itinerary stops in visit order, including arrival/departure cities
  /// once chosen.
  final List<String> cityIds;

  /// Nights spent in each city id. Cities not present default to 1 night.
  final Map<String, int> nightsByCity;

  /// Saved activity refs per city id, e.g. "hotspot:denali" or
  /// "waypoint:12" or "localpick:3".
  final Map<String, List<String>> savedActivitiesByCity;

  const TripPlan({
    this.startDate,
    this.endDate,
    this.arrivalCityId,
    this.departureCityId,
    this.cityIds = const [],
    this.nightsByCity = const {},
    this.savedActivitiesByCity = const {},
  });

  static const empty = TripPlan();

  bool get hasDates => startDate != null && endDate != null;

  int get dayCount {
    if (!hasDates) return 0;
    return endDate!.difference(startDate!).inDays + 1;
  }

  int nightsFor(String cityId) => nightsByCity[cityId] ?? 1;

  int get totalPlannedNights =>
      cityIds.fold(0, (sum, id) => sum + nightsFor(id));

  int get totalSavedActivities =>
      savedActivitiesByCity.values.fold(0, (sum, l) => sum + l.length);

  TripPlan copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? arrivalCityId,
    String? departureCityId,
    List<String>? cityIds,
    Map<String, int>? nightsByCity,
    Map<String, List<String>>? savedActivitiesByCity,
  }) {
    return TripPlan(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      arrivalCityId: arrivalCityId ?? this.arrivalCityId,
      departureCityId: departureCityId ?? this.departureCityId,
      cityIds: cityIds ?? this.cityIds,
      nightsByCity: nightsByCity ?? this.nightsByCity,
      savedActivitiesByCity: savedActivitiesByCity ?? this.savedActivitiesByCity,
    );
  }

  Map<String, dynamic> toJson() => {
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'arrivalCityId': arrivalCityId,
        'departureCityId': departureCityId,
        'cityIds': cityIds,
        'nightsByCity': nightsByCity,
        'savedActivitiesByCity': savedActivitiesByCity,
      };

  factory TripPlan.fromJson(Map<String, dynamic> json) {
    return TripPlan(
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      arrivalCityId: json['arrivalCityId'] as String?,
      departureCityId: json['departureCityId'] as String?,
      cityIds: (json['cityIds'] as List?)?.cast<String>() ?? const [],
      nightsByCity: (json['nightsByCity'] as Map?)?.map(
            (k, v) => MapEntry(k as String, v as int),
          ) ??
          const {},
      savedActivitiesByCity: (json['savedActivitiesByCity'] as Map?)?.map(
            (k, v) => MapEntry(k as String, (v as List).cast<String>()),
          ) ??
          const {},
    );
  }
}
