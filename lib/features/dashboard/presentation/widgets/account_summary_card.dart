import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../accounts/domain/entities/account.dart';

/// Small card for account summary in dashboard
class AccountSummaryCard extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;

  const AccountSummaryCard({
    super.key,
    required this.account,
    this.onTap,
  });

  IconData get _icon {
    switch (account.type) {
      case AccountType.bank:
        return Icons.account_balance_rounded;
      case AccountType.cash:
        return Icons.payments_rounded;
      case AccountType.investment:
        return Icons.trending_up_rounded;
      case AccountType.fixedDeposit:
        return Icons.lock_clock_rounded;
      case AccountType.loan:
        return Icons.receipt_long_rounded;
      case AccountType.creditCard:
        return Icons.credit_card_rounded;
      case AccountType.family:
        return Icons.family_restroom_rounded;
    }
  }

  Color get _iconColor {
    if (account.type.isLiability) return AppColors.negative;
    if (account.type == AccountType.investment) return AppColors.info;
    if (account.type == AccountType.fixedDeposit) return AppColors.positive;
    return AppColors.accent;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(
                icon: _icon,
                color: _iconColor,
                size: IconBadgeSize.small,
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ],
          ),
          const Spacer(),
          Text(
            account.name,
            style: AppTypography.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppSpacing.vGapXxs,
          Text(
            account.bankName ?? account.type.shortName,
            style: AppTypography.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppSpacing.vGapSm,
          MoneyText(
            amount: account.balance,
            size: MoneyTextSize.small,
          ),
        ],
      ),
    );
  }
}

