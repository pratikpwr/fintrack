import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../database/database.dart';

// Accounts feature
import '../../features/accounts/data/datasources/account_local_datasource.dart';
import '../../features/accounts/data/repositories/account_repository_impl.dart';
import '../../features/accounts/domain/repositories/account_repository.dart';
import '../../features/accounts/domain/usecases/create_account.dart';
import '../../features/accounts/domain/usecases/delete_account.dart';
import '../../features/accounts/domain/usecases/get_account.dart';
import '../../features/accounts/domain/usecases/get_accounts.dart';
import '../../features/accounts/domain/usecases/update_account.dart';
import '../../features/accounts/presentation/bloc/accounts_bloc.dart';

// Transactions feature
import '../../features/transactions/data/datasources/transaction_local_datasource.dart';
import '../../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/domain/usecases/create_transaction.dart';
import '../../features/transactions/domain/usecases/delete_transaction.dart';
import '../../features/transactions/domain/usecases/get_transactions.dart';
import '../../features/transactions/domain/usecases/update_transaction.dart';
import '../../features/transactions/presentation/bloc/transactions_bloc.dart';

// Dashboard feature
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';

final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Database
  await DatabaseService.initialize();
  getIt.registerSingleton<Isar>(DatabaseService.instance);

  // ===== Accounts Feature =====
  
  // Data sources
  getIt.registerLazySingleton<AccountLocalDataSource>(
    () => AccountLocalDataSourceImpl(isar: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAccounts(getIt()));
  getIt.registerLazySingleton(() => GetAccount(getIt()));
  getIt.registerLazySingleton(() => CreateAccount(getIt()));
  getIt.registerLazySingleton(() => UpdateAccount(getIt()));
  getIt.registerLazySingleton(() => DeleteAccount(getIt()));

  // Bloc
  getIt.registerFactory(
    () => AccountsBloc(
      getAccounts: getIt(),
      getAccount: getIt(),
      createAccount: getIt(),
      updateAccount: getIt(),
      deleteAccount: getIt(),
    ),
  );

  // ===== Transactions Feature =====
  
  // Data sources
  getIt.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(isar: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetTransactions(getIt()));
  getIt.registerLazySingleton(() => CreateTransaction(getIt()));
  getIt.registerLazySingleton(() => UpdateTransaction(getIt()));
  getIt.registerLazySingleton(() => DeleteTransaction(getIt()));

  // Bloc
  getIt.registerFactory(
    () => TransactionsBloc(
      getTransactions: getIt(),
      createTransaction: getIt(),
      updateTransaction: getIt(),
      deleteTransaction: getIt(),
    ),
  );

  // ===== Dashboard Feature =====
  
  getIt.registerFactory(
    () => DashboardBloc(
      getAccounts: getIt(),
      getTransactions: getIt(),
    ),
  );
}

