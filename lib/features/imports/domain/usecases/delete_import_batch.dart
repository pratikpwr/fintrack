import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/import_repository.dart';

/// Use case to delete an import batch and its transactions
class DeleteImportBatch {
  final ImportRepository repository;

  DeleteImportBatch(this.repository);

  Future<Either<Failure, void>> call(String batchId) async {
    if (batchId.isEmpty) {
      return const Left(ValidationFailure('Invalid batch ID'));
    }

    return repository.deleteImportBatch(batchId);
  }
}

