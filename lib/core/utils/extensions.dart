import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// Extensions for Either type from dartz
extension EitherExtensions<L, R> on Either<L, R> {
  /// Get the right value (throws if left)
  R getRight() => (this as Right<L, R>).value;

  /// Get the left value (throws if right)
  L getLeft() => (this as Left<L, R>).value;

  /// Check if this is a right (success)
  bool get isRight => fold((_) => false, (_) => true);

  /// Check if this is a left (failure)
  bool get isLeft => fold((_) => true, (_) => false);

  /// Map the right value, or return the left
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return fold(
      (l) => Left(l),
      (r) => f(r),
    );
  }

  /// Convert to Widget based on success/failure
  Widget when({
    required Widget Function(L failure) failure,
    required Widget Function(R data) success,
  }) {
    return fold(
      (l) => failure(l),
      (r) => success(r),
    );
  }
}

/// Extensions for String
extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalized).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string contains only digits
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Truncate string to max length with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }
}

/// Extensions for DateTime
extension DateTimeExtensions on DateTime {
  /// Get date only (no time)
  DateTime get dateOnly => DateTime(year, month, day);

  /// Check if same day as another date
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Check if same month as another date
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Get days until this date
  int get daysFromNow {
    return dateOnly.difference(DateTime.now().dateOnly).inDays;
  }

  /// Check if date is today
  bool get isToday => isSameDay(DateTime.now());

  /// Check if date is yesterday
  bool get isYesterday {
    return isSameDay(DateTime.now().subtract(const Duration(days: 1)));
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    return isSameDay(DateTime.now().add(const Duration(days: 1)));
  }
}

/// Extensions for double (money)
extension DoubleExtensions on double {
  /// Check if value is positive
  bool get isPositive => this > 0;

  /// Check if value is negative
  bool get isNegative => this < 0;

  /// Round to specified decimal places
  double roundTo(int places) {
    final mod = 10.0 * places;
    return (this * mod).round() / mod;
  }
}

/// Extensions for List
extension ListExtensions<T> on List<T> {
  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  /// Get element at index or null
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}

/// Extensions for BuildContext
extension BuildContextExtensions on BuildContext {
  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Get bottom padding (safe area)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Get top padding (safe area)
  double get topPadding => MediaQuery.of(this).padding.top;
}

