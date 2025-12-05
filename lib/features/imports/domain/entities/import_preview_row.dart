import 'package:equatable/equatable.dart';
import '../../../transactions/domain/entities/transaction.dart';

/// Validation status for a preview row
enum RowValidationStatus {
  valid,
  warning,
  error,
  duplicate,
}

/// Extension for RowValidationStatus
extension RowValidationStatusExtension on RowValidationStatus {
  String get displayName {
    switch (this) {
      case RowValidationStatus.valid:
        return 'Valid';
      case RowValidationStatus.warning:
        return 'Warning';
      case RowValidationStatus.error:
        return 'Error';
      case RowValidationStatus.duplicate:
        return 'Duplicate';
    }
  }
}

/// Import preview row representing a parsed row ready for import
class ImportPreviewRow extends Equatable {
  final int rowNumber;
  final List<String> rawData;
  final DateTime? parsedDate;
  final double? parsedAmount;
  final String? parsedDescription;
  final TransactionType? parsedType;
  final RowValidationStatus validationStatus;
  final List<String> validationMessages;
  final bool isSelected;

  const ImportPreviewRow({
    required this.rowNumber,
    required this.rawData,
    this.parsedDate,
    this.parsedAmount,
    this.parsedDescription,
    this.parsedType,
    this.validationStatus = RowValidationStatus.valid,
    this.validationMessages = const [],
    this.isSelected = true,
  });

  ImportPreviewRow copyWith({
    int? rowNumber,
    List<String>? rawData,
    DateTime? parsedDate,
    double? parsedAmount,
    String? parsedDescription,
    TransactionType? parsedType,
    RowValidationStatus? validationStatus,
    List<String>? validationMessages,
    bool? isSelected,
  }) {
    return ImportPreviewRow(
      rowNumber: rowNumber ?? this.rowNumber,
      rawData: rawData ?? this.rawData,
      parsedDate: parsedDate ?? this.parsedDate,
      parsedAmount: parsedAmount ?? this.parsedAmount,
      parsedDescription: parsedDescription ?? this.parsedDescription,
      parsedType: parsedType ?? this.parsedType,
      validationStatus: validationStatus ?? this.validationStatus,
      validationMessages: validationMessages ?? this.validationMessages,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  /// Check if row can be imported
  bool get canImport =>
      validationStatus != RowValidationStatus.error &&
      parsedDate != null &&
      parsedAmount != null;

  /// Convert to transaction
  Transaction? toTransaction({
    required int accountId,
    required String importBatchId,
  }) {
    if (!canImport) return null;

    return Transaction.create(
      date: parsedDate!,
      amount: parsedAmount!.abs(),
      type: parsedType ?? 
          (parsedAmount! < 0 ? TransactionType.expense : TransactionType.income),
      accountId: accountId,
      description: parsedDescription,
      source: TransactionSource.excelImport,
    ).copyWith(importBatchId: importBatchId);
  }

  @override
  List<Object?> get props => [
        rowNumber,
        rawData,
        parsedDate,
        parsedAmount,
        parsedDescription,
        parsedType,
        validationStatus,
        validationMessages,
        isSelected,
      ];
}

