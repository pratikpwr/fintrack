import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'money_text.dart';

/// A widget to display a statistic with label and value
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.subtitle,
    this.trailing,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String label;
  final Widget value;
  final IconData? icon;
  final Color? iconColor;
  final String? subtitle;
  final Widget? trailing;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (icon != null) ...[
          Container(
            width: 40,
            height: 40,
            decoration: AppDecorations.iconBadge(
              iconColor ?? AppColors.accent,
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor ?? AppColors.accent,
            ),
          ),
          AppSpacing.hGapMd,
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTypography.caption,
              ),
              AppSpacing.vGapXxs,
              value,
              if (subtitle != null) ...[
                AppSpacing.vGapXxs,
                Text(
                  subtitle!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// A specialized stat tile for money values
class MoneyStatTile extends StatelessWidget {
  const MoneyStatTile({
    super.key,
    required this.label,
    required this.amount,
    this.icon,
    this.iconColor,
    this.subtitle,
    this.trailing,
    this.showSign = false,
    this.colorize = false,
    this.size = MoneyTextSize.medium,
  });

  final String label;
  final double amount;
  final IconData? icon;
  final Color? iconColor;
  final String? subtitle;
  final Widget? trailing;
  final bool showSign;
  final bool colorize;
  final MoneyTextSize size;

  @override
  Widget build(BuildContext context) {
    return StatTile(
      label: label,
      icon: icon,
      iconColor: iconColor,
      subtitle: subtitle,
      trailing: trailing,
      value: MoneyText(
        amount: amount,
        size: size,
        showSign: showSign,
        colorize: colorize,
      ),
    );
  }
}

