part of 'accounts_bloc.dart';

/// Base event class for accounts
abstract class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object?> get props => [];
}

/// Load all accounts
class LoadAccounts extends AccountsEvent {
  final bool includeArchived;

  const LoadAccounts({this.includeArchived = false});

  @override
  List<Object?> get props => [includeArchived];
}

/// Load a single account
class LoadAccount extends AccountsEvent {
  final int id;

  const LoadAccount(this.id);

  @override
  List<Object?> get props => [id];
}

/// Create a new account
class CreateAccountEvent extends AccountsEvent {
  final Account account;

  const CreateAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}

/// Update an existing account
class UpdateAccountEvent extends AccountsEvent {
  final Account account;

  const UpdateAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}

/// Delete an account
class DeleteAccountEvent extends AccountsEvent {
  final int id;
  final bool permanent;

  const DeleteAccountEvent(this.id, {this.permanent = false});

  @override
  List<Object?> get props => [id, permanent];
}

/// Filter accounts by type
class FilterByType extends AccountsEvent {
  final AccountType? type;

  const FilterByType(this.type);

  @override
  List<Object?> get props => [type];
}

