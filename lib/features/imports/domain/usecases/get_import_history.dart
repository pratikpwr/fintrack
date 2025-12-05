import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/import_batch.dart';
import '../repositories/import_repository.dart';

/// Use case to get import history
class GetImportHistory {
  final ImportRepository repository;

  GetImportHistory(this.repository);

  Future<Either<Failure, List<ImportBatch>>> call() async {
    return repository.getImportHistory();
  }
}

