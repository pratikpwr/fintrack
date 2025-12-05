part of 'import_bloc.dart';

/// Base event class for imports
abstract class ImportEvent extends Equatable {
  const ImportEvent();

  @override
  List<Object?> get props => [];
}

/// Pick a file to import
class PickFile extends ImportEvent {
  const PickFile();
}

/// Parse the selected file
class ParseFile extends ImportEvent {
  final String filePath;
  final ColumnMapping columnMapping;

  const ParseFile({
    required this.filePath,
    required this.columnMapping,
  });

  @override
  List<Object?> get props => [filePath, columnMapping];
}

/// Update column mapping
class UpdateColumnMapping extends ImportEvent {
  final ColumnMapping columnMapping;

  const UpdateColumnMapping(this.columnMapping);

  @override
  List<Object?> get props => [columnMapping];
}

/// Toggle row selection
class ToggleRowSelection extends ImportEvent {
  final int rowIndex;

  const ToggleRowSelection(this.rowIndex);

  @override
  List<Object?> get props => [rowIndex];
}

/// Select all rows
class SelectAllRows extends ImportEvent {
  final bool selected;

  const SelectAllRows(this.selected);

  @override
  List<Object?> get props => [selected];
}

/// Set target account
class SetTargetAccount extends ImportEvent {
  final int accountId;

  const SetTargetAccount(this.accountId);

  @override
  List<Object?> get props => [accountId];
}

/// Validate for duplicates
class ValidateForDuplicates extends ImportEvent {
  const ValidateForDuplicates();
}

/// Execute the import
class ExecuteImport extends ImportEvent {
  const ExecuteImport();
}

/// Load import history
class LoadImportHistory extends ImportEvent {
  const LoadImportHistory();
}

/// Delete an import batch
class DeleteImportBatchEvent extends ImportEvent {
  final String batchId;

  const DeleteImportBatchEvent(this.batchId);

  @override
  List<Object?> get props => [batchId];
}

/// Reset import state
class ResetImport extends ImportEvent {
  const ResetImport();
}

