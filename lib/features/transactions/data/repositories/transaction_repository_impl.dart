import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_datasource.dart';
import '../models/transaction_model.dart';

/// Implementation of TransactionRepository
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]) async {
    try {
      final models = await localDataSource.getTransactions(filter);
      return Right(models.map((m) => m.toDomain()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByAccount(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final models = await localDataSource.getTransactionsByAccount(
        accountId,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(models.map((m) => m.toDomain()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransaction(int id) async {
    try {
      final model = await localDataSource.getTransaction(id);
      return Right(model.toDomain());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> createTransaction(
      Transaction transaction) async {
    try {
      final model = TransactionModel.fromDomain(transaction);
      final created = await localDataSource.createTransaction(model);
      return Right(created.toDomain());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateTransaction(
      Transaction transaction) async {
    try {
      final model = TransactionModel.fromDomain(transaction);
      final updated = await localDataSource.updateTransaction(model);
      return Right(updated.toDomain());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTransaction(int id) async {
    try {
      await localDataSource.deleteTransaction(id);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalIncome({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final total = await localDataSource.getTotalIncome(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(total);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalExpenses({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final total = await localDataSource.getTotalExpenses(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(total);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getRecentTransactions({
    int limit = 10,
  }) async {
    try {
      final models = await localDataSource.getRecentTransactions(limit: limit);
      return Right(models.map((m) => m.toDomain()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<List<Transaction>> watchTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]) {
    return localDataSource
        .watchTransactions(filter)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }
}

