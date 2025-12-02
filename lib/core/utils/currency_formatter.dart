import 'package:intl/intl.dart';

/// Utility class for formatting currency values in INR
class CurrencyFormatter {
  CurrencyFormatter._();

  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final _currencyFormatNoDecimals = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final _compactFormat = NumberFormat.compactCurrency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 1,
  );

  static final _numberFormat = NumberFormat.decimalPattern('en_IN');

  /// Format amount as INR currency (e.g., ₹1,23,456.78)
  static String format(double amount, {bool showDecimals = true}) {
    if (showDecimals) {
      return _currencyFormat.format(amount);
    }
    return _currencyFormatNoDecimals.format(amount);
  }

  /// Format amount in compact form (e.g., ₹1.2L, ₹5Cr)
  static String formatCompact(double amount) {
    return _compactFormat.format(amount);
  }

  /// Format number with Indian grouping (e.g., 1,23,456)
  static String formatNumber(double amount, {int decimalDigits = 0}) {
    if (decimalDigits == 0) {
      return _numberFormat.format(amount.round());
    }
    return amount.toStringAsFixed(decimalDigits);
  }

  /// Format with sign (+ or -)
  static String formatWithSign(double amount, {bool showDecimals = true}) {
    final formatted = format(amount.abs(), showDecimals: showDecimals);
    if (amount > 0) return '+$formatted';
    if (amount < 0) return '-$formatted';
    return formatted;
  }

  /// Parse currency string to double
  static double? parse(String value) {
    try {
      // Remove currency symbol and spaces
      final cleaned = value
          .replaceAll('₹', '')
          .replaceAll(',', '')
          .replaceAll(' ', '')
          .trim();
      return double.tryParse(cleaned);
    } catch (_) {
      return null;
    }
  }
}

