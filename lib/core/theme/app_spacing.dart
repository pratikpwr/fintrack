import 'package:flutter/material.dart';

/// App spacing system based on 8px grid
abstract class AppSpacing {
  // Base unit
  static const double unit = 8.0;

  // Named sizes
  static const double xxs = 4.0;   // 0.5x
  static const double xs = 8.0;    // 1x
  static const double sm = 12.0;   // 1.5x
  static const double md = 16.0;   // 2x
  static const double lg = 24.0;   // 3x
  static const double xl = 32.0;   // 4x
  static const double xxl = 48.0;  // 6x
  static const double xxxl = 64.0; // 8x

  // Common EdgeInsets
  static const EdgeInsets pagePadding = EdgeInsets.all(md);
  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets pageVertical = EdgeInsets.symmetric(vertical: md);
  
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingCompact = EdgeInsets.all(sm);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(lg);
  
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  
  static const EdgeInsets sectionSpacing = EdgeInsets.only(bottom: lg);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // Horizontal gaps
  static const SizedBox hGapXxs = SizedBox(width: xxs);
  static const SizedBox hGapXs = SizedBox(width: xs);
  static const SizedBox hGapSm = SizedBox(width: sm);
  static const SizedBox hGapMd = SizedBox(width: md);
  static const SizedBox hGapLg = SizedBox(width: lg);
  static const SizedBox hGapXl = SizedBox(width: xl);
  static const SizedBox hGapXxl = SizedBox(width: xxl);

  // Vertical gaps
  static const SizedBox vGapXxs = SizedBox(height: xxs);
  static const SizedBox vGapXs = SizedBox(height: xs);
  static const SizedBox vGapSm = SizedBox(height: sm);
  static const SizedBox vGapMd = SizedBox(height: md);
  static const SizedBox vGapLg = SizedBox(height: lg);
  static const SizedBox vGapXl = SizedBox(height: xl);
  static const SizedBox vGapXxl = SizedBox(height: xxl);
  static const SizedBox vGapXxxl = SizedBox(height: xxxl);
}

