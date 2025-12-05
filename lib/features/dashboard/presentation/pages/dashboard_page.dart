import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../transactions/presentation/widgets/transaction_list_tile.dart';
import '../../../imports/presentation/pages/import_page.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/net_worth_card.dart';
import '../widgets/account_summary_card.dart';

/// Main dashboard page showing overview
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()..add(const LoadDashboard()),
      child: const DashboardPageContent(),
    );
  }
}

class DashboardPageContent extends StatelessWidget {
  const DashboardPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.status == DashboardStatus.loading &&
              state.accounts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == DashboardStatus.error) {
            return Center(
              child: EmptyState(
                icon: Icons.error_outline_rounded,
                title: 'Error loading dashboard',
                message: state.errorMessage,
                actionLabel: 'Retry',
                onAction: () =>
                    context.read<DashboardBloc>().add(const LoadDashboard()),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(const RefreshDashboard());
            },
            child: CustomScrollView(
              slivers: [
                // App bar
                SliverAppBar(
                  floating: true,
                  backgroundColor: AppColors.background,
                  title: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius: AppRadius.radiusSm,
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: AppColors.accent,
                          size: 20,
                        ),
                      ),
                      AppSpacing.hGapSm,
                      const Text(
                        'FinTrack',
                        style: AppTypography.headingMedium,
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),

                // Net worth card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: NetWorthCard(
                      netWorth: state.netWorth,
                      totalAssets: state.totalAssets,
                      totalLiabilities: state.totalLiabilities,
                    ),
                  ),
                ),

                // Quick actions
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pageHorizontal,
                    child: _buildQuickActions(context),
                  ),
                ),

                // Account summaries
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: SectionHeader(
                      title: 'Accounts',
                      actionLabel: 'See All',
                      onAction: () {
                        // Navigate to accounts page
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 140,
                    child: _buildAccountCards(state),
                  ),
                ),

                // Recent transactions
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: SectionHeader(
                      title: 'Recent Transactions',
                      actionLabel: 'See All',
                      onAction: () {
                        // Navigate to transactions page
                      },
                    ),
                  ),
                ),
                if (state.recentTransactions.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: AppSpacing.pagePadding,
                      child: AppCard(
                        child: Center(
                          child: Text(
                            'No transactions yet',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: AppSpacing.pageHorizontal,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final transaction = state.recentTransactions[index];
                          return TransactionListTile(
                            transaction: transaction,
                            onTap: () {
                              // Navigate to transaction detail
                            },
                          );
                        },
                        childCount: state.recentTransactions.length,
                      ),
                    ),
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
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.add_rounded,
            label: 'Income',
            color: AppColors.positive,
            onTap: () {},
          ),
        ),
        AppSpacing.hGapSm,
        Expanded(
          child: _QuickActionButton(
            icon: Icons.remove_rounded,
            label: 'Expense',
            color: AppColors.negative,
            onTap: () {},
          ),
        ),
        AppSpacing.hGapSm,
        Expanded(
          child: _QuickActionButton(
            icon: Icons.upload_file_rounded,
            label: 'Import',
            color: AppColors.info,
            onTap: () => _navigateToImport(context),
          ),
        ),
      ],
    );
  }

  void _navigateToImport(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ImportPage()),
    );
  }

  Widget _buildAccountCards(DashboardState state) {
    if (state.accounts.isEmpty) {
      return Padding(
        padding: AppSpacing.pageHorizontal,
        child: AppCard(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.textTertiary,
                  size: 32,
                ),
                AppSpacing.vGapSm,
                Text(
                  'No accounts yet',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final activeAccounts = state.accounts.where((a) => !a.isArchived).toList();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: AppSpacing.pageHorizontal,
      itemCount: activeAccounts.length,
      itemBuilder: (context, index) {
        final account = activeAccounts[index];
        return Padding(
          padding: EdgeInsets.only(right: index < activeAccounts.length - 1 ? 12 : 0),
          child: SizedBox(
            width: 180,
            child: AccountSummaryCard(account: account),
          ),
        );
      },
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: AppRadius.radiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusMd,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              AppSpacing.vGapXs,
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

