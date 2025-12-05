part of 'monthly_payments_bloc.dart';

/// State status enum
enum MonthlyPaymentsStatus {
  initial,
  loading,
  loaded,
  error,
}

/// State class for monthly payments
class MonthlyPaymentsState extends Equatable {
  final MonthlyPaymentsStatus status;
  final List<MonthlyPayment> payments;
  final MonthlyPayment? selectedPayment;
  final PaymentCategory? filterCategory;
  final String? errorMessage;
  final double totalMonthlyExpenses;

  const MonthlyPaymentsState({
    this.status = MonthlyPaymentsStatus.initial,
    this.payments = const [],
    this.selectedPayment,
    this.filterCategory,
    this.errorMessage,
    this.totalMonthlyExpenses = 0,
  });

  /// Get payments grouped by category
  Map<PaymentCategory, List<MonthlyPayment>> get paymentsByCategory {
    final grouped = <PaymentCategory, List<MonthlyPayment>>{};
    for (final payment in payments) {
      grouped.putIfAbsent(payment.category, () => []).add(payment);
    }
    return grouped;
  }

  /// Get filtered payments
  List<MonthlyPayment> get filteredPayments {
    if (filterCategory == null) return payments;
    return payments.where((p) => p.category == filterCategory).toList();
  }

  /// Get upcoming payments (due within 7 days)
  List<MonthlyPayment> get upcomingPayments {
    return payments.where((p) => p.isDueSoon && !p.isOverdue).toList()
      ..sort((a, b) =>
          (a.nextDueDate ?? DateTime.now()).compareTo(b.nextDueDate ?? DateTime.now()));
  }

  /// Get overdue payments
  List<MonthlyPayment> get overduePayments {
    return payments.where((p) => p.isOverdue).toList()
      ..sort((a, b) =>
          (a.nextDueDate ?? DateTime.now()).compareTo(b.nextDueDate ?? DateTime.now()));
  }

  /// Get total yearly expenses
  double get totalYearlyExpenses {
    return payments
        .where((p) => p.isActive)
        .fold(0.0, (sum, p) => sum + p.yearlyCost);
  }

  MonthlyPaymentsState copyWith({
    MonthlyPaymentsStatus? status,
    List<MonthlyPayment>? payments,
    MonthlyPayment? selectedPayment,
    PaymentCategory? filterCategory,
    String? errorMessage,
    double? totalMonthlyExpenses,
    bool clearSelectedPayment = false,
    bool clearFilterCategory = false,
    bool clearError = false,
  }) {
    return MonthlyPaymentsState(
      status: status ?? this.status,
      payments: payments ?? this.payments,
      selectedPayment: clearSelectedPayment
          ? null
          : selectedPayment ?? this.selectedPayment,
      filterCategory:
          clearFilterCategory ? null : filterCategory ?? this.filterCategory,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      totalMonthlyExpenses: totalMonthlyExpenses ?? this.totalMonthlyExpenses,
    );
  }

  @override
  List<Object?> get props => [
        status,
        payments,
        selectedPayment,
        filterCategory,
        errorMessage,
        totalMonthlyExpenses,
      ];
}

