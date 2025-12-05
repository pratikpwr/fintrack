import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/monthly_payment.dart';

/// List tile widget for displaying a monthly payment
class PaymentListTile extends StatelessWidget {
  final MonthlyPayment payment;
  final VoidCallback? onTap;
  final VoidCallback? onMarkAsPaid;

  const PaymentListTile({
    super.key,
    required this.payment,
    this.onTap,
    this.onMarkAsPaid,
  });

  IconData get _icon {
    switch (payment.category) {
      case PaymentCategory.subscription:
        return Icons.subscriptions_rounded;
      case PaymentCategory.utility:
        return Icons.bolt_rounded;
      case PaymentCategory.insurance:
        return Icons.shield_rounded;
      case PaymentCategory.loan:
        return Icons.account_balance_rounded;
      case PaymentCategory.rent:
        return Icons.home_rounded;
      case PaymentCategory.education:
        return Icons.school_rounded;
      case PaymentCategory.other:
        return Icons.payments_rounded;
    }
  }

  Color get _iconColor {
    switch (payment.category) {
      case PaymentCategory.subscription:
        return const Color(0xFF8B5CF6);
      case PaymentCategory.utility:
        return const Color(0xFFF59E0B);
      case PaymentCategory.insurance:
        return AppColors.positive;
      case PaymentCategory.loan:
        return AppColors.negative;
      case PaymentCategory.rent:
        return AppColors.info;
      case PaymentCategory.education:
        return const Color(0xFFEC4899);
      case PaymentCategory.other:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _iconColor.withOpacity(0.1),
              borderRadius: AppRadius.radiusSm,
            ),
            child: Icon(_icon, color: _iconColor, size: 22),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        payment.name,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MoneyText(
                      amount: payment.amount,
                      size: MoneyTextSize.small,
                    ),
                  ],
                ),
                AppSpacing.vGapXs,
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _buildDueStatusChip(),
                          AppSpacing.hGapXs,
                          Text(
                            payment.frequency.displayName,
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    if (onMarkAsPaid != null && (payment.isDueSoon || payment.isOverdue))
                      _buildPayButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDueStatusChip() {
    if (payment.isOverdue) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.negative.withOpacity(0.1),
          borderRadius: AppRadius.radiusXs,
        ),
        child: Text(
          'Overdue',
          style: AppTypography.caption.copyWith(
            color: AppColors.negative,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    if (payment.isDueSoon) {
      final daysLeft = payment.nextDueDate != null
          ? payment.nextDueDate!.difference(DateTime.now()).inDays
          : 0;
      final text = daysLeft == 0 ? 'Due today' : 'Due in $daysLeft days';
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFF59E0B).withOpacity(0.1),
          borderRadius: AppRadius.radiusXs,
        ),
        child: Text(
          text,
          style: AppTypography.caption.copyWith(
            color: const Color(0xFFF59E0B),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    if (payment.nextDueDate != null) {
      return Text(
        'Due: ${payment.nextDueDate!.day}/${payment.nextDueDate!.month}',
        style: AppTypography.caption,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPayButton() {
    return Material(
      color: AppColors.positive.withOpacity(0.1),
      borderRadius: AppRadius.radiusSm,
      child: InkWell(
        onTap: onMarkAsPaid,
        borderRadius: AppRadius.radiusSm,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_rounded, color: AppColors.positive, size: 16),
              const SizedBox(width: 4),
              Text(
                'Mark Paid',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.positive,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

