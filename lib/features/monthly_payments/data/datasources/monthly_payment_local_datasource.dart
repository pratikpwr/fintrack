import 'package:isar/isar.dart';
import '../../domain/entities/monthly_payment.dart';
import '../models/monthly_payment_model.dart';

/// Interface for monthly payment local data source
abstract class MonthlyPaymentLocalDataSource {
  /// Get all monthly payments
  Future<List<MonthlyPaymentModel>> getMonthlyPayments({
    bool includeInactive = false,
  });

  /// Get monthly payment by ID
  Future<MonthlyPaymentModel?> getMonthlyPaymentById(int id);

  /// Get monthly payments by category
  Future<List<MonthlyPaymentModel>> getMonthlyPaymentsByCategory(
    PaymentCategory category,
  );

  /// Get upcoming payments
  Future<List<MonthlyPaymentModel>> getUpcomingPayments({int withinDays = 7});

  /// Get overdue payments
  Future<List<MonthlyPaymentModel>> getOverduePayments();

  /// Create a new monthly payment
  Future<MonthlyPaymentModel> createMonthlyPayment(MonthlyPaymentModel payment);

  /// Update an existing monthly payment
  Future<MonthlyPaymentModel> updateMonthlyPayment(MonthlyPaymentModel payment);

  /// Delete a monthly payment
  Future<void> deleteMonthlyPayment(int id);

  /// Watch monthly payments for changes
  Stream<List<MonthlyPaymentModel>> watchMonthlyPayments({
    bool includeInactive = false,
  });

  /// Get total monthly expenses
  Future<double> getTotalMonthlyExpenses();
}

/// Implementation of MonthlyPaymentLocalDataSource using Isar
class MonthlyPaymentLocalDataSourceImpl
    implements MonthlyPaymentLocalDataSource {
  final Isar isar;

  MonthlyPaymentLocalDataSourceImpl({required this.isar});

  @override
  Future<List<MonthlyPaymentModel>> getMonthlyPayments({
    bool includeInactive = false,
  }) async {
    if (includeInactive) {
      return isar.monthlyPaymentModels.where().findAll();
    }
    return isar.monthlyPaymentModels.filter().isActiveEqualTo(true).findAll();
  }

  @override
  Future<MonthlyPaymentModel?> getMonthlyPaymentById(int id) async {
    return isar.monthlyPaymentModels.get(id);
  }

  @override
  Future<List<MonthlyPaymentModel>> getMonthlyPaymentsByCategory(
    PaymentCategory category,
  ) async {
    return isar.monthlyPaymentModels
        .filter()
        .categoryEqualTo(category)
        .and()
        .isActiveEqualTo(true)
        .findAll();
  }

  @override
  Future<List<MonthlyPaymentModel>> getUpcomingPayments({
    int withinDays = 7,
  }) async {
    final now = DateTime.now();
    final endDate = now.add(Duration(days: withinDays));

    return isar.monthlyPaymentModels
        .filter()
        .isActiveEqualTo(true)
        .and()
        .nextDueDateIsNotNull()
        .and()
        .nextDueDateGreaterThan(now.subtract(const Duration(days: 1)))
        .and()
        .nextDueDateLessThan(endDate.add(const Duration(days: 1)))
        .sortByNextDueDate()
        .findAll();
  }

  @override
  Future<List<MonthlyPaymentModel>> getOverduePayments() async {
    final now = DateTime.now();

    return isar.monthlyPaymentModels
        .filter()
        .isActiveEqualTo(true)
        .and()
        .nextDueDateIsNotNull()
        .and()
        .nextDueDateLessThan(now)
        .sortByNextDueDate()
        .findAll();
  }

  @override
  Future<MonthlyPaymentModel> createMonthlyPayment(
    MonthlyPaymentModel payment,
  ) async {
    await isar.writeTxn(() async {
      payment.id = await isar.monthlyPaymentModels.put(payment);
    });
    return payment;
  }

  @override
  Future<MonthlyPaymentModel> updateMonthlyPayment(
    MonthlyPaymentModel payment,
  ) async {
    await isar.writeTxn(() async {
      await isar.monthlyPaymentModels.put(payment);
    });
    return payment;
  }

  @override
  Future<void> deleteMonthlyPayment(int id) async {
    await isar.writeTxn(() async {
      await isar.monthlyPaymentModels.delete(id);
    });
  }

  @override
  Stream<List<MonthlyPaymentModel>> watchMonthlyPayments({
    bool includeInactive = false,
  }) {
    if (includeInactive) {
      return isar.monthlyPaymentModels.where().watch(fireImmediately: true);
    }
    return isar.monthlyPaymentModels
        .filter()
        .isActiveEqualTo(true)
        .watch(fireImmediately: true);
  }

  @override
  Future<double> getTotalMonthlyExpenses() async {
    final payments = await getMonthlyPayments();
    return payments.fold<double>(
      0,
      (sum, payment) {
        // Convert to monthly equivalent
        final monthlyAmount =
            payment.amount / payment.frequency.monthsInterval;
        return sum + monthlyAmount;
      },
    );
  }
}

