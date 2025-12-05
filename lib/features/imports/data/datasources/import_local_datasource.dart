import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../transactions/domain/entities/transaction.dart';
import '../../domain/entities/import_config.dart';
import '../../domain/entities/import_preview_row.dart';
import '../models/import_batch_model.dart';
import '../models/import_config_model.dart';

/// Interface for import local data source
abstract class ImportLocalDataSource {
  /// Parse CSV file
  Future<List<ImportPreviewRow>> parseFile({
    required String filePath,
    required ColumnMapping columnMapping,
  });

  /// Save import batch
  Future<ImportBatchModel> saveImportBatch(ImportBatchModel batch);

  /// Get all import batches
  Future<List<ImportBatchModel>> getImportBatches();

  /// Get import batch by ID
  Future<ImportBatchModel?> getImportBatchById(String id);

  /// Delete import batch
  Future<void> deleteImportBatch(String id);

  /// Save import config
  Future<ImportConfigModel> saveImportConfig(ImportConfigModel config);

  /// Get all import configs
  Future<List<ImportConfigModel>> getImportConfigs();

  /// Get import config by ID
  Future<ImportConfigModel?> getImportConfigById(int id);

  /// Delete import config
  Future<void> deleteImportConfig(int id);

  /// Detect column mapping from headers
  ColumnMapping detectColumnMapping(List<String> headers);
}

/// Implementation of ImportLocalDataSource
class ImportLocalDataSourceImpl implements ImportLocalDataSource {
  final Isar isar;

  ImportLocalDataSourceImpl({required this.isar});

  @override
  Future<List<ImportPreviewRow>> parseFile({
    required String filePath,
    required ColumnMapping columnMapping,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found: $filePath');
    }

    final content = await file.readAsString();
    final converter = CsvToListConverter(
      fieldDelimiter: columnMapping.delimiter,
      eol: '\n',
    );
    final rows = converter.convert(content);

    if (rows.isEmpty) {
      return [];
    }

    final dataRows = columnMapping.hasHeader ? rows.skip(1).toList() : rows;
    final previewRows = <ImportPreviewRow>[];

    for (var i = 0; i < dataRows.length; i++) {
      final row = dataRows[i];
      final rawData = row.map((e) => e.toString()).toList();

      DateTime? parsedDate;
      double? parsedAmount;
      String? parsedDescription;
      TransactionType? parsedType;
      final validationMessages = <String>[];
      var validationStatus = RowValidationStatus.valid;

      // Parse date
      if (columnMapping.dateColumn != null &&
          columnMapping.dateColumn! < row.length) {
        try {
          final dateStr = row[columnMapping.dateColumn!].toString().trim();
          parsedDate = _parseDate(dateStr, columnMapping.dateFormat);
        } catch (e) {
          validationMessages.add('Invalid date format');
          validationStatus = RowValidationStatus.error;
        }
      } else {
        validationMessages.add('Date column missing');
        validationStatus = RowValidationStatus.error;
      }

      // Parse amount
      if (columnMapping.amountColumn != null &&
          columnMapping.amountColumn! < row.length) {
        try {
          final amountStr = row[columnMapping.amountColumn!]
              .toString()
              .replaceAll(',', '')
              .replaceAll('₹', '')
              .replaceAll(' ', '')
              .trim();
          parsedAmount = double.tryParse(amountStr);
          if (parsedAmount == null) {
            validationMessages.add('Invalid amount');
            validationStatus = RowValidationStatus.error;
          }
        } catch (e) {
          validationMessages.add('Invalid amount format');
          validationStatus = RowValidationStatus.error;
        }
      } else {
        validationMessages.add('Amount column missing');
        validationStatus = RowValidationStatus.error;
      }

      // Parse description
      if (columnMapping.descriptionColumn != null &&
          columnMapping.descriptionColumn! < row.length) {
        parsedDescription =
            row[columnMapping.descriptionColumn!].toString().trim();
      }

      // Parse type (or infer from amount sign)
      if (columnMapping.typeColumn != null &&
          columnMapping.typeColumn! < row.length) {
        final typeStr = row[columnMapping.typeColumn!].toString().toLowerCase();
        if (typeStr.contains('credit') || typeStr.contains('income')) {
          parsedType = TransactionType.income;
        } else if (typeStr.contains('debit') || typeStr.contains('expense')) {
          parsedType = TransactionType.expense;
        }
      }

      // Infer type from amount if not specified
      if (parsedType == null && parsedAmount != null) {
        parsedType = parsedAmount < 0
            ? TransactionType.expense
            : TransactionType.income;
      }

      previewRows.add(ImportPreviewRow(
        rowNumber: i + 1,
        rawData: rawData,
        parsedDate: parsedDate,
        parsedAmount: parsedAmount,
        parsedDescription: parsedDescription,
        parsedType: parsedType,
        validationStatus: validationStatus,
        validationMessages: validationMessages,
      ));
    }

    return previewRows;
  }

