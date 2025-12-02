part of 'transactions_bloc.dart';

/// Base event class for transactions
abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

/// Load all transactions
class LoadTransactions extends TransactionsEvent {
  const LoadTransactions();
}

/// Load recent transactions
class LoadRecentTransactions extends TransactionsEvent {
  final int limit;

  const LoadRecentTransactions({this.limit = 10});

  @override
  List<Object?> get props => [limit];
}

/// Create a new transaction
class CreateTransactionEvent extends TransactionsEvent {
  final Transaction transaction;

  const CreateTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

/// Update an existing transaction
class UpdateTransactionEvent extends TransactionsEvent {
  final Transaction transaction;

  const UpdateTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

/// Delete a transaction
class DeleteTransactionEvent extends TransactionsEvent {
  final int id;

  const DeleteTransactionEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Apply a filter to transactions
class ApplyFilter extends TransactionsEvent {
  final TransactionFilter filter;

  const ApplyFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// Clear all filters
class ClearFilter extends TransactionsEvent {
  const ClearFilter();
}

