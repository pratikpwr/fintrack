import 'package:intl/intl.dart';

/// Utility class for formatting dates
class DateFormatter {
  DateFormatter._();

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static final _dateFormatShort = DateFormat('dd MMM');
  static final _dateFormatFull = DateFormat('EEEE, dd MMMM yyyy');
  static final _monthYearFormat = DateFormat('MMMM yyyy');
  static final _timeFormat = DateFormat('HH:mm');
  static final _dateTimeFormat = DateFormat('dd MMM yyyy, HH:mm');
  static final _isoFormat = DateFormat('yyyy-MM-dd');

  /// Format date as "dd MMM yyyy" (e.g., 25 Dec 2024)
  static String format(DateTime date) {
    return _dateFormat.format(date);
  }

  /// Format date as "dd MMM" (e.g., 25 Dec)
  static String formatShort(DateTime date) {
    return _dateFormatShort.format(date);
  }

  /// Format date as "EEEE, dd MMMM yyyy" (e.g., Wednesday, 25 December 2024)
  static String formatFull(DateTime date) {
    return _dateFormatFull.format(date);
  }

  /// Format date as "MMMM yyyy" (e.g., December 2024)
  static String formatMonthYear(DateTime date) {
    return _monthYearFormat.format(date);
  }

  /// Format time as "HH:mm" (e.g., 14:30)
  static String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }

  /// Format date and time as "dd MMM yyyy, HH:mm"
  static String formatDateTime(DateTime date) {
    return _dateTimeFormat.format(date);
  }

  /// Format date as ISO string "yyyy-MM-dd"
  static String formatIso(DateTime date) {
    return _isoFormat.format(date);
  }

  /// Get relative date string (Today, Yesterday, or date)
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    final difference = today.difference(dateOnly).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference == -1) return 'Tomorrow';
    if (difference > 0 && difference <= 7) return '$difference days ago';
    if (difference < 0 && difference >= -7) return 'In ${-difference} days';

    return format(date);
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }
}

