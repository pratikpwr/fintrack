import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Parameters for getting accounts
class GetAccountsParams {
  final bool includeArchived;
  final AccountType? filterByType;

  const GetAccountsParams({
    this.includeArchived = false,
    this.filterByType,
  });
}

/// Use case to get all accounts
class GetAccounts {
  final AccountRepository repository;

  GetAccounts(this.repository);

  Future<Either<Failure, List<Account>>> call([
    GetAccountsParams params = const GetAccountsParams(),
  ]) async {
    if (params.filterByType != null) {
      return repository.getAccountsByType(params.filterByType!);
    }
    return repository.getAccounts(includeArchived: params.includeArchived);
  }

  /// Watch accounts for changes
  Stream<List<Account>> watch({bool includeArchived = false}) {
    return repository.watchAccounts(includeArchived: includeArchived);
  }
}

