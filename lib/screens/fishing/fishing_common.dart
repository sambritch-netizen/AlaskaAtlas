import 'package:flutter/material.dart';

import '../../models/fishing_regs.dart';
import '../../theme/app_colors.dart';

/// Shared look-and-feel for the Fishing section — water-blue accents,
/// species color coding, and small reusable widgets so every screen in the
/// flow reads like one cohesive fishing app rather than a generic list.
class FishingStyle {
  FishingStyle._();

  /// Water-blue accent used across the Fishing tab.
  static const Color water = AppColors.info; // 0xFF5B8BAB
  static const Color waterDeep = Color(0xFF3C6580);

  /// Per-species accent colors for the browse strip & chips.
  static const Map<String, Color> speciesColor = {
    FishSpecies.king: Color(0xFFC0524A), // deep red
    FishSpecies.coho: Color(0xFF9AA7AE), // silver
    FishSpecies.sockeye: Color(0xFFD2453F), // red
    FishSpecies.pink: Color(0xFFD98BA6), // pink
    FishSpecies.chum: Color(0xFF4FA3A1), // teal
    FishSpecies.rainbow: Color(0xFF67A98C), // green-pink trout
    FishSpecies.dolly: Color(0xFFCD7B3E), // char orange
    FishSpecies.grayling: Color(0xFF8C7BB8), // purple sail
    FishSpecies.lakeTrout: Color(0xFF6E8597), // slate
    FishSpecies.burbot: Color(0xFFA9874E), // brown
    FishSpecies.pike: Color(0xFF7F9A4E), // olive
    FishSpecies.whitefish: Color(0xFF93A4AE), // pale silver
    FishSpecies.otherFinfish: AppColors.textMuted,
  };

  /// Short label for compact chips/cards (drops the parenthetical).
  static const Map<String, String> speciesShort = {
    FishSpecies.king: 'King',
    FishSpecies.coho: 'Coho',
    FishSpecies.sockeye: 'Sockeye',
    FishSpecies.pink: 'Pink',
    FishSpecies.chum: 'Chum',
    FishSpecies.rainbow: 'Rainbow',
    FishSpecies.dolly: 'Dolly / Char',
    FishSpecies.grayling: 'Grayling',
    FishSpecies.lakeTrout: 'Lake Trout',
    FishSpecies.burbot: 'Burbot',
    FishSpecies.pike: 'Pike',
    FishSpecies.whitefish: 'Whitefish',
    FishSpecies.otherFinfish: 'Other',
  };

  static Color colorFor(String species) =>
      speciesColor[species] ?? FishingStyle.water;

  static String shortFor(String species) =>
      speciesShort[species] ?? species;
}

/// Small uppercase section heading in the rugged display font.
class FishingSectionHeader extends StatelessWidget {
  final String label;
  final Widget? trailing;
  const FishingSectionHeader(this.label, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'MudTrack',
              fontSize: 18,
              letterSpacing: 0.8,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// A circular species token — colored ring with a fish-hook glyph.
class SpeciesBadge extends StatelessWidget {
  final String species;
  final double size;
  const SpeciesBadge({super.key, required this.species, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final c = FishingStyle.colorFor(species);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: c.withValues(alpha: 0.55), width: 1.5),
      ),
      child: Icon(Icons.phishing, color: c, size: size * 0.5),
    );
  }
}

/// Tappable species chip (used on water detail pages).
class SpeciesChip extends StatelessWidget {
  final String species;
  final VoidCallback onTap;
  const SpeciesChip({super.key, required this.species, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = FishingStyle.colorFor(species);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: c.withValues(alpha: 0.45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                child: const Icon(Icons.phishing,
                    color: Colors.white, size: 11),
              ),
              const SizedBox(width: 8),
              Text(
                FishingStyle.shortFor(species),
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
