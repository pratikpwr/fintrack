import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/accounts/presentation/pages/accounts_page.dart';
import '../../features/accounts/presentation/pages/account_form_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/transactions/presentation/pages/transaction_form_page.dart';
import '../../core/theme/theme.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(page: DashboardTabRoute.page, initial: true),
            AutoRoute(page: AccountsTabRoute.page),
            AutoRoute(page: TransactionsTabRoute.page),
            AutoRoute(page: InvestmentsTabRoute.page),
            AutoRoute(page: MonthlyPaymentsTabRoute.page),
          ],
        ),
        AutoRoute(page: AccountFormWrapperRoute.page),
        AutoRoute(page: TransactionFormWrapperRoute.page),
      ];
}

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardTabRoute(),
        AccountsTabRoute(),
        TransactionsTabRoute(),
        InvestmentsTabRoute(),
        MonthlyPaymentsTabRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Accounts',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long_rounded),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Icon(Icons.trending_up_outlined),
              selectedIcon: Icon(Icons.trending_up_rounded),
              label: 'Investments',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month_rounded),
              label: 'Monthly',
            ),
          ],
        );
      },
    );
  }
}

@RoutePage()
class DashboardTabPage extends StatelessWidget {
  const DashboardTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

@RoutePage()
class AccountsTabPage extends StatelessWidget {
  const AccountsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountsPage();
  }
}

@RoutePage()
class TransactionsTabPage extends StatelessWidget {
  const TransactionsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionsPage();
  }
}

@RoutePage()
class InvestmentsTabPage extends StatelessWidget {
  const InvestmentsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Investments')),
      body: const Center(child: Text('Coming soon...')),
    );
  }
}

@RoutePage()
class MonthlyPaymentsTabPage extends StatelessWidget {
  const MonthlyPaymentsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Monthly Payments')),
      body: const Center(child: Text('Coming soon...')),
    );
  }
}

@RoutePage()
class AccountFormWrapperPage extends StatelessWidget {
  const AccountFormWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountFormPage();
  }
}

@RoutePage()
class TransactionFormWrapperPage extends StatelessWidget {
  const TransactionFormWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionFormPage();
  }
}
