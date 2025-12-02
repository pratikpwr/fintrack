import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/transaction_repository.dart';

/// Use case to delete a transaction
class DeleteTransaction {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return repository.deleteTransaction(id);
  }
}

