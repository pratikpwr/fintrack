import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';

/// Repository interface for account operations
abstract class AccountRepository {
  /// Get all accounts
  Future<Either<Failure, List<Account>>> getAccounts({
    bool includeArchived = false,
  });

  /// Get accounts by type
  Future<Either<Failure, List<Account>>> getAccountsByType(AccountType type);

  /// Get a single account by ID
  Future<Either<Failure, Account>> getAccount(int id);

  /// Create a new account
  Future<Either<Failure, Account>> createAccount(Account account);

  /// Update an existing account
  Future<Either<Failure, Account>> updateAccount(Account account);

  /// Update account balance
  Future<Either<Failure, Account>> updateBalance(int id, double newBalance);

  /// Archive an account (soft delete)
  Future<Either<Failure, Unit>> archiveAccount(int id);

  /// Delete an account permanently
  Future<Either<Failure, Unit>> deleteAccount(int id);

  /// Get total balance for all asset accounts
  Future<Either<Failure, double>> getTotalAssets();

  /// Get total balance for all liability accounts
  Future<Either<Failure, double>> getTotalLiabilities();

  /// Watch accounts for changes (stream)
  Stream<List<Account>> watchAccounts({bool includeArchived = false});
}

