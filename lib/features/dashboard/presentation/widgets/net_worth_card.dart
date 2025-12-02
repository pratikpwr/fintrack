import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Card displaying net worth summary
class NetWorthCard extends StatelessWidget {
  final double netWorth;
  final double totalAssets;
  final double totalLiabilities;

  const NetWorthCard({
    super.key,
    required this.netWorth,
    required this.totalAssets,
    required this.totalLiabilities,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.accent,
      padding: AppSpacing.cardPaddingLarge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Net Worth',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.accent,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.2),
                  borderRadius: AppRadius.radiusSm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: AppColors.accent,
                      size: 14,
                    ),
                    AppSpacing.hGapXxs,
                    Text(
                      'All Time',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.vGapMd,
          MoneyText(
            amount: netWorth,
            size: MoneyTextSize.large,
          ),
          AppSpacing.vGapLg,
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: 'Assets',
                  amount: totalAssets,
                  color: AppColors.positive,
                  icon: Icons.arrow_upward_rounded,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.border,
              ),
              Expanded(
                child: _SummaryItem(
                  label: 'Liabilities',
                  amount: totalLiabilities,
                  color: AppColors.negative,
                  icon: Icons.arrow_downward_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              AppSpacing.hGapXxs,
              Text(
                label,
                style: AppTypography.caption.copyWith(color: color),
              ),
            ],
          ),
          AppSpacing.vGapXxs,
          MoneyText(
            amount: amount,
            size: MoneyTextSize.small,
            compact: true,
          ),
        ],
      ),
    );
  }
}

