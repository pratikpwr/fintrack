import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account.dart';

/// List tile widget for displaying an account
class AccountListTile extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;

  const AccountListTile({
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
    return BalanceListTile(
      title: account.name,
      balance: account.balance,
      subtitle: account.bankName ?? account.type.shortName,
      icon: _icon,
      iconColor: _iconColor,
      onTap: onTap,
      trailing: account.isArchived
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: AppRadius.radiusSm,
              ),
              child: Text(
                'Archived',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            )
          : const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
            ),
    );
  }
}

