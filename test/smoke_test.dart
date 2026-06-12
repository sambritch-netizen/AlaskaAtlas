import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:alaska_atlas/data/gear_data.dart';
import 'package:alaska_atlas/data/guides_data.dart';
import 'package:alaska_atlas/data/hotspots_data.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  test('hot spots are valid and inside Alaska', () {
    expect(HotspotsData.hotspots, isNotEmpty);
    for (final spot in HotspotsData.hotspots) {
      expect(HotspotsData.categories, contains(spot.category),
          reason: '${spot.name} has unknown category ${spot.category}');
      // Rough Alaska bounding box (incl. Aleutians & Southeast).
      expect(spot.lat, inInclusiveRange(51.0, 72.0),
          reason: '${spot.name} latitude out of range');
      expect(spot.lng, inInclusiveRange(-180.0, -129.0),
          reason: '${spot.name} longitude out of range');
    }
  });

  test('guides are Alaska-appropriate', () {
    expect(GuidesData.guides.length, greaterThanOrEqualTo(10));
    final categoryNames = GuidesData.categories.map((c) => c.name);
    for (final guide in GuidesData.guides) {
      expect(categoryNames, contains(guide.category));
      expect(guide.sections, isNotEmpty);
      // No non-Alaskan species sneaking into the fishing guides.
      final text = '${guide.title} ${guide.summary} '
              '${guide.sections.map((s) => '${s.heading} ${s.body}').join(' ')}'
          .toLowerCase();
      for (final outsider in ['tuna', 'marlin', 'largemouth bass', 'catfish']) {
        expect(text.contains(outsider), isFalse,
            reason: '"$outsider" does not belong in an Alaska guide '
                '(${guide.id})');
      }
    }
  });

  test('gear catalog is priced and categorized', () {
    expect(GearData.items, isNotEmpty);
    for (final item in GearData.items) {
      expect(GearData.categories, contains(item.category));
      expect(item.pricePerDay, greaterThan(0));
    }
  });
}
