part of 'transactions_bloc.dart';

/// State status enum
enum TransactionsStatus {
  initial,
  loading,
  loaded,
  error,
}

/// State class for transactions
class TransactionsState extends Equatable {
  final TransactionsStatus status;
  final List<Transaction> transactions;
  final Transaction? selectedTransaction;
  final TransactionFilter filter;
  final String? errorMessage;

  const TransactionsState({
    this.status = TransactionsStatus.initial,
    this.transactions = const [],
    this.selectedTransaction,
    this.filter = const TransactionFilter(),
    this.errorMessage,
  });

  /// Get transactions grouped by date
  Map<DateTime, List<Transaction>> get transactionsByDate {
    final grouped = <DateTime, List<Transaction>>{};
    for (final transaction in transactions) {
      final dateOnly = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );
      grouped.putIfAbsent(dateOnly, () => []).add(transaction);
    }
    return grouped;
  }

  /// Calculate total income from current transactions
  double get totalIncome {
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// Calculate total expenses from current transactions
  double get totalExpenses {
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<Transaction>? transactions,
    Transaction? selectedTransaction,
    TransactionFilter? filter,
    String? errorMessage,
    bool clearSelectedTransaction = false,
    bool clearFilter = false,
    bool clearError = false,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      selectedTransaction: clearSelectedTransaction
          ? null
          : selectedTransaction ?? this.selectedTransaction,
      filter: clearFilter ? const TransactionFilter() : filter ?? this.filter,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        selectedTransaction,
        filter,
        errorMessage,
      ];
}

