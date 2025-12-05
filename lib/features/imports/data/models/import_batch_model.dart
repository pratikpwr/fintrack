import 'package:isar/isar.dart';
import '../../domain/entities/import_batch.dart';

part 'import_batch_model.g.dart';

/// Isar collection for storing import batches
@collection
class ImportBatchModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  @Index()
  late String fileName;

  late int accountId;

  @Enumerated(EnumType.name)
  late ImportStatus status;

  late int totalRows;
  late int importedRows;
  late int skippedRows;
  late int failedRows;

  List<String>? errors;

  @Index()
  late DateTime importDate;

  late DateTime createdAt;
  DateTime? completedAt;

  /// Convert to domain entity
  ImportBatch toDomain() {
    return ImportBatch(
      id: id,
      fileName: fileName,
      accountId: accountId,
      status: status,
      totalRows: totalRows,
      importedRows: importedRows,
      skippedRows: skippedRows,
      failedRows: failedRows,
      errors: errors,
      importDate: importDate,
      createdAt: createdAt,
      completedAt: completedAt,
    );
  }

  /// Create from domain entity
  static ImportBatchModel fromDomain(ImportBatch batch) {
    return ImportBatchModel()
      ..id = batch.id
      ..fileName = batch.fileName
      ..accountId = batch.accountId
      ..status = batch.status
      ..totalRows = batch.totalRows
      ..importedRows = batch.importedRows
      ..skippedRows = batch.skippedRows
      ..failedRows = batch.failedRows
      ..errors = batch.errors
      ..importDate = batch.importDate
      ..createdAt = batch.createdAt
      ..completedAt = batch.completedAt;
  }
}

