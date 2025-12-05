import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/investment.dart';

/// Horizontal filter chips for investment types
class InvestmentTypeFilter extends StatelessWidget {
  final InvestmentType? selectedType;
  final ValueChanged<InvestmentType?> onTypeSelected;

  const InvestmentTypeFilter({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.pageHorizontal,
        children: [
          _buildChip(null, 'All'),
          ...InvestmentType.values.map(
            (type) => _buildChip(type, type.shortName),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(InvestmentType? type, String label) {
    final isSelected = selectedType == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTypeSelected(type),
        showCheckmark: false,
        backgroundColor: AppColors.surfaceLight,
        selectedColor: AppColors.accentSurface,
        labelStyle: AppTypography.labelSmall.copyWith(
          color: isSelected ? AppColors.accent : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.accent : AppColors.border,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}

