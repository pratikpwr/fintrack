import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../bloc/monthly_payments_bloc.dart';

/// Summary card showing total monthly expenses
class PaymentSummaryCard extends StatelessWidget {
  final MonthlyPaymentsState state;

  const PaymentSummaryCard({
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
                'Monthly Expenses',
                style: AppTypography.caption.copyWith(color: AppColors.accent),
              ),
              if (state.overduePayments.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.negative.withOpacity(0.1),
                    borderRadius: AppRadius.radiusSm,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: AppColors.negative,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${state.overduePayments.length} overdue',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.negative,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          AppSpacing.vGapXs,
          MoneyText(
            amount: state.totalMonthlyExpenses,
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
                      'Yearly Total',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.vGapXxs,
                    MoneyText(
                      amount: state.totalYearlyExpenses,
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
                      'Upcoming (7 days)',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.vGapXxs,
                    Text(
                      '${state.upcomingPayments.length} payments',
                      style: AppTypography.bodyMedium.copyWith(
                        color: state.upcomingPayments.isNotEmpty
                            ? const Color(0xFFF59E0B)
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
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
}

