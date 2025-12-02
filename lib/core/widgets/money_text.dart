import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/theme.dart';

/// Money text size variants
enum MoneyTextSize {
  small,
  medium,
  large,
}

/// A widget to display money values with INR formatting and optional color coding
class MoneyText extends StatelessWidget {
  const MoneyText({
    super.key,
    required this.amount,
    this.size = MoneyTextSize.medium,
    this.showSign = false,
    this.colorize = false,
    this.showSymbol = true,
    this.compact = false,
    this.style,
  });

  final double amount;
  final MoneyTextSize size;
  final bool showSign;
  final bool colorize;
  final bool showSymbol;
  final bool compact;
  final TextStyle? style;

  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final _currencyFormatNoSymbol = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '',
    decimalDigits: 2,
  );

  static final _compactFormat = NumberFormat.compactCurrency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 1,
  );

  static final _compactFormatNoSymbol = NumberFormat.compactCurrency(
    locale: 'en_IN',
    symbol: '',
    decimalDigits: 1,
  );

  TextStyle get _baseStyle {
    switch (size) {
      case MoneyTextSize.small:
        return AppTypography.moneySmall;
      case MoneyTextSize.medium:
        return AppTypography.moneyMedium;
      case MoneyTextSize.large:
        return AppTypography.moneyLarge;
    }
  }

  Color? get _color {
    if (!colorize) return null;
    if (amount > 0) return AppColors.positive;
    if (amount < 0) return AppColors.negative;
    return AppColors.textPrimary;
  }

  String get _formattedAmount {
    final format = compact
        ? (showSymbol ? _compactFormat : _compactFormatNoSymbol)
        : (showSymbol ? _currencyFormat : _currencyFormatNoSymbol);

    final absAmount = amount.abs();
    String formatted = format.format(absAmount);

    if (showSign) {
      if (amount > 0) {
        formatted = '+$formatted';
      } else if (amount < 0) {
        formatted = '-$formatted';
      }
    } else if (amount < 0 && !showSign) {
      formatted = '-$formatted';
    }

    return formatted.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedAmount,
      style: (style ?? _baseStyle).copyWith(
        color: _color ?? style?.color ?? _baseStyle.color,
      ),
    );
  }
}

/// A widget to display P&L (Profit/Loss) with percentage
class PnLText extends StatelessWidget {
  const PnLText({
    super.key,
    required this.amount,
    this.percentage,
    this.size = MoneyTextSize.medium,
  });

  final double amount;
  final double? percentage;
  final MoneyTextSize size;

  @override
  Widget build(BuildContext context) {
    final isPositive = amount >= 0;
    final color = isPositive ? AppColors.positive : AppColors.negative;
    final icon = isPositive
        ? Icons.trending_up_rounded
        : Icons.trending_down_rounded;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        AppSpacing.hGapXxs,
        MoneyText(
          amount: amount,
          size: size,
          showSign: true,
          colorize: true,
        ),
        if (percentage != null) ...[
          AppSpacing.hGapXs,
          Text(
            '(${percentage! >= 0 ? '+' : ''}${percentage!.toStringAsFixed(1)}%)',
            style: AppTypography.caption.copyWith(color: color),
          ),
        ],
      ],
    );
  }
}

