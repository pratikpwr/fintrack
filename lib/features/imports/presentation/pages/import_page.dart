import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../accounts/presentation/bloc/accounts_bloc.dart';
import '../../domain/entities/import_batch.dart' as batch_entity;
import '../bloc/import_bloc.dart';
import '../widgets/column_mapping_widget.dart';
import '../widgets/import_preview_table.dart';

/// Main import page
class ImportPage extends StatelessWidget {
  const ImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ImportBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<AccountsBloc>()..add(const LoadAccounts()),
        ),
      ],
      child: const ImportPageContent(),
    );
  }
}

class ImportPageContent extends StatelessWidget {
  const ImportPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportBloc, ImportState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(_getTitle(state.currentStep)),
            actions: [
              if (state.currentStep != ImportStep.selectFile)
                TextButton(
                  onPressed: () {
                    context.read<ImportBloc>().add(const ResetImport());
                  },
                  child: const Text('Cancel'),
                ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  String _getTitle(ImportStep step) {
    switch (step) {
      case ImportStep.selectFile:
        return 'Import Transactions';
      case ImportStep.mapColumns:
        return 'Map Columns';
      case ImportStep.preview:
        return 'Preview Import';
      case ImportStep.importing:
        return 'Importing...';
      case ImportStep.complete:
        return 'Import Complete';
    }
  }

  Widget _buildBody(BuildContext context, ImportState state) {
    switch (state.currentStep) {
      case ImportStep.selectFile:
        return _buildSelectFileStep(context, state);
      case ImportStep.mapColumns:
        return _buildMapColumnsStep(context, state);
      case ImportStep.preview:
        return _buildPreviewStep(context, state);
      case ImportStep.importing:
        return _buildImportingStep(context, state);
      case ImportStep.complete:
        return _buildCompleteStep(context, state);
    }
  }

  Widget _buildSelectFileStep(BuildContext context, ImportState state) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // File picker card
          AppCard(
            onTap: () => context.read<ImportBloc>().add(const PickFile()),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.accentSurface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.upload_file_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                  AppSpacing.vGapMd,
                  Text(
                    'Select CSV File',
                    style: AppTypography.headingSmall,
                  ),
                  AppSpacing.vGapXs,
                  Text(
                    'Tap to browse for a CSV file',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          AppSpacing.vGapLg,

          // Supported formats
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Supported Formats', style: AppTypography.labelMedium),
                AppSpacing.vGapMd,
                _buildFormatItem('CSV files (.csv)'),
                _buildFormatItem('Bank statement exports'),
                _buildFormatItem('Excel exports (save as CSV)'),
              ],
            ),
          ),

          if (state.errorMessage != null) ...[
            AppSpacing.vGapMd,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.negative.withOpacity(0.1),
                borderRadius: AppRadius.radiusMd,
              ),
              child: Row(
                children: [
                  Icon(Icons.error_rounded, color: AppColors.negative, size: 20),
                  AppSpacing.hGapSm,
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.negative,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFormatItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_rounded, color: AppColors.positive, size: 18),
          AppSpacing.hGapSm,
          Text(text, style: AppTypography.bodySmall),
        ],
      ),
    );
  }

  Widget _buildMapColumnsStep(BuildContext context, ImportState state) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File info
                AppCard(
                  child: Row(
                    children: [
                      Icon(Icons.insert_drive_file_rounded,
                          color: AppColors.accent),
                      AppSpacing.hGapMd,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.selectedFileName ?? 'Unknown file',
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${state.fileHeaders.length} columns detected',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                AppSpacing.vGapLg,

                // Column mapping
                Text('Map Columns', style: AppTypography.headingSmall),
                AppSpacing.vGapXs,
                Text(
                  'Match the CSV columns to transaction fields',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                AppSpacing.vGapMd,

                ColumnMappingWidget(
                  headers: state.fileHeaders,
                  mapping: state.columnMapping,
                  onMappingChanged: (mapping) {
                    context
                        .read<ImportBloc>()
                        .add(UpdateColumnMapping(mapping));
                  },
                ),
              ],
            ),
          ),
        ),

        // Bottom button
        Container(
          padding: AppSpacing.pagePadding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: AppButton(
            label: 'Continue',
            onPressed: state.columnMapping.isValid
                ? () {
                    context.read<ImportBloc>().add(ParseFile(
                          filePath: state.selectedFilePath!,
                          columnMapping: state.columnMapping,
                        ));
                  }
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewStep(BuildContext context, ImportState state) {
    return Column(
      children: [
        // Account selector
        Padding(
          padding: AppSpacing.pagePadding,
          child: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, accountsState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Import to Account', style: AppTypography.labelMedium),
                  AppSpacing.vGapXs,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.radiusMd,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: state.targetAccountId,
                        isExpanded: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        dropdownColor: AppColors.surface,
                        borderRadius: AppRadius.radiusMd,
                        hint: Text('Select account',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textTertiary)),
                        items: accountsState.accounts
                            .where((a) => !a.isArchived)
                            .map((account) {
                          return DropdownMenuItem(
                            value: account.id,
                            child: Text(
                              account.name,
                              style: AppTypography.bodyMedium,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<ImportBloc>()
                                .add(SetTargetAccount(value));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // Stats
        Padding(
          padding: AppSpacing.pageHorizontal,
          child: Row(
            children: [
              _buildStatChip(
                '${state.selectedRowsCount}',
                'Selected',
                AppColors.accent,
              ),
              AppSpacing.hGapSm,
              _buildStatChip(
                '${state.importableRowsCount}',
                'Valid',
                AppColors.positive,
              ),
              if (state.errorRowsCount > 0) ...[
                AppSpacing.hGapSm,
                _buildStatChip(
                  '${state.errorRowsCount}',
                  'Errors',
                  AppColors.negative,
                ),
              ],
              if (state.duplicateRowsCount > 0) ...[
                AppSpacing.hGapSm,
                _buildStatChip(
                  '${state.duplicateRowsCount}',
                  'Duplicates',
                  const Color(0xFFF59E0B),
                ),
              ],
            ],
          ),
        ),

        AppSpacing.vGapMd,

        // Preview table
        Expanded(
          child: ImportPreviewTable(
            rows: state.previewRows,
            onToggleSelection: (index) {
              context.read<ImportBloc>().add(ToggleRowSelection(index));
            },
            onSelectAll: (selected) {
              context.read<ImportBloc>().add(SelectAllRows(selected));
            },
          ),
        ),

        // Bottom button
        Container(
          padding: AppSpacing.pagePadding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: AppButton(
            label: 'Import ${state.selectedRowsCount} Transactions',
            onPressed: state.canImport
                ? () => context.read<ImportBloc>().add(const ExecuteImport())
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.radiusSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTypography.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSpacing.hGapXs,
          Text(
            label,
            style: AppTypography.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildImportingStep(BuildContext context, ImportState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          AppSpacing.vGapLg,
          Text(
            'Importing transactions...',
            style: AppTypography.bodyLarge,
          ),
          AppSpacing.vGapXs,
          Text(
            'Please wait while we process your file',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteStep(BuildContext context, ImportState state) {
    final batch = state.lastImportBatch;
    final isSuccess = batch?.status == batch_entity.ImportStatus.completed;

    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: (isSuccess ? AppColors.positive : const Color(0xFFF59E0B))
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSuccess ? Icons.check_circle_rounded : Icons.warning_rounded,
              color: isSuccess ? AppColors.positive : const Color(0xFFF59E0B),
              size: 40,
            ),
          ),
          AppSpacing.vGapLg,
          Text(
            isSuccess ? 'Import Complete!' : 'Import Partially Complete',
            style: AppTypography.headingMedium,
          ),
          AppSpacing.vGapSm,
          if (batch != null) ...[
            Text(
              '${batch.importedRows} transactions imported',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.positive,
              ),
            ),
            if (batch.skippedRows > 0)
              Text(
                '${batch.skippedRows} skipped',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            if (batch.failedRows > 0)
              Text(
                '${batch.failedRows} failed',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.negative,
                ),
              ),
          ],
          AppSpacing.vGapXl,
          AppButton(
            label: 'Done',
            onPressed: () => Navigator.of(context).pop(),
          ),
          AppSpacing.vGapMd,
          TextButton(
            onPressed: () {
              context.read<ImportBloc>().add(const ResetImport());
            },
            child: const Text('Import Another File'),
          ),
        ],
      ),
    );
  }
}

