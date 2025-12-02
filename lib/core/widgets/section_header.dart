import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A section header widget with title and optional action
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.actionLabel,
    this.onAction,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.headingSmall,
                ),
                if (subtitle != null) ...[
                  AppSpacing.vGapXxs,
                  Text(
                    subtitle!,
                    style: AppTypography.caption,
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                actionLabel!,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

