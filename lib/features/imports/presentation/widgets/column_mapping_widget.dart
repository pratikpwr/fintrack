import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/import_config.dart';

/// Widget for mapping CSV columns to transaction fields
class ColumnMappingWidget extends StatelessWidget {
  final List<String> headers;
  final ColumnMapping mapping;
  final ValueChanged<ColumnMapping> onMappingChanged;

  const ColumnMappingWidget({
    super.key,
    required this.headers,
    required this.mapping,
    required this.onMappingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMappingRow(
          label: 'Date Column',
          icon: Icons.calendar_today_rounded,
          required: true,
          value: mapping.dateColumn,
          onChanged: (value) => onMappingChanged(
            mapping.copyWith(dateColumn: value),
          ),
        ),
        AppSpacing.vGapMd,
        _buildMappingRow(
          label: 'Amount Column',
          icon: Icons.attach_money_rounded,
          required: true,
          value: mapping.amountColumn,
          onChanged: (value) => onMappingChanged(
            mapping.copyWith(amountColumn: value),
          ),
        ),
        AppSpacing.vGapMd,
        _buildMappingRow(
          label: 'Description Column',
          icon: Icons.description_rounded,
          required: false,
          value: mapping.descriptionColumn,
          onChanged: (value) => onMappingChanged(
            mapping.copyWith(descriptionColumn: value),
          ),
        ),
        AppSpacing.vGapMd,
        _buildMappingRow(
          label: 'Type Column (Credit/Debit)',
          icon: Icons.swap_vert_rounded,
          required: false,
          value: mapping.typeColumn,
          onChanged: (value) => onMappingChanged(
            mapping.copyWith(typeColumn: value),
          ),
        ),
        AppSpacing.vGapLg,
        _buildDateFormatDropdown(),
        AppSpacing.vGapMd,
        _buildHasHeaderToggle(),
      ],
    );
  }

  Widget _buildMappingRow({
    required String label,
    required IconData icon,
    required bool required,
    required int? value,
    required ValueChanged<int?> onChanged,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: AppRadius.radiusSm,
          ),
          child: Icon(icon, color: AppColors.textSecondary, size: 20),
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(label, style: AppTypography.labelMedium),
                  if (required)
                    Text(
                      ' *',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.negative,
                      ),
                    ),
                ],
              ),
              AppSpacing.vGapXs,
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.radiusMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int?>(
                    value: value,
                    isExpanded: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    dropdownColor: AppColors.surface,
                    borderRadius: AppRadius.radiusMd,
                    hint: Text('Select column',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textTertiary)),
                    items: [
                      const DropdownMenuItem<int?>(
                        value: null,
                        child: Text('None'),
                      ),
                      ...headers.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(
                            '${entry.key + 1}. ${entry.value}',
                            style: AppTypography.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ],
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateFormatDropdown() {
    final formats = [
      'dd/MM/yyyy',
      'MM/dd/yyyy',
      'yyyy-MM-dd',
      'dd-MM-yyyy',
      'dd MMM yyyy',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date Format', style: AppTypography.labelMedium),
        AppSpacing.vGapXs,
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: mapping.dateFormat,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              dropdownColor: AppColors.surface,
              borderRadius: AppRadius.radiusMd,
              items: formats.map((format) {
                return DropdownMenuItem(
                  value: format,
                  child: Text(format, style: AppTypography.bodySmall),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onMappingChanged(mapping.copyWith(dateFormat: value));
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHasHeaderToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('File has header row', style: AppTypography.labelMedium),
                Text(
                  'Skip the first row when importing',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          Switch(
            value: mapping.hasHeader,
            onChanged: (value) =>
                onMappingChanged(mapping.copyWith(hasHeader: value)),
            activeColor: AppColors.accent,
          ),
        ],
      ),
    );
  }
}

