/// A long-form field guide: camping, fishing, survival, wildlife, winter —
/// always written for Alaskan species, terrain, and conditions.
class Guide {
  final String id;
  final String title;
  final String category;
  final String emoji;
  final String summary;
  final String difficulty;
  final int readMinutes;
  final String season;
  final List<GuideSection> sections;
  final List<String> proTips;
  final String? safetyNote;

  const Guide({
    required this.id,
    required this.title,
    required this.category,
    required this.emoji,
    required this.summary,
    required this.difficulty,
    required this.readMinutes,
    required this.season,
    required this.sections,
    this.proTips = const [],
    this.safetyNote,
  });
}

class GuideSection {
  final String heading;
  final String body;

  const GuideSection({required this.heading, required this.body});
}

class GuideCategory {
  final String name;
  final String emoji;
  final String? imagePath;

  const GuideCategory({required this.name, required this.emoji, this.imagePath});
}
