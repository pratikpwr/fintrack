import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Button size variants
enum AppButtonSize {
  small,  // 36h
  medium, // 44h
  large,  // 52h
}

/// Button variant types
enum AppButtonVariant {
  primary,   // Gold filled
  secondary, // Gold outlined
  tertiary,  // Text only
  positive,  // Green filled
  negative,  // Red filled
}

/// A styled button widget following the app design system
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isExpanded = false,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isExpanded;
  final bool isEnabled;

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32);
    }
  }

  TextStyle get _textStyle {
    switch (size) {
      case AppButtonSize.small:
        return AppTypography.buttonSmall;
      case AppButtonSize.medium:
        return AppTypography.buttonMedium;
      case AppButtonSize.large:
        return AppTypography.buttonLarge;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  Color get _backgroundColor {
    if (!isEnabled) return AppColors.surfaceLight;
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.accent;
      case AppButtonVariant.secondary:
        return Colors.transparent;
      case AppButtonVariant.tertiary:
        return Colors.transparent;
      case AppButtonVariant.positive:
        return AppColors.positive;
      case AppButtonVariant.negative:
        return AppColors.negative;
    }
  }

  Color get _foregroundColor {
    if (!isEnabled) return AppColors.textDisabled;
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.background;
      case AppButtonVariant.secondary:
        return AppColors.accent;
      case AppButtonVariant.tertiary:
        return AppColors.accent;
      case AppButtonVariant.positive:
        return AppColors.textPrimary;
      case AppButtonVariant.negative:
        return AppColors.textPrimary;
    }
  }

  BorderSide? get _borderSide {
    if (variant == AppButtonVariant.secondary) {
      return BorderSide(
        color: isEnabled ? AppColors.accent : AppColors.textDisabled,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isEnabled && !isLoading ? onPressed : null;

    Widget buttonChild = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _foregroundColor,
            ),
          ),
          AppSpacing.hGapSm,
        ] else if (icon != null) ...[
          Icon(icon, size: _iconSize),
          AppSpacing.hGapSm,
        ],
        Text(label, style: _textStyle.copyWith(color: _foregroundColor)),
      ],
    );

    return SizedBox(
      height: _height,
      width: isExpanded ? double.infinity : null,
      child: Material(
        color: _backgroundColor,
        borderRadius: size == AppButtonSize.large 
            ? AppRadius.buttonLarge 
            : AppRadius.button,
        child: InkWell(
          onTap: effectiveOnPressed,
          borderRadius: size == AppButtonSize.large 
              ? AppRadius.buttonLarge 
              : AppRadius.button,
          splashColor: AppColors.white20,
          highlightColor: AppColors.white10,
          child: Container(
            padding: _padding,
            decoration: BoxDecoration(
              borderRadius: size == AppButtonSize.large 
                  ? AppRadius.buttonLarge 
                  : AppRadius.button,
              border: _borderSide != null 
                  ? Border.fromBorderSide(_borderSide!) 
                  : null,
            ),
            child: buttonChild,
          ),
        ),
      ),
    );
  }
}

/// Icon-only button
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
    this.iconSize = 24,
    this.color,
    this.backgroundColor,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    Widget button = SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: AppRadius.radiusSm,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppRadius.radiusSm,
          splashColor: AppColors.white20,
          highlightColor: AppColors.white10,
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: color ?? AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

