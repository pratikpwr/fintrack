import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../bloc/investments_bloc.dart';

/// Summary card showing total investment portfolio value
class InvestmentSummaryCard extends StatelessWidget {
  final InvestmentsState state;

  const InvestmentSummaryCard({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio Value',
                style: AppTypography.caption.copyWith(color: AppColors.accent),
              ),
              _buildProfitLossChip(),
            ],
          ),
          AppSpacing.vGapXs,
          MoneyText(
            amount: state.totalCurrentValue,
            size: MoneyTextSize.large,
          ),
          AppSpacing.vGapMd,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invested',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.vGapXxs,
                    MoneyText(
                      amount: state.totalInvested,
                      size: MoneyTextSize.small,
                      style: AppTypography.moneySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profit/Loss',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.vGapXxs,
                    MoneyText(
                      amount: state.totalProfitLoss,
                      size: MoneyTextSize.small,
                      style: AppTypography.moneySmall.copyWith(
                        color: state.isProfitable
                            ? AppColors.positive
                            : AppColors.negative,
                      ),
                      showSign: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfitLossChip() {
    final isPositive = state.isProfitable;
    final color = isPositive ? AppColors.positive : AppColors.negative;
    final icon = isPositive ? Icons.trending_up : Icons.trending_down;
    final percentage = state.profitLossPercentage.abs();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.radiusSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            '${percentage.toStringAsFixed(2)}%',
            style: AppTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

