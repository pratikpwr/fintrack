import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/import_batch.dart';
import '../entities/import_preview_row.dart';
import '../repositories/import_repository.dart';

/// Parameters for importing transactions
class ImportTransactionsParams {
  final List<ImportPreviewRow> rows;
  final int accountId;
  final String fileName;

  const ImportTransactionsParams({
    required this.rows,
    required this.accountId,
    required this.fileName,
  });
}

/// Use case to import transactions from preview rows
class ImportTransactions {
  final ImportRepository repository;

  ImportTransactions(this.repository);

  Future<Either<Failure, ImportBatch>> call(
    ImportTransactionsParams params,
  ) async {
    if (params.rows.isEmpty) {
      return const Left(ValidationFailure('No rows to import'));
    }

    if (params.accountId <= 0) {
      return const Left(ValidationFailure('Please select an account'));
    }

    // Filter only selected and importable rows
    final rowsToImport =
        params.rows.where((r) => r.isSelected && r.canImport).toList();

    if (rowsToImport.isEmpty) {
      return const Left(ValidationFailure('No valid rows selected for import'));
    }

    return repository.importTransactions(
      rows: rowsToImport,
      accountId: params.accountId,
      fileName: params.fileName,
    );
  }
}

