/// A field-guide entry for a fish, bird, land animal, or harvestable
/// plant/fungus — used by the Guides "species" sub-categories
/// (Fish Species, Birds, Land Animals, Berries, Mushrooms & Foraging).
class Species {
  final String id;
  final String name;
  final String scientificName;
  final String emoji;
  final String subcategory;
  final String overview;
  final String habitat;
  final String size;
  final String season;
  final List<String> facts;
  final String tips;
  final List<String> baits;
  final String? caution;

  const Species({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.emoji,
    required this.subcategory,
    required this.overview,
    required this.habitat,
    required this.size,
    required this.season,
    required this.facts,
    required this.tips,
    this.baits = const [],
    this.caution,
  });
}

class SpeciesSubcategory {
  final String name;
  final String emoji;
  final String description;

  const SpeciesSubcategory({
    required this.name,
    required this.emoji,
    required this.description,
  });
}
