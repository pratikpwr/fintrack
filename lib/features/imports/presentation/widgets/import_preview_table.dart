import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/import_preview_row.dart';

/// Widget for displaying import preview data
class ImportPreviewTable extends StatelessWidget {
  final List<ImportPreviewRow> rows;
  final ValueChanged<int> onToggleSelection;
  final ValueChanged<bool> onSelectAll;

  const ImportPreviewTable({
    super.key,
    required this.rows,
    required this.onToggleSelection,
    required this.onSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    final allSelected = rows.every((r) => r.isSelected);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: allSelected,
                tristate: true,
                onChanged: (value) => onSelectAll(value ?? false),
                activeColor: AppColors.accent,
              ),
              Expanded(
                flex: 2,
                child: Text('Date', style: AppTypography.labelSmall),
              ),
              Expanded(
                flex: 3,
                child: Text('Description', style: AppTypography.labelSmall),
              ),
              Expanded(
                flex: 2,
                child: Text('Amount',
                    style: AppTypography.labelSmall,
                    textAlign: TextAlign.right),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),

        // Rows
        Expanded(
          child: ListView.builder(
            itemCount: rows.length,
            itemBuilder: (context, index) {
              final row = rows[index];
              return _buildRow(row, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRow(ImportPreviewRow row, int index) {
    Color? backgroundColor;
    IconData? statusIcon;
    Color statusColor = AppColors.textTertiary;

    switch (row.validationStatus) {
      case RowValidationStatus.valid:
        statusIcon = Icons.check_circle_rounded;
        statusColor = AppColors.positive;
        break;
      case RowValidationStatus.warning:
        statusIcon = Icons.warning_rounded;
        statusColor = const Color(0xFFF59E0B);
        backgroundColor = const Color(0xFFF59E0B).withOpacity(0.05);
        break;
      case RowValidationStatus.error:
        statusIcon = Icons.error_rounded;
        statusColor = AppColors.negative;
        backgroundColor = AppColors.negative.withOpacity(0.05);
        break;
      case RowValidationStatus.duplicate:
        statusIcon = Icons.copy_rounded;
        statusColor = const Color(0xFFF59E0B);
        backgroundColor = const Color(0xFFF59E0B).withOpacity(0.05);
        break;
    }

    return Container(
      color: backgroundColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onToggleSelection(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Checkbox(
                  value: row.isSelected,
                  onChanged: (_) => onToggleSelection(index),
                  activeColor: AppColors.accent,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    row.parsedDate != null
                        ? '${row.parsedDate!.day}/${row.parsedDate!.month}/${row.parsedDate!.year}'
                        : '-',
                    style: AppTypography.bodySmall,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    row.parsedDescription ?? '-',
                    style: AppTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    row.parsedAmount != null
                        ? CurrencyFormatter.format(row.parsedAmount!)
                        : '-',
                    style: AppTypography.bodySmall.copyWith(
                      color: row.parsedAmount != null
                          ? (row.parsedAmount! < 0
                              ? AppColors.negative
                              : AppColors.positive)
                          : AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Tooltip(
                    message: row.validationMessages.join('\n'),
                    child: Icon(statusIcon, color: statusColor, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

