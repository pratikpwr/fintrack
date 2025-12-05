import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_payment.dart';

/// Repository interface for monthly payment operations
abstract class MonthlyPaymentRepository {
  /// Get all monthly payments
  Future<Either<Failure, List<MonthlyPayment>>> getMonthlyPayments({
    bool includeInactive = false,
  });

  /// Get monthly payment by ID
  Future<Either<Failure, MonthlyPayment>> getMonthlyPaymentById(int id);

  /// Get monthly payments by category
  Future<Either<Failure, List<MonthlyPayment>>> getMonthlyPaymentsByCategory(
    PaymentCategory category,
  );

  /// Get upcoming payments (due within days)
  Future<Either<Failure, List<MonthlyPayment>>> getUpcomingPayments({
    int withinDays = 7,
  });

  /// Get overdue payments
  Future<Either<Failure, List<MonthlyPayment>>> getOverduePayments();

  /// Create a new monthly payment
  Future<Either<Failure, MonthlyPayment>> createMonthlyPayment(
    MonthlyPayment payment,
  );

  /// Update an existing monthly payment
  Future<Either<Failure, MonthlyPayment>> updateMonthlyPayment(
    MonthlyPayment payment,
  );

  /// Delete a monthly payment
  Future<Either<Failure, void>> deleteMonthlyPayment(int id);

  /// Mark payment as paid
  Future<Either<Failure, MonthlyPayment>> markAsPaid(int id);

  /// Watch monthly payments for changes
  Stream<List<MonthlyPayment>> watchMonthlyPayments({
    bool includeInactive = false,
  });

  /// Get total monthly expenses
  Future<Either<Failure, double>> getTotalMonthlyExpenses();
}

