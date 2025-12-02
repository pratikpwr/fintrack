import 'package:isar/isar.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/account.dart';
import '../models/account_model.dart';

/// Local data source for account operations
abstract class AccountLocalDataSource {
  Future<List<AccountModel>> getAccounts({bool includeArchived = false});
  Future<List<AccountModel>> getAccountsByType(AccountType type);
  Future<AccountModel> getAccount(int id);
  Future<AccountModel> createAccount(AccountModel account);
  Future<AccountModel> updateAccount(AccountModel account);
  Future<void> deleteAccount(int id);
  Future<double> getTotalAssets();
  Future<double> getTotalLiabilities();
  Stream<List<AccountModel>> watchAccounts({bool includeArchived = false});
}

/// Implementation of AccountLocalDataSource using Isar
class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final Isar isar;

  AccountLocalDataSourceImpl({required this.isar});

  @override
  Future<List<AccountModel>> getAccounts({bool includeArchived = false}) async {
    try {
      if (includeArchived) {
        return await isar.accountModels.where().findAll();
      }
      return await isar.accountModels
          .filter()
          .isArchivedEqualTo(false)
          .findAll();
    } catch (e) {
      throw DatabaseException('Failed to fetch accounts: $e');
    }
  }

  @override
  Future<List<AccountModel>> getAccountsByType(AccountType type) async {
    try {
      return await isar.accountModels
          .filter()
          .typeEqualTo(type)
          .isArchivedEqualTo(false)
          .findAll();
    } catch (e) {
      throw DatabaseException('Failed to fetch accounts by type: $e');
    }
  }

  @override
  Future<AccountModel> getAccount(int id) async {
    try {
      final account = await isar.accountModels.get(id);
      if (account == null) {
        throw const NotFoundException('Account not found');
      }
      return account;
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw DatabaseException('Failed to fetch account: $e');
    }
  }

  @override
  Future<AccountModel> createAccount(AccountModel account) async {
    try {
      await isar.writeTxn(() async {
        await isar.accountModels.put(account);
      });
      return account;
    } catch (e) {
      throw DatabaseException('Failed to create account: $e');
    }
  }

  @override
  Future<AccountModel> updateAccount(AccountModel account) async {
    try {
      await isar.writeTxn(() async {
        await isar.accountModels.put(account);
      });
      return account;
    } catch (e) {
      throw DatabaseException('Failed to update account: $e');
    }
  }

  @override
  Future<void> deleteAccount(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.accountModels.delete(id);
      });
    } catch (e) {
      throw DatabaseException('Failed to delete account: $e');
    }
  }

  @override
  Future<double> getTotalAssets() async {
    try {
      final accounts = await isar.accountModels
          .filter()
          .isArchivedEqualTo(false)
          .findAll();

      double total = 0.0;
      for (final account in accounts.where((a) => a.type.isAsset)) {
        total += account.balance;
      }
      return total;
    } catch (e) {
      throw DatabaseException('Failed to calculate total assets: $e');
    }
  }

  @override
  Future<double> getTotalLiabilities() async {
    try {
      final accounts = await isar.accountModels
          .filter()
          .isArchivedEqualTo(false)
          .findAll();

      double total = 0.0;
      for (final account in accounts.where((a) => a.type.isLiability)) {
        total += account.balance.abs();
      }
      return total;
    } catch (e) {
      throw DatabaseException('Failed to calculate total liabilities: $e');
    }
  }

  @override
  Stream<List<AccountModel>> watchAccounts({bool includeArchived = false}) {
    if (includeArchived) {
      return isar.accountModels.where().watch(fireImmediately: true);
    }
    return isar.accountModels
        .filter()
        .isArchivedEqualTo(false)
        .watch(fireImmediately: true);
  }
}

