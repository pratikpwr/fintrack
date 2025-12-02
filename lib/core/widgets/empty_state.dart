import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'app_button.dart';

/// A widget to display when a list or view is empty
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 64 : 80,
              height: compact ? 64 : 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: AppRadius.radiusLg,
              ),
              child: Icon(
                icon,
                size: compact ? 32 : 40,
                color: AppColors.textTertiary,
              ),
            ),
            SizedBox(height: compact ? 16 : 24),
            Text(
              title,
              style: compact 
                  ? AppTypography.headingSmall 
                  : AppTypography.headingMedium,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.vGapSm,
              Text(
                message!,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: compact ? 16 : 24),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                size: compact ? AppButtonSize.small : AppButtonSize.medium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

