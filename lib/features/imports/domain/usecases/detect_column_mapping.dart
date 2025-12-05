import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/import_config.dart';
import '../repositories/import_repository.dart';

/// Use case to detect column mapping from CSV headers
class DetectColumnMapping {
  final ImportRepository repository;

  DetectColumnMapping(this.repository);

  Future<Either<Failure, ColumnMapping>> call(List<String> headers) async {
    if (headers.isEmpty) {
      return const Left(ValidationFailure('No headers provided'));
    }

    return repository.detectColumnMapping(headers);
  }
}

