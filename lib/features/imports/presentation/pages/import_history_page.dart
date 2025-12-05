import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../bloc/import_bloc.dart';
import '../widgets/import_history_tile.dart';

/// Page showing import history
class ImportHistoryPage extends StatelessWidget {
  const ImportHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ImportBloc>()..add(const LoadImportHistory()),
      child: const ImportHistoryPageContent(),
    );
  }
}

class ImportHistoryPageContent extends StatelessWidget {
  const ImportHistoryPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Import History'),
      ),
      body: BlocBuilder<ImportBloc, ImportState>(
        builder: (context, state) {
          if (state.status == ImportStatus.loading &&
              state.importHistory.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.importHistory.isEmpty) {
            return Center(
              child: EmptyState(
                icon: Icons.history_rounded,
                title: 'No import history',
                message: 'Your imported transactions will appear here',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ImportBloc>().add(const LoadImportHistory());
            },
            child: ListView.builder(
              padding: AppSpacing.pagePadding,
              itemCount: state.importHistory.length,
              itemBuilder: (context, index) {
                final batch = state.importHistory[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ImportHistoryTile(
                    batch: batch,
                    onDelete: () => _showDeleteConfirmation(context, batch.id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String batchId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete Import'),
        content: const Text(
          'This will delete all transactions from this import. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ImportBloc>().add(DeleteImportBatchEvent(batchId));
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.negative),
            ),
          ),
        ],
      ),
    );
  }
}

