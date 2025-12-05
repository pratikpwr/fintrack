import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/monthly_payment.dart';

/// Horizontal filter chips for payment categories
class PaymentCategoryFilter extends StatelessWidget {
  final PaymentCategory? selectedCategory;
  final ValueChanged<PaymentCategory?> onCategorySelected;

  const PaymentCategoryFilter({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
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
          ...PaymentCategory.values.map(
            (category) => _buildChip(category, category.shortName),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(PaymentCategory? category, String label) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onCategorySelected(category),
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

