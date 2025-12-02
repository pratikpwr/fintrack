import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case to create a new account
class CreateAccount {
  final AccountRepository repository;

  CreateAccount(this.repository);

  Future<Either<Failure, Account>> call(Account account) async {
    // Validate account
    if (account.name.trim().isEmpty) {
      return const Left(ValidationFailure('Account name is required'));
    }
    return repository.createAccount(account);
  }
}

