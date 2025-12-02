import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Card variant types
enum AppCardVariant {
  /// Standard card with border
  standard,
  /// Elevated card with shadow
  elevated,
  /// Accent card with gold tint
  accent,
  /// Positive card with green tint (for income, profit)
  positive,
  /// Negative card with red tint (for expense, loss)
  negative,
}

/// A styled card widget following the app design system
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.standard,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.height,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  BoxDecoration get _decoration {
    switch (variant) {
      case AppCardVariant.standard:
        return AppDecorations.card;
      case AppCardVariant.elevated:
        return AppDecorations.cardElevated;
      case AppCardVariant.accent:
        return AppDecorations.cardAccent;
      case AppCardVariant.positive:
        return AppDecorations.cardPositive;
      case AppCardVariant.negative:
        return AppDecorations.cardNegative;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      width: width,
      height: height,
      padding: padding ?? AppSpacing.cardPadding,
      decoration: _decoration,
      child: child,
    );

    if (onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          splashColor: AppColors.white10,
          highlightColor: AppColors.white10,
          child: cardContent,
        ),
      );
    }

    if (margin != null) {
      cardContent = Padding(
        padding: margin!,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

