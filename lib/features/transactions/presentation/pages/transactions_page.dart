import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/transaction.dart';
import '../bloc/transactions_bloc.dart';
import '../widgets/transaction_list_tile.dart';
import 'transaction_form_page.dart';

/// Page displaying all transactions
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionsBloc>()..add(const LoadTransactions()),
      child: const TransactionsPageContent(),
    );
  }
}

class TransactionsPageContent extends StatelessWidget {
  const TransactionsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => _showFilterSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _navigateToAddTransaction(context),
          ),
        ],
      ),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state.status == TransactionsStatus.loading &&
              state.transactions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TransactionsStatus.error) {
            return Center(
              child: EmptyState(
                icon: Icons.error_outline_rounded,
                title: 'Error loading transactions',
                message: state.errorMessage,
                actionLabel: 'Retry',
                onAction: () => context
                    .read<TransactionsBloc>()
                    .add(const LoadTransactions()),
              ),
            );
          }

          if (state.transactions.isEmpty) {
            return EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No transactions yet',
              message: 'Add your first transaction to start tracking',
              actionLabel: 'Add Transaction',
              onAction: () => _navigateToAddTransaction(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<TransactionsBloc>().add(const LoadTransactions());
            },
            child: _buildTransactionsList(context, state),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTransaction(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildTransactionsList(
      BuildContext context, TransactionsState state) {
    final groupedTransactions = state.transactionsByDate;
    final dates = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: AppSpacing.pageHorizontal,
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final transactions = groupedTransactions[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0) AppSpacing.vGapMd,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                DateFormatter.formatRelative(date),
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...transactions.map(
              (transaction) => TransactionListTile(
                transaction: transaction,
                onTap: () => _navigateToEditTransaction(context, transaction),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddTransaction(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<TransactionsBloc>(),
          child: const TransactionFormPage(),
        ),
      ),
    );
  }

  void _navigateToEditTransaction(
      BuildContext context, Transaction transaction) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<TransactionsBloc>(),
          child: TransactionFormPage(transaction: transaction),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textTertiary,
                  borderRadius: AppRadius.radiusFull,
                ),
              ),
            ),
            AppSpacing.vGapLg,
            Text(
              'Filter Transactions',
              style: AppTypography.headingMedium,
            ),
            AppSpacing.vGapLg,
            // Filter options would go here
            Text(
              'Coming soon...',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSpacing.vGapXxl,
          ],
        ),
      ),
    );
  }
}

