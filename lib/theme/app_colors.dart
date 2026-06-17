import 'package:flutter/material.dart';

/// Alaska Atlas palette — deep forest greens with rugged earth-tone accents.
///
/// The whole app keys off this file: near-black evergreen backgrounds,
/// pine-green primary actions, and a burnt-rust secondary used for the
/// Turnagain Outfitters gear rental brand moments.
class AppColors {
  AppColors._();

  // Surfaces
  static const Color background = Color(0xFF0B120C);
  static const Color surface = Color(0xFF111B12);
  static const Color surfaceElevated = Color(0xFF1A2A1C);
  static const Color card = Color(0xFF152115);

  // Brand
  static const Color pine = Color(0xFF4C9A5F);
  static const Color pineDark = Color(0xFF2F7042);
  static const Color pineDeep = Color(0xFF1B4332);
  static const Color rust = Color(0xFFCD7B3E);
  static const Color rustDark = Color(0xFFA35E26);
  static const Color birch = Color(0xFFB9A47A);

  // Text
  static const Color textPrimary = Color(0xFFECF2EA);
  static const Color textSecondary = Color(0xFF9DB3A0);
  static const Color textMuted = Color(0xFF8DA791);

  // Lines
  static const Color border = Color(0xFF24382A);
  static const Color divider = Color(0xFF1D2F22);
  static const Color topoLine = Color(0xFF1C3322);
  static const Color topoLineBright = Color(0xFF26432D);

  // Status
  static const Color danger = Color(0xFFE25B4A);
  static const Color warning = Color(0xFFE0A93E);
  static const Color success = Color(0xFF4C9A5F);
  static const Color info = Color(0xFF5B8BAB);
}
