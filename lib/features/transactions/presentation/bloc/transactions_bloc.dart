import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/create_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

/// Bloc for managing transactions state
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetTransactions getTransactions;
  final CreateTransaction createTransaction;
  final UpdateTransaction updateTransaction;
  final DeleteTransaction deleteTransaction;

  TransactionsBloc({
    required this.getTransactions,
    required this.createTransaction,
    required this.updateTransaction,
    required this.deleteTransaction,
  }) : super(const TransactionsState()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<LoadRecentTransactions>(_onLoadRecentTransactions);
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<ApplyFilter>(_onApplyFilter);
    on<ClearFilter>(_onClearFilter);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.loading, clearError: true));

    final result = await getTransactions(state.filter);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TransactionsStatus.error,
        errorMessage: failure.message,
      )),
      (transactions) => emit(state.copyWith(
        status: TransactionsStatus.loaded,
        transactions: transactions,
      )),
    );
  }

  Future<void> _onLoadRecentTransactions(
    LoadRecentTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.loading, clearError: true));

    final result = await getTransactions.recent(limit: event.limit);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TransactionsStatus.error,
        errorMessage: failure.message,
      )),
      (transactions) => emit(state.copyWith(
        status: TransactionsStatus.loaded,
        transactions: transactions,
      )),
    );
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.loading, clearError: true));

    final result = await createTransaction(event.transaction);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TransactionsStatus.error,
        errorMessage: failure.message,
      )),
      (transaction) {
        final updatedTransactions = [transaction, ...state.transactions];
        emit(state.copyWith(
          status: TransactionsStatus.loaded,
          transactions: updatedTransactions,
          selectedTransaction: transaction,
        ));
      },
    );
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.loading, clearError: true));

    final result = await updateTransaction(event.transaction);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TransactionsStatus.error,
        errorMessage: failure.message,
      )),
      (transaction) {
        final updatedTransactions = state.transactions
            .map((t) => t.id == transaction.id ? transaction : t)
            .toList();
        emit(state.copyWith(
          status: TransactionsStatus.loaded,
          transactions: updatedTransactions,
          selectedTransaction: transaction,
        ));
      },
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.loading, clearError: true));

    final result = await deleteTransaction(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TransactionsStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedTransactions =
            state.transactions.where((t) => t.id != event.id).toList();
        emit(state.copyWith(
          status: TransactionsStatus.loaded,
          transactions: updatedTransactions,
          clearSelectedTransaction: true,
        ));
      },
    );
  }

  void _onApplyFilter(
    ApplyFilter event,
    Emitter<TransactionsState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
    add(const LoadTransactions());
  }

  void _onClearFilter(
    ClearFilter event,
    Emitter<TransactionsState> emit,
  ) {
    emit(state.copyWith(clearFilter: true));
    add(const LoadTransactions());
  }
}

