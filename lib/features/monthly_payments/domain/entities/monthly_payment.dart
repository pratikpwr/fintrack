import 'package:equatable/equatable.dart';

/// Payment frequency enumeration
enum PaymentFrequency {
  monthly,
  quarterly,
  halfYearly,
  yearly,
}

/// Extension for PaymentFrequency
extension PaymentFrequencyExtension on PaymentFrequency {
  String get displayName {
    switch (this) {
      case PaymentFrequency.monthly:
        return 'Monthly';
      case PaymentFrequency.quarterly:
        return 'Quarterly';
      case PaymentFrequency.halfYearly:
        return 'Half Yearly';
      case PaymentFrequency.yearly:
        return 'Yearly';
    }
  }

  int get monthsInterval {
    switch (this) {
      case PaymentFrequency.monthly:
        return 1;
      case PaymentFrequency.quarterly:
        return 3;
      case PaymentFrequency.halfYearly:
        return 6;
      case PaymentFrequency.yearly:
        return 12;
    }
  }
}

/// Payment category enumeration
enum PaymentCategory {
  subscription,
  utility,
  insurance,
  loan,
  rent,
  education,
  other,
}

/// Extension for PaymentCategory
extension PaymentCategoryExtension on PaymentCategory {
  String get displayName {
    switch (this) {
      case PaymentCategory.subscription:
        return 'Subscription';
      case PaymentCategory.utility:
        return 'Utility';
      case PaymentCategory.insurance:
        return 'Insurance';
      case PaymentCategory.loan:
        return 'Loan/EMI';
      case PaymentCategory.rent:
        return 'Rent';
      case PaymentCategory.education:
        return 'Education';
      case PaymentCategory.other:
        return 'Other';
    }
  }

  String get shortName {
    switch (this) {
      case PaymentCategory.subscription:
        return 'Sub';
      case PaymentCategory.utility:
        return 'Utility';
      case PaymentCategory.insurance:
        return 'Insurance';
      case PaymentCategory.loan:
        return 'Loan';
      case PaymentCategory.rent:
        return 'Rent';
      case PaymentCategory.education:
        return 'Edu';
      case PaymentCategory.other:
        return 'Other';
    }
  }
}

/// Monthly payment entity representing a recurring payment
class MonthlyPayment extends Equatable {
  final int id;
  final String name;
  final double amount;
  final PaymentCategory category;
  final PaymentFrequency frequency;
  final int dueDay;
  final int? linkedAccountId;
  final String? description;
  final bool isActive;
  final bool autoDebit;
  final DateTime? lastPaidDate;
  final DateTime? nextDueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MonthlyPayment({
    required this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.frequency,
    required this.dueDay,
    this.linkedAccountId,
    this.description,
    this.isActive = true,
    this.autoDebit = false,
    this.lastPaidDate,
    this.nextDueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Check if payment is due soon (within 7 days)
  bool get isDueSoon {
    if (nextDueDate == null) return false;
    final now = DateTime.now();
    final difference = nextDueDate!.difference(now).inDays;
    return difference >= 0 && difference <= 7;
  }

  /// Check if payment is overdue
  bool get isOverdue {
    if (nextDueDate == null) return false;
    return nextDueDate!.isBefore(DateTime.now());
  }

  /// Calculate next due date from current date
  DateTime calculateNextDueDate() {
    final now = DateTime.now();
    var nextDate = DateTime(now.year, now.month, dueDay);

    // If the due day has passed this month, move to next occurrence
    if (now.day > dueDay) {
      final nextMonth = now.month + frequency.monthsInterval;
      final year = now.year + (nextMonth - 1) ~/ 12;
      final month = ((nextMonth - 1) % 12) + 1;
      nextDate = DateTime(year, month, dueDay);
    }

    return nextDate;
  }

  /// Calculate yearly cost based on frequency
  double get yearlyCost {
    return amount * (12 / frequency.monthsInterval);
  }

  /// Create a new monthly payment with default values
  factory MonthlyPayment.create({
    required String name,
    required double amount,
    required PaymentCategory category,
    PaymentFrequency frequency = PaymentFrequency.monthly,
    required int dueDay,
    int? linkedAccountId,
    String? description,
    bool autoDebit = false,
  }) {
    final now = DateTime.now();
    final payment = MonthlyPayment(
      id: 0,
      name: name,
      amount: amount,
      category: category,
      frequency: frequency,
      dueDay: dueDay,
      linkedAccountId: linkedAccountId,
      description: description,
      isActive: true,
      autoDebit: autoDebit,
      lastPaidDate: null,
      nextDueDate: null,
      createdAt: now,
      updatedAt: now,
    );
    return payment.copyWith(nextDueDate: payment.calculateNextDueDate());
  }

  /// Create a copy with updated fields
  MonthlyPayment copyWith({
    int? id,
    String? name,
    double? amount,
    PaymentCategory? category,
    PaymentFrequency? frequency,
    int? dueDay,
    int? linkedAccountId,
    String? description,
    bool? isActive,
    bool? autoDebit,
    DateTime? lastPaidDate,
    DateTime? nextDueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MonthlyPayment(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      dueDay: dueDay ?? this.dueDay,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      autoDebit: autoDebit ?? this.autoDebit,
      lastPaidDate: lastPaidDate ?? this.lastPaidDate,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        category,
        frequency,
        dueDay,
        linkedAccountId,
        description,
        isActive,
        autoDebit,
        lastPaidDate,
        nextDueDate,
        createdAt,
        updatedAt,
      ];
}