  DateTime? _parseDate(String dateStr, String format) {
    try {
      // Try common formats
      final formats = [
        format,
        'dd/MM/yyyy',
        'MM/dd/yyyy',
        'yyyy-MM-dd',
        'dd-MM-yyyy',
        'dd MMM yyyy',
        'MMM dd, yyyy',
      ];

      for (final fmt in formats) {
        try {
          return DateFormat(fmt).parse(dateStr);
        } catch (_) {
          continue;
        }
      }

      // Try parsing as Excel serial date
      final serial = double.tryParse(dateStr);
      if (serial != null) {
        return DateTime(1899, 12, 30).add(Duration(days: serial.toInt()));
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ImportBatchModel> saveImportBatch(ImportBatchModel batch) async {
    await isar.writeTxn(() async {
      batch.isarId = await isar.importBatchModels.put(batch);
    });
    return batch;
  }

  @override
  Future<List<ImportBatchModel>> getImportBatches() async {
    return isar.importBatchModels
        .where()
        .sortByImportDateDesc()
        .findAll();
  }

  @override
  Future<ImportBatchModel?> getImportBatchById(String id) async {
    return isar.importBatchModels.filter().idEqualTo(id).findFirst();
  }

  @override
  Future<void> deleteImportBatch(String id) async {
    await isar.writeTxn(() async {
      await isar.importBatchModels.filter().idEqualTo(id).deleteAll();
    });
  }

  @override
  Future<ImportConfigModel> saveImportConfig(ImportConfigModel config) async {
    await isar.writeTxn(() async {
      config.id = await isar.importConfigModels.put(config);
    });
    return config;
  }

  @override
  Future<List<ImportConfigModel>> getImportConfigs() async {
    return isar.importConfigModels.where().findAll();
  }

  @override
  Future<ImportConfigModel?> getImportConfigById(int id) async {
    return isar.importConfigModels.get(id);
  }

  @override
  Future<void> deleteImportConfig(int id) async {
    await isar.writeTxn(() async {
      await isar.importConfigModels.delete(id);
    });
  }

  @override
  ColumnMapping detectColumnMapping(List<String> headers) {
    int? dateColumn;
    int? amountColumn;
    int? descriptionColumn;
    int? typeColumn;

    for (var i = 0; i < headers.length; i++) {
      final header = headers[i].toLowerCase().trim();

      // Detect date column
      if (dateColumn == null &&
          (header.contains('date') ||
              header.contains('txn') ||
              header.contains('transaction date') ||
              header.contains('value date'))) {
        dateColumn = i;
      }

      // Detect amount column
      if (amountColumn == null &&
          (header.contains('amount') ||
              header.contains('debit') ||
              header.contains('credit') ||
              header.contains('withdrawal') ||
              header.contains('deposit'))) {
        amountColumn = i;
      }

      // Detect description column
      if (descriptionColumn == null &&
          (header.contains('description') ||
              header.contains('narration') ||
              header.contains('particulars') ||
              header.contains('remarks') ||
              header.contains('details'))) {
        descriptionColumn = i;
      }

      // Detect type column
      if (typeColumn == null &&
          (header.contains('type') ||
              header.contains('dr/cr') ||
              header.contains('transaction type'))) {
        typeColumn = i;
      }
    }

    return ColumnMapping(
      dateColumn: dateColumn,
      amountColumn: amountColumn,
      descriptionColumn: descriptionColumn,
      typeColumn: typeColumn,
    );
  }
}

