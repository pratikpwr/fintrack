import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case to get a single account by ID
class GetAccount {
  final AccountRepository repository;

  GetAccount(this.repository);

  Future<Either<Failure, Account>> call(int id) async {
    return repository.getAccount(id);
  }
}

