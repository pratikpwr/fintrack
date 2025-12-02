import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case to update an existing account
class UpdateAccount {
  final AccountRepository repository;

  UpdateAccount(this.repository);

  Future<Either<Failure, Account>> call(Account account) async {
    // Validate account
    if (account.name.trim().isEmpty) {
      return const Left(ValidationFailure('Account name is required'));
    }
    return repository.updateAccount(account);
  }

  /// Update only the balance
  Future<Either<Failure, Account>> updateBalance(
    int id,
    double newBalance,
  ) async {
    return repository.updateBalance(id, newBalance);
  }
}

