import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/import_batch.dart';
import '../entities/import_config.dart';
import '../entities/import_preview_row.dart';

/// Repository interface for import operations
abstract class ImportRepository {
  /// Parse CSV file and return preview rows
  Future<Either<Failure, List<ImportPreviewRow>>> parseFile({
    required String filePath,
    required ColumnMapping columnMapping,
  });

  /// Import transactions from preview rows
  Future<Either<Failure, ImportBatch>> importTransactions({
    required List<ImportPreviewRow> rows,
    required int accountId,
    required String fileName,
  });

  /// Get import history (all batches)
  Future<Either<Failure, List<ImportBatch>>> getImportHistory();

  /// Get import batch by ID
  Future<Either<Failure, ImportBatch>> getImportBatch(String id);

  /// Delete imported transactions by batch ID
  Future<Either<Failure, void>> deleteImportBatch(String batchId);

  /// Save import configuration
  Future<Either<Failure, ImportConfig>> saveImportConfig(ImportConfig config);

  /// Get all import configurations
  Future<Either<Failure, List<ImportConfig>>> getImportConfigs();

  /// Get import config by ID
  Future<Either<Failure, ImportConfig>> getImportConfig(int id);

  /// Delete import configuration
  Future<Either<Failure, void>> deleteImportConfig(int id);

  /// Detect column mapping from CSV headers
  Future<Either<Failure, ColumnMapping>> detectColumnMapping(
    List<String> headers,
  );

  /// Validate preview rows for duplicates
  Future<Either<Failure, List<ImportPreviewRow>>> validateForDuplicates(
    List<ImportPreviewRow> rows,
    int accountId,
  );
}

