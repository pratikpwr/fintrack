part of 'import_bloc.dart';

/// Import wizard step
enum ImportStep { selectFile, mapColumns, preview, importing, complete }

/// State status
enum ImportStatus { initial, loading, loaded, importing, success, error }

/// State class for imports
class ImportState extends Equatable {
  final ImportStatus status;
  final ImportStep currentStep;
  final String? selectedFilePath;
  final String? selectedFileName;
  final List<String> fileHeaders;
  final ColumnMapping columnMapping;
  final List<ImportPreviewRow> previewRows;
  final int? targetAccountId;
  final ImportBatch? lastImportBatch;
  final List<ImportBatch> importHistory;
  final String? errorMessage;
  final double importProgress;

  const ImportState({
    this.status = ImportStatus.initial,
    this.currentStep = ImportStep.selectFile,
    this.selectedFilePath,
    this.selectedFileName,
    this.fileHeaders = const [],
    this.columnMapping = const ColumnMapping(),
    this.previewRows = const [],
    this.targetAccountId,
    this.lastImportBatch,
    this.importHistory = const [],
    this.errorMessage,
    this.importProgress = 0,
  });

  /// Get selected rows count
  int get selectedRowsCount =>
      previewRows.where((r) => r.isSelected && r.canImport).length;

  /// Get importable rows count
  int get importableRowsCount => previewRows.where((r) => r.canImport).length;

  /// Get rows with errors count
  int get errorRowsCount => previewRows
      .where((r) => r.validationStatus == RowValidationStatus.error)
      .length;

  /// Get duplicate rows count
  int get duplicateRowsCount => previewRows
      .where((r) => r.validationStatus == RowValidationStatus.duplicate)
      .length;

  /// Check if can proceed to import
  bool get canImport =>
      selectedRowsCount > 0 && targetAccountId != null && columnMapping.isValid;

  ImportState copyWith({
    ImportStatus? status,
    ImportStep? currentStep,
    String? selectedFilePath,
    String? selectedFileName,
    List<String>? fileHeaders,
    ColumnMapping? columnMapping,
    List<ImportPreviewRow>? previewRows,
    int? targetAccountId,
    ImportBatch? lastImportBatch,
    List<ImportBatch>? importHistory,
    String? errorMessage,
    double? importProgress,
    bool clearError = false,
    bool clearFile = false,
  }) {
    return ImportState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      selectedFilePath: clearFile
          ? null
          : selectedFilePath ?? this.selectedFilePath,
      selectedFileName: clearFile
          ? null
          : selectedFileName ?? this.selectedFileName,
      fileHeaders: clearFile ? const [] : fileHeaders ?? this.fileHeaders,
      columnMapping: clearFile
          ? const ColumnMapping()
          : columnMapping ?? this.columnMapping,
      previewRows: clearFile ? const [] : previewRows ?? this.previewRows,
      targetAccountId: targetAccountId ?? this.targetAccountId,
      lastImportBatch: lastImportBatch ?? this.lastImportBatch,
      importHistory: importHistory ?? this.importHistory,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      importProgress: importProgress ?? this.importProgress,
    );
  }

  @override
  List<Object?> get props => [
    status,
    currentStep,
    selectedFilePath,
    selectedFileName,
    fileHeaders,
    columnMapping,
    previewRows,
    targetAccountId,
    lastImportBatch,
    importHistory,
    errorMessage,
    importProgress,
  ];
}
