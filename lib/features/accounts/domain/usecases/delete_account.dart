import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/account_repository.dart';

/// Use case to delete or archive an account
class DeleteAccount {
  final AccountRepository repository;

  DeleteAccount(this.repository);

  /// Archive an account (soft delete)
  Future<Either<Failure, Unit>> archive(int id) async {
    return repository.archiveAccount(id);
  }

  /// Permanently delete an account
  Future<Either<Failure, Unit>> call(int id) async {
    return repository.deleteAccount(id);
  }
}

