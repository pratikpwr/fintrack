import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Icon badge size variants
enum IconBadgeSize {
  small,  // 32
  medium, // 44
  large,  // 56
}

/// A circular icon with a colored background
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.size = IconBadgeSize.medium,
  });

  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final IconBadgeSize size;

  double get _size {
    switch (size) {
      case IconBadgeSize.small:
        return 32;
      case IconBadgeSize.medium:
        return 44;
      case IconBadgeSize.large:
        return 56;
    }
  }

  double get _iconSize {
    switch (size) {
      case IconBadgeSize.small:
        return 16;
      case IconBadgeSize.medium:
        return 22;
      case IconBadgeSize.large:
        return 28;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.accent;
    final effectiveBgColor = backgroundColor ?? effectiveColor.withOpacity(0.15);

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: AppRadius.radiusMd,
      ),
      child: Icon(
        icon,
        size: _iconSize,
        color: effectiveColor,
      ),
    );
  }
}

/// A circular avatar with initials
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.name,
    this.color,
    this.size = IconBadgeSize.medium,
  });

  final String name;
  final Color? color;
  final IconBadgeSize size;

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  double get _size {
    switch (size) {
      case IconBadgeSize.small:
        return 32;
      case IconBadgeSize.medium:
        return 44;
      case IconBadgeSize.large:
        return 56;
    }
  }

  TextStyle get _textStyle {
    switch (size) {
      case IconBadgeSize.small:
        return AppTypography.labelSmall;
      case IconBadgeSize.medium:
        return AppTypography.labelMedium;
      case IconBadgeSize.large:
        return AppTypography.labelLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.accent;

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: effectiveColor.withOpacity(0.15),
        borderRadius: AppRadius.radiusFull,
      ),
      child: Center(
        child: Text(
          _initials,
          style: _textStyle.copyWith(color: effectiveColor),
        ),
      ),
    );
  }
}

