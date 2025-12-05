import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';

import '../../../../core/error/failures.dart';
import '../../../transactions/data/models/transaction_model.dart';
import '../../domain/entities/import_batch.dart';
import '../../domain/entities/import_config.dart';
import '../../domain/entities/import_preview_row.dart';
import '../../domain/repositories/import_repository.dart';
import '../datasources/import_local_datasource.dart';
import '../models/import_batch_model.dart';
import '../models/import_config_model.dart';

/// Implementation of ImportRepository
class ImportRepositoryImpl implements ImportRepository {
  final ImportLocalDataSource localDataSource;
  final Isar isar;

  ImportRepositoryImpl({
    required this.localDataSource,
    required this.isar,
  });

  @override
  Future<Either<Failure, List<ImportPreviewRow>>> parseFile({
    required String filePath,
    required ColumnMapping columnMapping,
  }) async {
    try {
      final rows = await localDataSource.parseFile(
        filePath: filePath,
        columnMapping: columnMapping,
      );
      return Right(rows);
    } catch (e) {
      return Left(FileFailure('Failed to parse file: $e'));
    }
  }

  @override
  Future<Either<Failure, ImportBatch>> importTransactions({
    required List<ImportPreviewRow> rows,
    required int accountId,
    required String fileName,
  }) async {
    try {
      // Create import batch
      var batch = ImportBatch.create(
        fileName: fileName,
        accountId: accountId,
        totalRows: rows.length,
      );

      // Save initial batch
      var batchModel = ImportBatchModel.fromDomain(batch);
      batchModel = await localDataSource.saveImportBatch(batchModel);
      batch = batchModel.toDomain();

      int importedCount = 0;
      int skippedCount = 0;
      int failedCount = 0;
      final errors = <String>[];

      // Import transactions
      await isar.writeTxn(() async {
        for (final row in rows) {
          if (!row.isSelected) {
            skippedCount++;
            continue;
          }

          if (!row.canImport) {
            failedCount++;
            errors.add('Row ${row.rowNumber}: Cannot import - invalid data');
            continue;
          }

          try {
            final transaction = row.toTransaction(
              accountId: accountId,
              importBatchId: batch.id,
            );

            if (transaction != null) {
              final model = TransactionModel.fromDomain(transaction);
              await isar.transactionModels.put(model);
              importedCount++;
            } else {
              failedCount++;
              errors.add('Row ${row.rowNumber}: Failed to create transaction');
            }
          } catch (e) {
            failedCount++;
            errors.add('Row ${row.rowNumber}: $e');
          }
        }
      });

      // Determine final status
      ImportStatus finalStatus;
      if (failedCount == 0 && skippedCount == 0) {
        finalStatus = ImportStatus.completed;
      } else if (importedCount == 0) {
        finalStatus = ImportStatus.failed;
      } else {
        finalStatus = ImportStatus.partiallyCompleted;
      }

      // Update batch with results
      batch = batch.copyWith(
        status: finalStatus,
        importedRows: importedCount,
        skippedRows: skippedCount,
        failedRows: failedCount,
        errors: errors.isNotEmpty ? errors : null,
        completedAt: DateTime.now(),
      );

      batchModel = ImportBatchModel.fromDomain(batch);
      await localDataSource.saveImportBatch(batchModel);

      return Right(batch);
    } catch (e) {
      return Left(ImportFailure('Failed to import transactions: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ImportBatch>>> getImportHistory() async {
    try {
      final models = await localDataSource.getImportBatches();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get import history: $e'));
    }
  }

  @override
  Future<Either<Failure, ImportBatch>> getImportBatch(String id) async {
    try {
      final model = await localDataSource.getImportBatchById(id);
      if (model == null) {
        return const Left(NotFoundFailure('Import batch not found'));
      }
      return Right(model.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get import batch: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteImportBatch(String batchId) async {
    try {
      // Delete associated transactions
      await isar.writeTxn(() async {
        await isar.transactionModels
            .filter()
            .importBatchIdEqualTo(batchId)
            .deleteAll();
      });

      // Delete batch record
      await localDataSource.deleteImportBatch(batchId);

      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete import batch: $e'));
    }
  }

  @override
  Future<Either<Failure, ImportConfig>> saveImportConfig(
    ImportConfig config,
  ) async {
    try {
      final model = ImportConfigModel.fromDomain(config);
      final saved = await localDataSource.saveImportConfig(model);
      return Right(saved.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to save import config: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ImportConfig>>> getImportConfigs() async {
    try {
      final models = await localDataSource.getImportConfigs();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get import configs: $e'));
    }
  }

  @override
  Future<Either<Failure, ImportConfig>> getImportConfig(int id) async {
    try {
      final model = await localDataSource.getImportConfigById(id);
      if (model == null) {
        return const Left(NotFoundFailure('Import config not found'));
      }
      return Right(model.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get import config: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteImportConfig(int id) async {
    try {
      await localDataSource.deleteImportConfig(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete import config: $e'));
    }
  }

  @override
  Future<Either<Failure, ColumnMapping>> detectColumnMapping(
    List<String> headers,
  ) async {
    try {
      final mapping = localDataSource.detectColumnMapping(headers);
      return Right(mapping);
    } catch (e) {
      return Left(ImportFailure('Failed to detect column mapping: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ImportPreviewRow>>> validateForDuplicates(
    List<ImportPreviewRow> rows,
    int accountId,
  ) async {
    try {
      final updatedRows = <ImportPreviewRow>[];

      for (final row in rows) {
        if (!row.canImport) {
          updatedRows.add(row);
          continue;
        }

        // Check for duplicates in database
        final existingTransactions = await isar.transactionModels
            .filter()
            .accountIdEqualTo(accountId)
            .and()
            .dateEqualTo(row.parsedDate!)
            .and()
            .amountEqualTo(row.parsedAmount!.abs())
            .findAll();

        if (existingTransactions.isNotEmpty) {
          updatedRows.add(row.copyWith(
            validationStatus: RowValidationStatus.duplicate,
            validationMessages: [
              ...row.validationMessages,
              'Possible duplicate transaction found',
            ],
          ));
        } else {
          updatedRows.add(row);
        }
      }

      return Right(updatedRows);
    } catch (e) {
      return Left(DatabaseFailure('Failed to validate for duplicates: $e'));
    }
  }
}

