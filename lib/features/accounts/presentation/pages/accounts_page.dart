import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/account_list_tile.dart';
import '../widgets/account_type_filter.dart';
import 'account_form_page.dart';

/// Page displaying all accounts grouped by type
class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AccountsBloc>()..add(const LoadAccounts()),
      child: const AccountsPageContent(),
    );
  }
}

class AccountsPageContent extends StatelessWidget {
  const AccountsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _navigateToAddAccount(context),
          ),
        ],
      ),
      body: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state.status == AccountsStatus.loading &&
              state.accounts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == AccountsStatus.error) {
            return Center(
              child: EmptyState(
                icon: Icons.error_outline_rounded,
                title: 'Error loading accounts',
                message: state.errorMessage,
                actionLabel: 'Retry',
                onAction: () =>
                    context.read<AccountsBloc>().add(const LoadAccounts()),
              ),
            );
          }

          if (state.accounts.isEmpty) {
            return EmptyState(
              icon: Icons.account_balance_wallet_outlined,
              title: 'No accounts yet',
              message: 'Add your first account to start tracking',
              actionLabel: 'Add Account',
              onAction: () => _navigateToAddAccount(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AccountsBloc>().add(const LoadAccounts());
            },
            child: CustomScrollView(
              slivers: [
                // Summary card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: _buildSummaryCard(state),
                  ),
                ),

                // Type filter
                SliverToBoxAdapter(
                  child: AccountTypeFilter(
                    selectedType: state.filterType,
                    onTypeSelected: (type) {
                      context.read<AccountsBloc>().add(FilterByType(type));
                    },
                  ),
                ),

                // Accounts list
                SliverPadding(
                  padding: AppSpacing.pageHorizontal,
                  sliver: _buildAccountsList(context, state),
                ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddAccount(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildSummaryCard(AccountsState state) {
    return AppCard(
      variant: AppCardVariant.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Net Worth',
            style: AppTypography.caption.copyWith(color: AppColors.accent),
          ),
          AppSpacing.vGapXs,
          MoneyText(
            amount: state.netWorth,
            size: MoneyTextSize.large,
          ),
          AppSpacing.vGapMd,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assets',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.vGapXxs,
                    MoneyText(
                      amount: state.totalAssets,
                      size: MoneyTextSize.small,
                      style: AppTypography.moneySmall.copyWith(
                        color: AppColors.positive,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Liabilities',
                      style: AppTypography.caption,
                    ),
                    AppSpacing.vGapXxs,
                    MoneyText(
                      amount: state.totalLiabilities,
                      size: MoneyTextSize.small,
                      style: AppTypography.moneySmall.copyWith(
                        color: AppColors.negative,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList(BuildContext context, AccountsState state) {
    final accounts = state.filteredAccounts;

    if (state.filterType != null) {
      // Show flat list when filtered
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final account = accounts[index];
            return AccountListTile(
              account: account,
              onTap: () => _navigateToEditAccount(context, account),
            );
          },
          childCount: accounts.length,
        ),
      );
    }

    // Group by type when not filtered
    final groupedAccounts = state.accountsByType;
    final types = groupedAccounts.keys.toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final type = types[index];
          final typeAccounts = groupedAccounts[type]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index > 0) AppSpacing.vGapMd,
              SectionHeader(
                title: type.displayName,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              ...typeAccounts.map((account) => AccountListTile(
                    account: account,
                    onTap: () => _navigateToEditAccount(context, account),
                  )),
            ],
          );
        },
        childCount: types.length,
      ),
    );
  }

  void _navigateToAddAccount(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<AccountsBloc>(),
          child: const AccountFormPage(),
        ),
      ),
    );
  }

  void _navigateToEditAccount(BuildContext context, Account account) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<AccountsBloc>(),
          child: AccountFormPage(account: account),
        ),
      ),
    );
  }
}

