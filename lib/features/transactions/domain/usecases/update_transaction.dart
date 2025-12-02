import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case to update an existing transaction
class UpdateTransaction {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  Future<Either<Failure, Transaction>> call(Transaction transaction) async {
    // Validate transaction
    if (transaction.amount <= 0) {
      return const Left(ValidationFailure('Amount must be greater than 0'));
    }

    if (transaction.type.isTransfer && transaction.toAccountId == null) {
      return const Left(
        ValidationFailure('Transfer requires a destination account'),
      );
    }

    if (transaction.accountId == transaction.toAccountId) {
      return const Left(
        ValidationFailure('Source and destination accounts must be different'),
      );
    }

    return repository.updateTransaction(transaction);
  }
}

