import 'package:isar/isar.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

/// Local data source for transaction operations
abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]);
  Future<List<TransactionModel>> getTransactionsByAccount(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<TransactionModel> getTransaction(int id);
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(int id);
  Future<double> getTotalIncome({
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<double> getTotalExpenses({
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<List<TransactionModel>> getRecentTransactions({int limit = 10});
  Stream<List<TransactionModel>> watchTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]);
}

/// Implementation of TransactionLocalDataSource using Isar
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Isar isar;

  TransactionLocalDataSourceImpl({required this.isar});

  @override
  Future<List<TransactionModel>> getTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]) async {
    try {
      var query = isar.transactionModels.where();

      // Get all transactions and filter in memory for flexibility
      var allTransactions = await query.findAll();

      // Apply filters
      var results = allTransactions.where((t) {
        if (filter.startDate != null && t.date.isBefore(filter.startDate!)) {
          return false;
        }
        if (filter.endDate != null && t.date.isAfter(filter.endDate!)) {
          return false;
        }
        if (filter.type != null && t.type != filter.type) {
          return false;
        }
        if (filter.accountId != null && t.accountId != filter.accountId) {
          return false;
        }
        return true;
      }).toList();

      // Sort by date descending
      results.sort((a, b) => b.date.compareTo(a.date));

      if (filter.limit != null) {
        final offset = filter.offset ?? 0;
        return results.skip(offset).take(filter.limit!).toList();
      }

      return results;
    } catch (e) {
      throw DatabaseException('Failed to fetch transactions: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByAccount(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = isar.transactionModels
          .filter()
          .accountIdEqualTo(accountId)
          .or()
          .toAccountIdEqualTo(accountId);

      if (startDate != null) {
        query = query.dateGreaterThan(startDate);
      }
      if (endDate != null) {
        query = query.dateLessThan(endDate);
      }

      return await query.sortByDateDesc().findAll();
    } catch (e) {
      throw DatabaseException('Failed to fetch account transactions: $e');
    }
  }

  @override
  Future<TransactionModel> getTransaction(int id) async {
    try {
      final transaction = await isar.transactionModels.get(id);
      if (transaction == null) {
        throw const NotFoundException('Transaction not found');
      }
      return transaction;
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw DatabaseException('Failed to fetch transaction: $e');
    }
  }

  @override
  Future<TransactionModel> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      await isar.writeTxn(() async {
        await isar.transactionModels.put(transaction);
      });
      return transaction;
    } catch (e) {
      throw DatabaseException('Failed to create transaction: $e');
    }
  }

  @override
  Future<TransactionModel> updateTransaction(
    TransactionModel transaction,
  ) async {
    try {
      await isar.writeTxn(() async {
        await isar.transactionModels.put(transaction);
      });
      return transaction;
    } catch (e) {
      throw DatabaseException('Failed to update transaction: $e');
    }
  }

  @override
  Future<void> deleteTransaction(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.transactionModels.delete(id);
      });
    } catch (e) {
      throw DatabaseException('Failed to delete transaction: $e');
    }
  }

  @override
  Future<double> getTotalIncome({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final transactions = await isar.transactionModels
          .filter()
          .typeEqualTo(TransactionType.income)
          .dateBetween(startDate, endDate)
          .findAll();

      double total = 0.0;
      for (final transaction in transactions) {
        total += transaction.amount;
      }
      return total;
    } catch (e) {
      throw DatabaseException('Failed to calculate total income: $e');
    }
  }

  @override
  Future<double> getTotalExpenses({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final transactions = await isar.transactionModels
          .filter()
          .typeEqualTo(TransactionType.expense)
          .dateBetween(startDate, endDate)
          .findAll();

      double total = 0.0;
      for (final transaction in transactions) {
        total += transaction.amount;
      }
      return total;
    } catch (e) {
      throw DatabaseException('Failed to calculate total expenses: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getRecentTransactions({int limit = 10}) async {
    try {
      return await isar.transactionModels
          .where()
          .sortByDateDesc()
          .limit(limit)
          .findAll();
    } catch (e) {
      throw DatabaseException('Failed to fetch recent transactions: $e');
    }
  }

  @override
  Stream<List<TransactionModel>> watchTransactions([
    TransactionFilter filter = const TransactionFilter(),
  ]) {
    return isar.transactionModels.where().sortByDateDesc().watch(
      fireImmediately: true,
    );
  }
}
