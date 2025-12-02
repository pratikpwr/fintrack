import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case to get transactions
class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<Either<Failure, List<Transaction>>> call([
    TransactionFilter filter = const TransactionFilter(),
  ]) async {
    return repository.getTransactions(filter);
  }

  /// Get transactions for a specific account
  Future<Either<Failure, List<Transaction>>> byAccount(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return repository.getTransactionsByAccount(
      accountId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Get recent transactions
  Future<Either<Failure, List<Transaction>>> recent({int limit = 10}) async {
    return repository.getRecentTransactions(limit: limit);
  }

  /// Watch transactions for changes
  Stream<List<Transaction>> watch([
    TransactionFilter filter = const TransactionFilter(),
  ]) {
    return repository.watchTransactions(filter);
  }
}

