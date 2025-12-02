import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';

/// Filter parameters for transactions
class TransactionFilter {
  final DateTime? startDate;
  final DateTime? endDate;
  final TransactionType? type;
  final int? accountId;
  final String? categoryId;
  final int? limit;
  final int? offset;

  const TransactionFilter({
    this.startDate,
    this.endDate,
    this.type,
    this.accountId,
    this.categoryId,
    this.limit,
    this.offset,
  });
}

/// Repository interface for transaction operations
abstract class TransactionRepository {
  /// Get transactions with optional filters
  Future<Either<Failure, List<Transaction>>> getTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]);

  /// Get transactions for a specific account
  Future<Either<Failure, List<Transaction>>> getTransactionsByAccount(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get a single transaction by ID
  Future<Either<Failure, Transaction>> getTransaction(int id);

  /// Create a new transaction
  Future<Either<Failure, Transaction>> createTransaction(
    Transaction transaction,
  );

  /// Update an existing transaction
  Future<Either<Failure, Transaction>> updateTransaction(
    Transaction transaction,
  );

  /// Delete a transaction
  Future<Either<Failure, Unit>> deleteTransaction(int id);

  /// Get total income for a date range
  Future<Either<Failure, double>> getTotalIncome({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get total expenses for a date range
  Future<Either<Failure, double>> getTotalExpenses({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get recent transactions
  Future<Either<Failure, List<Transaction>>> getRecentTransactions({
    int limit = 10,
  });

  /// Watch transactions for changes
  Stream<List<Transaction>> watchTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]);
}
