import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/account.dart';
import '../../domain/usecases/create_account.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_account.dart';
import '../../domain/usecases/get_accounts.dart';
import '../../domain/usecases/update_account.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

/// Bloc for managing accounts state
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final GetAccounts getAccounts;
  final GetAccount getAccount;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  AccountsBloc({
    required this.getAccounts,
    required this.getAccount,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
  }) : super(const AccountsState()) {
    on<LoadAccounts>(_onLoadAccounts);
    on<LoadAccount>(_onLoadAccount);
    on<CreateAccountEvent>(_onCreateAccount);
    on<UpdateAccountEvent>(_onUpdateAccount);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<FilterByType>(_onFilterByType);
  }

  Future<void> _onLoadAccounts(
    LoadAccounts event,
    Emitter<AccountsState> emit,
  ) async {
    emit(state.copyWith(status: AccountsStatus.loading, clearError: true));

    final result = await getAccounts(
      GetAccountsParams(includeArchived: event.includeArchived),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountsStatus.error,
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

        emit(state.copyWith(
          status: AccountsStatus.loaded,
          accounts: accounts,
          totalAssets: totalAssets,
          totalLiabilities: totalLiabilities,
        ));
      },
    );
  }

  Future<void> _onLoadAccount(
    LoadAccount event,
    Emitter<AccountsState> emit,
  ) async {
    emit(state.copyWith(status: AccountsStatus.loading, clearError: true));

    final result = await getAccount(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountsStatus.error,
        errorMessage: failure.message,
      )),
      (account) => emit(state.copyWith(
        status: AccountsStatus.loaded,
        selectedAccount: account,
      )),
    );
  }

  Future<void> _onCreateAccount(
    CreateAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    emit(state.copyWith(status: AccountsStatus.loading, clearError: true));

    final result = await createAccount(event.account);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountsStatus.error,
        errorMessage: failure.message,
      )),
      (account) {
        final updatedAccounts = [...state.accounts, account];
        final totalAssets = updatedAccounts
            .where((a) => a.type.isAsset && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance);
        final totalLiabilities = updatedAccounts
            .where((a) => a.type.isLiability && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance.abs());

        emit(state.copyWith(
          status: AccountsStatus.loaded,
          accounts: updatedAccounts,
          selectedAccount: account,
          totalAssets: totalAssets,
          totalLiabilities: totalLiabilities,
        ));
      },
    );
  }

  Future<void> _onUpdateAccount(
    UpdateAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    emit(state.copyWith(status: AccountsStatus.loading, clearError: true));

    final result = await updateAccount(event.account);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountsStatus.error,
        errorMessage: failure.message,
      )),
      (account) {
        final updatedAccounts = state.accounts
            .map((a) => a.id == account.id ? account : a)
            .toList();
        final totalAssets = updatedAccounts
            .where((a) => a.type.isAsset && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance);
        final totalLiabilities = updatedAccounts
            .where((a) => a.type.isLiability && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance.abs());

        emit(state.copyWith(
          status: AccountsStatus.loaded,
          accounts: updatedAccounts,
          selectedAccount: account,
          totalAssets: totalAssets,
          totalLiabilities: totalLiabilities,
        ));
      },
    );
  }

  Future<void> _onDeleteAccount(
    DeleteAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    emit(state.copyWith(status: AccountsStatus.loading, clearError: true));

    final result = event.permanent
        ? await deleteAccount(event.id)
        : await deleteAccount.archive(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountsStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedAccounts = event.permanent
            ? state.accounts.where((a) => a.id != event.id).toList()
            : state.accounts
                .map((a) =>
                    a.id == event.id ? a.copyWith(isArchived: true) : a)
                .toList();
        final totalAssets = updatedAccounts
            .where((a) => a.type.isAsset && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance);
        final totalLiabilities = updatedAccounts
            .where((a) => a.type.isLiability && !a.isArchived)
            .fold(0.0, (sum, a) => sum + a.balance.abs());

        emit(state.copyWith(
          status: AccountsStatus.loaded,
          accounts: updatedAccounts,
          clearSelectedAccount: true,
          totalAssets: totalAssets,
          totalLiabilities: totalLiabilities,
        ));
      },
    );
  }

  void _onFilterByType(
    FilterByType event,
    Emitter<AccountsState> emit,
  ) {
    if (event.type == null) {
      emit(state.copyWith(clearFilterType: true));
    } else {
      emit(state.copyWith(filterType: event.type));
    }
  }
}

