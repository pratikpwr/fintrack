import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/monthly_payment.dart';
import '../bloc/monthly_payments_bloc.dart';
import '../widgets/payment_category_filter.dart';
import '../widgets/payment_list_tile.dart';
import '../widgets/payment_summary_card.dart';
import 'monthly_payment_form_page.dart';

/// Page displaying all monthly payments
class MonthlyPaymentsPage extends StatelessWidget {
  const MonthlyPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<MonthlyPaymentsBloc>()..add(const LoadMonthlyPayments()),
      child: const MonthlyPaymentsPageContent(),
    );
  }
}

class MonthlyPaymentsPageContent extends StatelessWidget {
  const MonthlyPaymentsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Monthly Payments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _navigateToAddPayment(context),
          ),
        ],
      ),
      body: BlocBuilder<MonthlyPaymentsBloc, MonthlyPaymentsState>(
        builder: (context, state) {
          if (state.status == MonthlyPaymentsStatus.loading &&
              state.payments.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MonthlyPaymentsStatus.error) {
            return Center(
              child: EmptyState(
                icon: Icons.error_outline_rounded,
                title: 'Error loading payments',
                message: state.errorMessage,
                actionLabel: 'Retry',
                onAction: () => context
                    .read<MonthlyPaymentsBloc>()
                    .add(const LoadMonthlyPayments()),
              ),
            );
          }

          if (state.payments.isEmpty) {
            return EmptyState(
              icon: Icons.calendar_month_outlined,
              title: 'No monthly payments yet',
              message: 'Add your recurring payments to track them',
              actionLabel: 'Add Payment',
              onAction: () => _navigateToAddPayment(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<MonthlyPaymentsBloc>()
                  .add(const LoadMonthlyPayments());
            },
            child: CustomScrollView(
              slivers: [
                // Summary card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: PaymentSummaryCard(state: state),
                  ),
                ),

                // Overdue section
                if (state.overduePayments.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: AppSpacing.pagePadding,
                      child: SectionHeader(
                        title: 'Overdue',
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: AppSpacing.pageHorizontal,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final payment = state.overduePayments[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: PaymentListTile(
                              payment: payment,
                              onTap: () =>
                                  _navigateToEditPayment(context, payment),
                              onMarkAsPaid: () => context
                                  .read<MonthlyPaymentsBloc>()
                                  .add(MarkAsPaidEvent(payment.id)),
                            ),
                          );
                        },
                        childCount: state.overduePayments.length,
                      ),
                    ),
                  ),
                ],

                // Upcoming section
                if (state.upcomingPayments.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: AppSpacing.pagePadding,
                      child: SectionHeader(
                        title: 'Upcoming',
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: AppSpacing.pageHorizontal,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final payment = state.upcomingPayments[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: PaymentListTile(
                              payment: payment,
                              onTap: () =>
                                  _navigateToEditPayment(context, payment),
                              onMarkAsPaid: () => context
                                  .read<MonthlyPaymentsBloc>()
                                  .add(MarkAsPaidEvent(payment.id)),
                            ),
                          );
                        },
                        childCount: state.upcomingPayments.length,
                      ),
                    ),
                  ),
                ],

                // Category filter
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PaymentCategoryFilter(
                      selectedCategory: state.filterCategory,
                      onCategorySelected: (category) {
                        context
                            .read<MonthlyPaymentsBloc>()
                            .add(FilterByPaymentCategory(category));
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // All payments list
                SliverPadding(
                  padding: AppSpacing.pageHorizontal,
                  sliver: _buildPaymentsList(context, state),
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
        onPressed: () => _navigateToAddPayment(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildPaymentsList(
      BuildContext context, MonthlyPaymentsState state) {
    final payments = state.filteredPayments;

    if (state.filterCategory != null) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final payment = payments[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PaymentListTile(
                payment: payment,
                onTap: () => _navigateToEditPayment(context, payment),
                onMarkAsPaid: (payment.isDueSoon || payment.isOverdue)
                    ? () => context
                        .read<MonthlyPaymentsBloc>()
                        .add(MarkAsPaidEvent(payment.id))
                    : null,
              ),
            );
          },
          childCount: payments.length,
        ),
      );
    }

    // Group by category when not filtered
    final groupedPayments = state.paymentsByCategory;
    final categories = groupedPayments.keys.toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          final categoryPayments = groupedPayments[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index > 0) AppSpacing.vGapMd,
              SectionHeader(
                title: category.displayName,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              ...categoryPayments.map((payment) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: PaymentListTile(
                      payment: payment,
                      onTap: () => _navigateToEditPayment(context, payment),
                      onMarkAsPaid: (payment.isDueSoon || payment.isOverdue)
                          ? () => context
                              .read<MonthlyPaymentsBloc>()
                              .add(MarkAsPaidEvent(payment.id))
                          : null,
                    ),
                  )),
            ],
          );
        },
        childCount: categories.length,
      ),
    );
  }

  void _navigateToAddPayment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<MonthlyPaymentsBloc>(),
          child: const MonthlyPaymentFormPage(),
        ),
      ),
    );
  }

  void _navigateToEditPayment(BuildContext context, MonthlyPayment payment) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<MonthlyPaymentsBloc>(),
          child: MonthlyPaymentFormPage(payment: payment),
        ),
      ),
    );
  }
}

