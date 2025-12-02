import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_shadows.dart';

/// Common BoxDecoration presets
abstract class AppDecorations {
  // Card decorations
  static BoxDecoration get card => BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppRadius.card,
    border: Border.all(color: AppColors.border, width: 1),
  );

  static BoxDecoration get cardElevated => BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: AppRadius.card,
    boxShadow: AppShadows.card,
  );

  static BoxDecoration get cardAccent => BoxDecoration(
    color: AppColors.accentSurface,
    borderRadius: AppRadius.card,
    border: Border.all(color: AppColors.accent.withOpacity(0.3), width: 1),
  );

  static BoxDecoration get cardPositive => BoxDecoration(
    color: AppColors.positiveSurface,
    borderRadius: AppRadius.card,
    border: Border.all(color: AppColors.positive.withOpacity(0.3), width: 1),
  );

  static BoxDecoration get cardNegative => BoxDecoration(
    color: AppColors.negativeSurface,
    borderRadius: AppRadius.card,
    border: Border.all(color: AppColors.negative.withOpacity(0.3), width: 1),
  );

  // Input decorations
  static BoxDecoration get input => BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: AppRadius.input,
    border: Border.all(color: AppColors.border, width: 1),
  );

  static BoxDecoration get inputFocused => BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: AppRadius.input,
    border: Border.all(color: AppColors.accent, width: 1.5),
  );

  static BoxDecoration get inputError => BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: AppRadius.input,
    border: Border.all(color: AppColors.negative, width: 1),
  );

  // Button backgrounds
  static BoxDecoration get buttonPrimary => BoxDecoration(
    color: AppColors.accent,
    borderRadius: AppRadius.button,
  );

  static BoxDecoration get buttonSecondary => BoxDecoration(
    color: Colors.transparent,
    borderRadius: AppRadius.button,
    border: Border.all(color: AppColors.accent, width: 1.5),
  );

  static BoxDecoration get buttonTertiary => BoxDecoration(
    color: Colors.transparent,
    borderRadius: AppRadius.button,
  );

  // Bottom sheet
  static BoxDecoration get bottomSheet => BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppRadius.bottomSheet,
    border: Border(
      top: BorderSide(color: AppColors.border, width: 1),
    ),
  );

  // Chip decorations
  static BoxDecoration get chip => BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: AppRadius.chip,
    border: Border.all(color: AppColors.border, width: 1),
  );

  static BoxDecoration get chipSelected => BoxDecoration(
    color: AppColors.accentSurface,
    borderRadius: AppRadius.chip,
    border: Border.all(color: AppColors.accent, width: 1),
  );

  // Avatar/Icon badge
  static BoxDecoration iconBadge(Color backgroundColor) => BoxDecoration(
    color: backgroundColor.withOpacity(0.15),
    borderRadius: AppRadius.radiusMd,
  );

  // Divider
  static BoxDecoration get divider => const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: AppColors.divider, width: 1),
    ),
  );
}

