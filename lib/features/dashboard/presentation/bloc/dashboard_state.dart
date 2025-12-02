part of 'dashboard_bloc.dart';

/// State status enum
enum DashboardStatus {
  initial,
  loading,
  loaded,
  error,
}

/// State class for dashboard
class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<Account> accounts;
  final List<Transaction> recentTransactions;
  final double totalAssets;
  final double totalLiabilities;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.accounts = const [],
    this.recentTransactions = const [],
    this.totalAssets = 0,
    this.totalLiabilities = 0,
    this.errorMessage,
  });

  /// Net worth = assets - liabilities
  double get netWorth => totalAssets - totalLiabilities;

  /// Get accounts grouped by type
  Map<AccountType, List<Account>> get accountsByType {
    final grouped = <AccountType, List<Account>>{};
    for (final account in accounts.where((a) => !a.isArchived)) {
      grouped.putIfAbsent(account.type, () => []).add(account);
    }
    return grouped;
  }

  DashboardState copyWith({
    DashboardStatus? status,
    List<Account>? accounts,
    List<Transaction>? recentTransactions,
    double? totalAssets,
    double? totalLiabilities,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      totalAssets: totalAssets ?? this.totalAssets,
      totalLiabilities: totalLiabilities ?? this.totalLiabilities,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        accounts,
        recentTransactions,
        totalAssets,
        totalLiabilities,
        errorMessage,
      ];
}

