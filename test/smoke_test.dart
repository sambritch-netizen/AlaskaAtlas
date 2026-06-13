import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:alaska_atlas/data/gear_data.dart';
import 'package:alaska_atlas/data/guides_data.dart';
import 'package:alaska_atlas/data/hotspots_data.dart';
import 'package:alaska_atlas/data/lakes_data.dart';

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

  test('lakes are valid Anchorage-area waters', () {
    expect(LakesData.lakes, isNotEmpty);
    for (final lake in LakesData.lakes) {
      expect(lake.lat, inInclusiveRange(61.0, 61.6),
          reason: '${lake.name} is outside the Anchorage area');
      expect(lake.lng, inInclusiveRange(-150.2, -149.3),
          reason: '${lake.name} is outside the Anchorage area');
      expect(lake.maxDepthFt, greaterThan(0));
      expect(lake.surfaceAcres, greaterThan(0));
      expect(lake.species, isNotEmpty,
          reason: '${lake.name} has no fish listed');
      expect(lake.outline.length, greaterThanOrEqualTo(8),
          reason: '${lake.name} outline too coarse to chart');
      for (final p in [...lake.outline, lake.deepPoint]) {
        expect(p.length, 2);
        expect(p[0], inInclusiveRange(0.0, 1.0));
        expect(p[1], inInclusiveRange(0.0, 1.0));
      }
      for (final s in lake.species) {
        expect(s.baits, isNotEmpty);
        // Alaska lakes only — no warm-water or saltwater outsiders.
        for (final outsider in ['tuna', 'bass', 'catfish', 'walleye']) {
          expect(s.name.toLowerCase().contains(outsider), isFalse,
              reason: '"$outsider" does not swim in ${lake.name}');
        }
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
