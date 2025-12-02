import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/transaction.dart';

/// List tile widget for displaying a transaction
class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionListTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  IconData get _icon {
    switch (transaction.type) {
      case TransactionType.income:
        return Icons.arrow_downward_rounded;
      case TransactionType.expense:
        return Icons.arrow_upward_rounded;
      case TransactionType.transfer:
        return Icons.swap_horiz_rounded;
      case TransactionType.familyTransfer:
        return Icons.family_restroom_rounded;
      case TransactionType.investment:
        return Icons.trending_up_rounded;
      case TransactionType.loanPayment:
        return Icons.receipt_long_rounded;
      case TransactionType.adjustment:
        return Icons.tune_rounded;
    }
  }

  Color get _iconColor {
    switch (transaction.type) {
      case TransactionType.income:
        return AppColors.positive;
      case TransactionType.expense:
        return AppColors.negative;
      case TransactionType.transfer:
      case TransactionType.familyTransfer:
        return AppColors.info;
      case TransactionType.investment:
        return AppColors.accent;
      case TransactionType.loanPayment:
        return AppColors.warning;
      case TransactionType.adjustment:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusSm,
      child: Padding(
        padding: AppSpacing.listItemPadding,
        child: Row(
          children: [
            IconBadge(
              icon: _icon,
              color: _iconColor,
              size: IconBadgeSize.medium,
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description ?? transaction.type.displayName,
                    style: AppTypography.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.vGapXxs,
                  Text(
                    transaction.paymentMethod.displayName,
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            MoneyText(
              amount: transaction.signedAmount,
              size: MoneyTextSize.small,
              showSign: true,
              colorize: true,
            ),
          ],
        ),
      ),
    );
  }
}

