import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/account.dart';

/// Filter chips for account types
class AccountTypeFilter extends StatelessWidget {
  final AccountType? selectedType;
  final ValueChanged<AccountType?> onTypeSelected;

  const AccountTypeFilter({
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
          _buildChip(
            label: 'All',
            isSelected: selectedType == null,
            onTap: () => onTypeSelected(null),
          ),
          AppSpacing.hGapSm,
          ...AccountType.values
              .where((type) => type != AccountType.creditCard)
              .map((type) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(
                label: type.shortName,
                isSelected: selectedType == type,
                onTap: () => onTypeSelected(type),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentSurface : AppColors.surfaceLight,
          borderRadius: AppRadius.chip,
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

