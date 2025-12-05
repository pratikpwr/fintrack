import 'dart:io';

import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/import_batch.dart';
import '../../domain/entities/import_config.dart';
import '../../domain/entities/import_preview_row.dart';
import '../../domain/usecases/delete_import_batch.dart';
import '../../domain/usecases/get_import_history.dart';
import '../../domain/usecases/import_transactions.dart';
import '../../domain/usecases/parse_csv_file.dart';

part 'import_event.dart';
part 'import_state.dart';

/// Bloc for managing import operations
class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final ParseCsvFile parseCsvFile;
  final ImportTransactions importTransactions;
  final GetImportHistory getImportHistory;
  final DeleteImportBatch deleteImportBatch;

  ImportBloc({
    required this.parseCsvFile,
    required this.importTransactions,
    required this.getImportHistory,
    required this.deleteImportBatch,
  }) : super(const ImportState()) {
    on<PickFile>(_onPickFile);
    on<ParseFile>(_onParseFile);
    on<UpdateColumnMapping>(_onUpdateColumnMapping);
    on<ToggleRowSelection>(_onToggleRowSelection);
    on<SelectAllRows>(_onSelectAllRows);
    on<SetTargetAccount>(_onSetTargetAccount);
    on<ExecuteImport>(_onExecuteImport);
    on<LoadImportHistory>(_onLoadImportHistory);
    on<DeleteImportBatchEvent>(_onDeleteImportBatch);
    on<ResetImport>(_onResetImport);
  }

  Future<void> _onPickFile(
    PickFile event,
    Emitter<ImportState> emit,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final fileName = result.files.single.name;

        // Read headers
        final file = File(filePath);
        final content = await file.readAsString();
        final rows = const CsvToListConverter().convert(content);

        if (rows.isNotEmpty) {
          final headers = rows.first.map((e) => e.toString()).toList();

          // Auto-detect column mapping
          final detectedMapping = _detectColumnMapping(headers);

          emit(state.copyWith(
            selectedFilePath: filePath,
            selectedFileName: fileName,
            fileHeaders: headers,
            columnMapping: detectedMapping,
            currentStep: ImportStep.mapColumns,
            clearError: true,
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: ImportStatus.error,
        errorMessage: 'Failed to pick file: $e',
      ));
    }
  }

  Future<void> _onParseFile(
    ParseFile event,
    Emitter<ImportState> emit,
  ) async {
    emit(state.copyWith(status: ImportStatus.loading, clearError: true));

    final result = await parseCsvFile(ParseCsvFileParams(
      filePath: event.filePath,
      columnMapping: event.columnMapping,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: ImportStatus.error,
        errorMessage: failure.message,
      )),
      (rows) => emit(state.copyWith(
        status: ImportStatus.loaded,
        previewRows: rows,
        currentStep: ImportStep.preview,
      )),
    );
  }

  void _onUpdateColumnMapping(
    UpdateColumnMapping event,
    Emitter<ImportState> emit,
  ) {
    emit(state.copyWith(columnMapping: event.columnMapping));
  }

  void _onToggleRowSelection(
    ToggleRowSelection event,
    Emitter<ImportState> emit,
  ) {
    if (event.rowIndex < 0 || event.rowIndex >= state.previewRows.length) return;

    final updatedRows = List<ImportPreviewRow>.from(state.previewRows);
    updatedRows[event.rowIndex] = updatedRows[event.rowIndex].copyWith(
      isSelected: !updatedRows[event.rowIndex].isSelected,
    );

    emit(state.copyWith(previewRows: updatedRows));
  }

  void _onSelectAllRows(
    SelectAllRows event,
    Emitter<ImportState> emit,
  ) {
    final updatedRows = state.previewRows
        .map((r) => r.copyWith(isSelected: event.selected))
        .toList();

    emit(state.copyWith(previewRows: updatedRows));
  }

  void _onSetTargetAccount(
    SetTargetAccount event,
    Emitter<ImportState> emit,
  ) {
    emit(state.copyWith(targetAccountId: event.accountId));
  }

  Future<void> _onExecuteImport(
    ExecuteImport event,
    Emitter<ImportState> emit,
  ) async {
    if (!state.canImport) return;

    emit(state.copyWith(
      status: ImportStatus.importing,
      currentStep: ImportStep.importing,
      clearError: true,
    ));

    final result = await importTransactions(ImportTransactionsParams(
      rows: state.previewRows,
      accountId: state.targetAccountId!,
      fileName: state.selectedFileName ?? 'import.csv',
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: ImportStatus.error,
        errorMessage: failure.message,
        currentStep: ImportStep.preview,
      )),
      (batch) => emit(state.copyWith(
        status: ImportStatus.success,
        lastImportBatch: batch,
        currentStep: ImportStep.complete,
      )),
    );
  }

  Future<void> _onLoadImportHistory(
    LoadImportHistory event,
    Emitter<ImportState> emit,
  ) async {
    emit(state.copyWith(status: ImportStatus.loading, clearError: true));

    final result = await getImportHistory();

    result.fold(
      (failure) => emit(state.copyWith(
        status: ImportStatus.error,
        errorMessage: failure.message,
      )),
      (history) => emit(state.copyWith(
        status: ImportStatus.loaded,
        importHistory: history,
      )),
    );
  }

  Future<void> _onDeleteImportBatch(
    DeleteImportBatchEvent event,
    Emitter<ImportState> emit,
  ) async {
    emit(state.copyWith(status: ImportStatus.loading, clearError: true));

    final result = await deleteImportBatch(event.batchId);

    result.fold(
      (failure) => emit(state.copyWith(
        status: ImportStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedHistory =
            state.importHistory.where((b) => b.id != event.batchId).toList();
        emit(state.copyWith(
          status: ImportStatus.loaded,
          importHistory: updatedHistory,
        ));
      },
    );
  }

  void _onResetImport(
    ResetImport event,
    Emitter<ImportState> emit,
  ) {
    emit(const ImportState());
  }

  ColumnMapping _detectColumnMapping(List<String> headers) {
    int? dateColumn;
    int? amountColumn;
    int? descriptionColumn;
    int? typeColumn;

    for (var i = 0; i < headers.length; i++) {
      final header = headers[i].toLowerCase().trim();

      if (dateColumn == null &&
          (header.contains('date') ||
              header.contains('txn') ||
              header.contains('value'))) {
        dateColumn = i;
      }

      if (amountColumn == null &&
          (header.contains('amount') ||
              header.contains('debit') ||
              header.contains('credit') ||
              header.contains('withdrawal') ||
              header.contains('deposit'))) {
        amountColumn = i;
      }

      if (descriptionColumn == null &&
          (header.contains('description') ||
              header.contains('narration') ||
              header.contains('particulars') ||
              header.contains('remarks'))) {
        descriptionColumn = i;
      }

      if (typeColumn == null &&
          (header.contains('type') || header.contains('dr/cr'))) {
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

