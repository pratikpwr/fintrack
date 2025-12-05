import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/investment.dart';

/// List tile widget for displaying an investment
class InvestmentListTile extends StatelessWidget {
  final Investment investment;
  final VoidCallback? onTap;

  const InvestmentListTile({
    super.key,
    required this.investment,
    this.onTap,
  });

  IconData get _icon {
    switch (investment.type) {
      case InvestmentType.stock:
        return Icons.candlestick_chart_rounded;
      case InvestmentType.mutualFund:
        return Icons.pie_chart_rounded;
      case InvestmentType.etf:
        return Icons.show_chart_rounded;
      case InvestmentType.bond:
        return Icons.account_balance_rounded;
      case InvestmentType.gold:
        return Icons.diamond_rounded;
      case InvestmentType.realEstate:
        return Icons.home_work_rounded;
      case InvestmentType.crypto:
        return Icons.currency_bitcoin_rounded;
      case InvestmentType.other:
        return Icons.savings_rounded;
    }
  }

  Color get _iconColor {
    switch (investment.type) {
      case InvestmentType.stock:
        return AppColors.info;
      case InvestmentType.mutualFund:
        return AppColors.accent;
      case InvestmentType.etf:
        return const Color(0xFF8B5CF6);
      case InvestmentType.bond:
        return AppColors.positive;
      case InvestmentType.gold:
        return const Color(0xFFEAB308);
      case InvestmentType.realEstate:
        return const Color(0xFFEC4899);
      case InvestmentType.crypto:
        return const Color(0xFFF97316);
      case InvestmentType.other:
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
                        investment.name,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MoneyText(
                      amount: investment.currentValue,
                      size: MoneyTextSize.small,
                    ),
                  ],
                ),
                AppSpacing.vGapXs,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${investment.quantity.toStringAsFixed(investment.quantity.truncateToDouble() == investment.quantity ? 0 : 2)} units • ${investment.type.shortName}',
                        style: AppTypography.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildProfitLossChip(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfitLossChip() {
    final isPositive = investment.isProfitable;
    final color = isPositive ? AppColors.positive : AppColors.negative;
    final icon = isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down;
    final percentage = investment.profitLossPercentage.abs();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.radiusXs,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

