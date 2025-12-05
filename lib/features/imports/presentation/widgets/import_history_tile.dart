import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/import_batch.dart';

/// Widget for displaying import history item
class ImportHistoryTile extends StatelessWidget {
  final ImportBatch batch;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ImportHistoryTile({
    super.key,
    required this.batch,
    this.onTap,
    this.onDelete,
  });

  Color get _statusColor {
    switch (batch.status) {
      case ImportStatus.completed:
        return AppColors.positive;
      case ImportStatus.failed:
        return AppColors.negative;
      case ImportStatus.partiallyCompleted:
        return const Color(0xFFF59E0B);
      case ImportStatus.processing:
        return AppColors.info;
      case ImportStatus.pending:
        return AppColors.textTertiary;
    }
  }

  IconData get _statusIcon {
    switch (batch.status) {
      case ImportStatus.completed:
        return Icons.check_circle_rounded;
      case ImportStatus.failed:
        return Icons.error_rounded;
      case ImportStatus.partiallyCompleted:
        return Icons.warning_rounded;
      case ImportStatus.processing:
        return Icons.sync_rounded;
      case ImportStatus.pending:
        return Icons.schedule_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _statusColor.withOpacity(0.1),
              borderRadius: AppRadius.radiusSm,
            ),
            child: Icon(_statusIcon, color: _statusColor, size: 22),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  batch.fileName,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.vGapXs,
                Row(
                  children: [
                    Text(
                      '${batch.importDate.day}/${batch.importDate.month}/${batch.importDate.year}',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.hGapSm,
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textTertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.hGapSm,
                    Text(
                      '${batch.importedRows}/${batch.totalRows} imported',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onDelete != null)
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.textTertiary,
              ),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}

