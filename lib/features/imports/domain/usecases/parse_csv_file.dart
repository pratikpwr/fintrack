import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/import_config.dart';
import '../entities/import_preview_row.dart';
import '../repositories/import_repository.dart';

/// Parameters for parsing CSV file
class ParseCsvFileParams {
  final String filePath;
  final ColumnMapping columnMapping;

  const ParseCsvFileParams({
    required this.filePath,
    required this.columnMapping,
  });
}

/// Use case to parse a CSV file and return preview rows
class ParseCsvFile {
  final ImportRepository repository;

  ParseCsvFile(this.repository);

  Future<Either<Failure, List<ImportPreviewRow>>> call(
    ParseCsvFileParams params,
  ) async {
    if (params.filePath.isEmpty) {
      return const Left(ValidationFailure('File path is required'));
    }

    if (!params.columnMapping.isValid) {
      return const Left(
        ValidationFailure('Please map at least date and amount columns'),
      );
    }

    return repository.parseFile(
      filePath: params.filePath,
      columnMapping: params.columnMapping,
    );
  }
}

