import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/monthly_payment.dart';
import '../../domain/repositories/monthly_payment_repository.dart';
import '../datasources/monthly_payment_local_datasource.dart';
import '../models/monthly_payment_model.dart';

/// Implementation of MonthlyPaymentRepository
class MonthlyPaymentRepositoryImpl implements MonthlyPaymentRepository {
  final MonthlyPaymentLocalDataSource localDataSource;

  MonthlyPaymentRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<MonthlyPayment>>> getMonthlyPayments({
    bool includeInactive = false,
  }) async {
    try {
      final models = await localDataSource.getMonthlyPayments(
        includeInactive: includeInactive,
      );
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get monthly payments: $e'));
    }
  }

  @override
  Future<Either<Failure, MonthlyPayment>> getMonthlyPaymentById(int id) async {
    try {
      final model = await localDataSource.getMonthlyPaymentById(id);
      if (model == null) {
        return const Left(NotFoundFailure('Monthly payment not found'));
      }
      return Right(model.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get monthly payment: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MonthlyPayment>>> getMonthlyPaymentsByCategory(
    PaymentCategory category,
  ) async {
    try {
      final models =
          await localDataSource.getMonthlyPaymentsByCategory(category);
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(
          DatabaseFailure('Failed to get monthly payments by category: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MonthlyPayment>>> getUpcomingPayments({
    int withinDays = 7,
  }) async {
    try {
      final models =
          await localDataSource.getUpcomingPayments(withinDays: withinDays);
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get upcoming payments: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MonthlyPayment>>> getOverduePayments() async {
    try {
      final models = await localDataSource.getOverduePayments();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get overdue payments: $e'));
    }
  }

  @override
  Future<Either<Failure, MonthlyPayment>> createMonthlyPayment(
    MonthlyPayment payment,
  ) async {
    try {
      final model = MonthlyPaymentModel.fromDomain(payment);
      final created = await localDataSource.createMonthlyPayment(model);
      return Right(created.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to create monthly payment: $e'));
    }
  }

  @override
  Future<Either<Failure, MonthlyPayment>> updateMonthlyPayment(
    MonthlyPayment payment,
  ) async {
    try {
      final model = MonthlyPaymentModel.fromDomain(payment);
      final updated = await localDataSource.updateMonthlyPayment(model);
      return Right(updated.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to update monthly payment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMonthlyPayment(int id) async {
    try {
      await localDataSource.deleteMonthlyPayment(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete monthly payment: $e'));
    }
  }

  @override
  Future<Either<Failure, MonthlyPayment>> markAsPaid(int id) async {
    try {
      final model = await localDataSource.getMonthlyPaymentById(id);
      if (model == null) {
        return const Left(NotFoundFailure('Monthly payment not found'));
      }

      final now = DateTime.now();
      model.lastPaidDate = now;

      // Calculate next due date
      final frequency = model.frequency;
      final nextMonth = now.month + frequency.monthsInterval;
      final year = now.year + (nextMonth - 1) ~/ 12;
      final month = ((nextMonth - 1) % 12) + 1;
      model.nextDueDate = DateTime(year, month, model.dueDay);
      model.updatedAt = now;

      final updated = await localDataSource.updateMonthlyPayment(model);
      return Right(updated.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to mark payment as paid: $e'));
    }
  }

  @override
  Stream<List<MonthlyPayment>> watchMonthlyPayments({
    bool includeInactive = false,
  }) {
    return localDataSource
        .watchMonthlyPayments(includeInactive: includeInactive)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }

  @override
  Future<Either<Failure, double>> getTotalMonthlyExpenses() async {
    try {
      final total = await localDataSource.getTotalMonthlyExpenses();
      return Right(total);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get total monthly expenses: $e'));
    }
  }
}

