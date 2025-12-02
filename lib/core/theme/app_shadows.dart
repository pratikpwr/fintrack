import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App shadow and elevation tokens
abstract class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  // Card shadow for elevated cards
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x20000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  // Glow effect for accent elements
  static List<BoxShadow> get accentGlow => [
    BoxShadow(
      color: AppColors.accent.withOpacity(0.3),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  // Glow effect for positive elements (income, profit)
  static List<BoxShadow> get positiveGlow => [
    BoxShadow(
      color: AppColors.positive.withOpacity(0.3),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  // Glow effect for negative elements (expense, loss)
  static List<BoxShadow> get negativeGlow => [
    BoxShadow(
      color: AppColors.negative.withOpacity(0.3),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  // Inner shadow for pressed states
  static const List<BoxShadow> innerSm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
      blurStyle: BlurStyle.inner,
    ),
  ];
}

