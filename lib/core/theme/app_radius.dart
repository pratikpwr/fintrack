import 'package:flutter/material.dart';

/// App border radius tokens
abstract class AppRadius {
  // Raw values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 999.0;

  // BorderRadius objects
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusFull = BorderRadius.all(Radius.circular(full));

  // Named component radii
  static const BorderRadius card = BorderRadius.all(Radius.circular(md));
  static const BorderRadius button = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius buttonLarge = BorderRadius.all(Radius.circular(md));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(full));
  static const BorderRadius input = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius bottomSheet = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
  static const BorderRadius dialog = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius avatar = BorderRadius.all(Radius.circular(full));
  static const BorderRadius badge = BorderRadius.all(Radius.circular(xs));
}

