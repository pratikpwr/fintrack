import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/usecases/get_accounts.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/usecases/get_transactions.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// Bloc for managing dashboard state
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAccounts getAccounts;
  final GetTransactions getTransactions;

  DashboardBloc({
    required this.getAccounts,
    required this.getTransactions,
  }) : super(const DashboardState()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    // Load accounts
    final accountsResult = await getAccounts();
    
    // Load recent transactions
    final transactionsResult = await getTransactions.recent(limit: 5);

    accountsResult.fold(
      (failure) => emit(state.copyWith(
        status: DashboardStatus.error,
        errorMessage: failure.message,
      )),
      (accounts) {
        // Calculate totals
        final totalAssets = accounts
            .where((a) => a.type.isAsset && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance);
        final totalLiabilities = accounts
            .where((a) => a.type.isLiability && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance.abs());

        transactionsResult.fold(
          (failure) => emit(state.copyWith(
            status: DashboardStatus.loaded,
            accounts: accounts,
            totalAssets: totalAssets,
            totalLiabilities: totalLiabilities,
          )),
          (transactions) => emit(state.copyWith(
            status: DashboardStatus.loaded,
            accounts: accounts,
            recentTransactions: transactions,
            totalAssets: totalAssets,
            totalLiabilities: totalLiabilities,
          )),
        );
      },
    );
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    add(const LoadDashboard());
  }
}

