import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/investment.dart';
import '../bloc/investments_bloc.dart';
import '../widgets/investment_list_tile.dart';
import '../widgets/investment_summary_card.dart';
import '../widgets/investment_type_filter.dart';
import 'investment_form_page.dart';

/// Page displaying all investments
class InvestmentsPage extends StatelessWidget {
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InvestmentsBloc>()..add(const LoadInvestments()),
      child: const InvestmentsPageContent(),
    );
  }
}

class InvestmentsPageContent extends StatelessWidget {
  const InvestmentsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Investments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _navigateToAddInvestment(context),
          ),
        ],
      ),
      body: BlocBuilder<InvestmentsBloc, InvestmentsState>(
        builder: (context, state) {
          if (state.status == InvestmentsStatus.loading &&
              state.investments.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == InvestmentsStatus.error) {
            return Center(
              child: EmptyState(
                icon: Icons.error_outline_rounded,
                title: 'Error loading investments',
                message: state.errorMessage,
                actionLabel: 'Retry',
                onAction: () =>
                    context.read<InvestmentsBloc>().add(const LoadInvestments()),
              ),
            );
          }

          if (state.investments.isEmpty) {
            return EmptyState(
              icon: Icons.trending_up_outlined,
              title: 'No investments yet',
              message: 'Add your first investment to start tracking',
              actionLabel: 'Add Investment',
              onAction: () => _navigateToAddInvestment(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<InvestmentsBloc>().add(const LoadInvestments());
            },
            child: CustomScrollView(
              slivers: [
                // Summary card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: InvestmentSummaryCard(state: state),
                  ),
                ),

                // Type filter
                SliverToBoxAdapter(
                  child: InvestmentTypeFilter(
                    selectedType: state.filterType,
                    onTypeSelected: (type) {
                      context
                          .read<InvestmentsBloc>()
                          .add(FilterByInvestmentType(type));
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // Investments list
                SliverPadding(
                  padding: AppSpacing.pageHorizontal,
                  sliver: _buildInvestmentsList(context, state),
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
        onPressed: () => _navigateToAddInvestment(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildInvestmentsList(BuildContext context, InvestmentsState state) {
    final investments = state.filteredInvestments;

    if (state.filterType != null) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final investment = investments[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InvestmentListTile(
                investment: investment,
                onTap: () => _navigateToEditInvestment(context, investment),
              ),
            );
          },
          childCount: investments.length,
        ),
      );
    }

    // Group by type when not filtered
    final groupedInvestments = state.investmentsByType;
    final types = groupedInvestments.keys.toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final type = types[index];
          final typeInvestments = groupedInvestments[type]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index > 0) AppSpacing.vGapMd,
              SectionHeader(
                title: type.displayName,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              ...typeInvestments.map((investment) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InvestmentListTile(
                      investment: investment,
                      onTap: () =>
                          _navigateToEditInvestment(context, investment),
                    ),
                  )),
            ],
          );
        },
        childCount: types.length,
      ),
    );
  }

  void _navigateToAddInvestment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<InvestmentsBloc>(),
          child: const InvestmentFormPage(),
        ),
      ),
    );
  }

  void _navigateToEditInvestment(BuildContext context, Investment investment) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<InvestmentsBloc>(),
          child: InvestmentFormPage(investment: investment),
        ),
      ),
    );
  }
}

