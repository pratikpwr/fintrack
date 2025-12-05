import 'package:equatable/equatable.dart';

/// Import status enumeration
enum ImportStatus {
  pending,
  processing,
  completed,
  failed,
  partiallyCompleted,
}

/// Extension for ImportStatus
extension ImportStatusExtension on ImportStatus {
  String get displayName {
    switch (this) {
      case ImportStatus.pending:
        return 'Pending';
      case ImportStatus.processing:
        return 'Processing';
      case ImportStatus.completed:
        return 'Completed';
      case ImportStatus.failed:
        return 'Failed';
      case ImportStatus.partiallyCompleted:
        return 'Partially Completed';
    }
  }
}

/// Import batch entity representing a batch of imported transactions
class ImportBatch extends Equatable {
  final String id;
  final String fileName;
  final int accountId;
  final ImportStatus status;
  final int totalRows;
  final int importedRows;
  final int skippedRows;
  final int failedRows;
  final List<String>? errors;
  final DateTime importDate;
  final DateTime createdAt;
  final DateTime? completedAt;

  const ImportBatch({
    required this.id,
    required this.fileName,
    required this.accountId,
    required this.status,
    required this.totalRows,
    this.importedRows = 0,
    this.skippedRows = 0,
    this.failedRows = 0,
    this.errors,
    required this.importDate,
    required this.createdAt,
    this.completedAt,
  });

  factory ImportBatch.create({
    required String fileName,
    required int accountId,
    required int totalRows,
  }) {
    final now = DateTime.now();
    return ImportBatch(
      id: '${now.millisecondsSinceEpoch}_${fileName.hashCode}',
      fileName: fileName,
      accountId: accountId,
      status: ImportStatus.pending,
      totalRows: totalRows,
      importDate: now,
      createdAt: now,
    );
  }

  ImportBatch copyWith({
    String? id,
    String? fileName,
    int? accountId,
    ImportStatus? status,
    int? totalRows,
    int? importedRows,
    int? skippedRows,
    int? failedRows,
    List<String>? errors,
    DateTime? importDate,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return ImportBatch(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      accountId: accountId ?? this.accountId,
      status: status ?? this.status,
      totalRows: totalRows ?? this.totalRows,
      importedRows: importedRows ?? this.importedRows,
      skippedRows: skippedRows ?? this.skippedRows,
      failedRows: failedRows ?? this.failedRows,
      errors: errors ?? this.errors,
      importDate: importDate ?? this.importDate,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Progress percentage (0-100)
  double get progress {
    if (totalRows == 0) return 0;
    return ((importedRows + skippedRows + failedRows) / totalRows) * 100;
  }

  /// Check if import is complete
  bool get isComplete =>
      status == ImportStatus.completed ||
      status == ImportStatus.failed ||
      status == ImportStatus.partiallyCompleted;

  @override
  List<Object?> get props => [
        id,
        fileName,
        accountId,
        status,
        totalRows,
        importedRows,
        skippedRows,
        failedRows,
        errors,
        importDate,
        createdAt,
        completedAt,
      ];
}

