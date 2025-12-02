part of 'accounts_bloc.dart';

/// State status enum
enum AccountsStatus {
  initial,
  loading,
  loaded,
  error,
}

/// State class for accounts
class AccountsState extends Equatable {
  final AccountsStatus status;
  final List<Account> accounts;
  final Account? selectedAccount;
  final AccountType? filterType;
  final String? errorMessage;
  final double totalAssets;
  final double totalLiabilities;

  const AccountsState({
    this.status = AccountsStatus.initial,
    this.accounts = const [],
    this.selectedAccount,
    this.filterType,
    this.errorMessage,
    this.totalAssets = 0,
    this.totalLiabilities = 0,
  });

  /// Net worth = assets - liabilities
  double get netWorth => totalAssets - totalLiabilities;

  /// Get accounts grouped by type
  Map<AccountType, List<Account>> get accountsByType {
    final grouped = <AccountType, List<Account>>{};
    for (final account in accounts) {
      grouped.putIfAbsent(account.type, () => []).add(account);
    }
    return grouped;
  }

  /// Get filtered accounts
  List<Account> get filteredAccounts {
    if (filterType == null) return accounts;
    return accounts.where((a) => a.type == filterType).toList();
  }

  /// Get asset accounts
  List<Account> get assetAccounts {
    return accounts.where((a) => a.type.isAsset).toList();
  }

  /// Get liability accounts
  List<Account> get liabilityAccounts {
    return accounts.where((a) => a.type.isLiability).toList();
  }

  AccountsState copyWith({
    AccountsStatus? status,
    List<Account>? accounts,
    Account? selectedAccount,
    AccountType? filterType,
    String? errorMessage,
    double? totalAssets,
    double? totalLiabilities,
    bool clearSelectedAccount = false,
    bool clearFilterType = false,
    bool clearError = false,
  }) {
    return AccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      selectedAccount:
          clearSelectedAccount ? null : selectedAccount ?? this.selectedAccount,
      filterType: clearFilterType ? null : filterType ?? this.filterType,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      totalAssets: totalAssets ?? this.totalAssets,
      totalLiabilities: totalLiabilities ?? this.totalLiabilities,
    );
  }

  @override
  List<Object?> get props => [
        status,
        accounts,
        selectedAccount,
        filterType,
        errorMessage,
        totalAssets,
        totalLiabilities,
      ];
}

