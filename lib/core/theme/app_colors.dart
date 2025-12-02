import 'package:flutter/material.dart';

/// App color palette for the dark premium theme
abstract class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceLight = Color(0xFF1E1E1E);
  static const Color surfaceLighter = Color(0xFF282828);

  // Primary Accent (Gold)
  static const Color accent = Color(0xFFD4AF37);
  static const Color accentLight = Color(0xFFE5C76B);
  static const Color accentDark = Color(0xFFB8960C);
  static const Color accentSurface = Color(0xFF2A2517);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF707070);
  static const Color textDisabled = Color(0xFF505050);

  // Semantic
  static const Color positive = Color(0xFF22C55E);
  static const Color positiveLight = Color(0xFF4ADE80);
  static const Color positiveSurface = Color(0xFF14532D);
  
  static const Color negative = Color(0xFFEF4444);
  static const Color negativeLight = Color(0xFFF87171);
  static const Color negativeSurface = Color(0xFF7F1D1D);
  
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningSurface = Color(0xFF78350F);
  
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoSurface = Color(0xFF1E3A8A);

  // Borders & Dividers
  static const Color border = Color(0xFF2A2A2A);
  static const Color borderLight = Color(0xFF363636);
  static const Color divider = Color(0xFF1F1F1F);

  // Transparent variants
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color black40 = Color(0x66000000);
  static const Color black60 = Color(0x99000000);
}

