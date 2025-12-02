import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'app_card.dart';
import 'icon_badge.dart';
import 'money_text.dart';

/// A card widget to display account or investment balance
class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.title,
    required this.balance,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.onTap,
    this.trailing,
    this.variant = AppCardVariant.standard,
  });

  final String title;
  final double balance;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: variant,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                IconBadge(
                  icon: icon!,
                  color: iconColor ?? AppColors.accent,
                  size: IconBadgeSize.medium,
                ),
                AppSpacing.hGapMd,
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      AppSpacing.vGapXxs,
                      Text(
                        subtitle!,
                        style: AppTypography.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          AppSpacing.vGapMd,
          MoneyText(
            amount: balance,
            size: MoneyTextSize.medium,
          ),
        ],
      ),
    );
  }
}

/// A compact balance card for lists
class BalanceListTile extends StatelessWidget {
  const BalanceListTile({
    super.key,
    required this.title,
    required this.balance,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.onTap,
    this.trailing,
    this.showBalanceSign = false,
    this.colorizeBalance = false,
  });

  final String title;
  final double balance;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showBalanceSign;
  final bool colorizeBalance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppSpacing.listItemPadding,
        child: Row(
          children: [
            if (icon != null) ...[
              IconBadge(
                icon: icon!,
                color: iconColor ?? AppColors.accent,
                size: IconBadgeSize.medium,
              ),
              AppSpacing.hGapMd,
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    AppSpacing.vGapXxs,
                    Text(
                      subtitle!,
                      style: AppTypography.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            MoneyText(
              amount: balance,
              size: MoneyTextSize.small,
              showSign: showBalanceSign,
              colorize: colorizeBalance,
            ),
            if (trailing != null) ...[
              AppSpacing.hGapSm,
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

