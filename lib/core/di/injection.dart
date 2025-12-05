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

// Investments feature
import '../../features/investments/data/datasources/investment_local_datasource.dart';
import '../../features/investments/data/repositories/investment_repository_impl.dart';
import '../../features/investments/domain/repositories/investment_repository.dart';
import '../../features/investments/domain/usecases/create_investment.dart';
import '../../features/investments/domain/usecases/delete_investment.dart';
import '../../features/investments/domain/usecases/get_investment.dart';
import '../../features/investments/domain/usecases/get_investments.dart';
import '../../features/investments/domain/usecases/update_investment.dart';
import '../../features/investments/domain/usecases/update_investment_price.dart';
import '../../features/investments/presentation/bloc/investments_bloc.dart';

// Monthly Payments feature
import '../../features/monthly_payments/data/datasources/monthly_payment_local_datasource.dart';
import '../../features/monthly_payments/data/repositories/monthly_payment_repository_impl.dart';
import '../../features/monthly_payments/domain/repositories/monthly_payment_repository.dart';
import '../../features/monthly_payments/domain/usecases/create_monthly_payment.dart';
import '../../features/monthly_payments/domain/usecases/delete_monthly_payment.dart';
import '../../features/monthly_payments/domain/usecases/get_monthly_payment.dart';
import '../../features/monthly_payments/domain/usecases/get_monthly_payments.dart';
import '../../features/monthly_payments/domain/usecases/mark_payment_as_paid.dart';
import '../../features/monthly_payments/domain/usecases/update_monthly_payment.dart';
import '../../features/monthly_payments/presentation/bloc/monthly_payments_bloc.dart';

// Imports feature
import '../../features/imports/data/datasources/import_local_datasource.dart';
import '../../features/imports/data/repositories/import_repository_impl.dart';
import '../../features/imports/domain/repositories/import_repository.dart';
import '../../features/imports/domain/usecases/parse_csv_file.dart';
import '../../features/imports/domain/usecases/import_transactions.dart';
import '../../features/imports/domain/usecases/get_import_history.dart';
import '../../features/imports/domain/usecases/delete_import_batch.dart';
import '../../features/imports/presentation/bloc/import_bloc.dart';

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

  // ===== Investments Feature =====
  
  // Data sources
  getIt.registerLazySingleton<InvestmentLocalDataSource>(
    () => InvestmentLocalDataSourceImpl(isar: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<InvestmentRepository>(
    () => InvestmentRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetInvestments(getIt()));
  getIt.registerLazySingleton(() => GetInvestment(getIt()));
  getIt.registerLazySingleton(() => CreateInvestment(getIt()));
  getIt.registerLazySingleton(() => UpdateInvestment(getIt()));
  getIt.registerLazySingleton(() => DeleteInvestment(getIt()));
  getIt.registerLazySingleton(() => UpdateInvestmentPrice(getIt()));

  // Bloc
  getIt.registerFactory(
    () => InvestmentsBloc(
      getInvestments: getIt(),
      getInvestment: getIt(),
      createInvestment: getIt(),
      updateInvestment: getIt(),
      deleteInvestment: getIt(),
      updateInvestmentPrice: getIt(),
    ),
  );

  // ===== Monthly Payments Feature =====
  
  // Data sources
  getIt.registerLazySingleton<MonthlyPaymentLocalDataSource>(
    () => MonthlyPaymentLocalDataSourceImpl(isar: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<MonthlyPaymentRepository>(
    () => MonthlyPaymentRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetMonthlyPayments(getIt()));
  getIt.registerLazySingleton(() => GetMonthlyPayment(getIt()));
  getIt.registerLazySingleton(() => CreateMonthlyPayment(getIt()));
  getIt.registerLazySingleton(() => UpdateMonthlyPayment(getIt()));
  getIt.registerLazySingleton(() => DeleteMonthlyPayment(getIt()));
  getIt.registerLazySingleton(() => MarkPaymentAsPaid(getIt()));

  // Bloc
  getIt.registerFactory(
    () => MonthlyPaymentsBloc(
      getMonthlyPayments: getIt(),
      getMonthlyPayment: getIt(),
      createMonthlyPayment: getIt(),
      updateMonthlyPayment: getIt(),
      deleteMonthlyPayment: getIt(),
      markPaymentAsPaid: getIt(),
    ),
  );

  // ===== Imports Feature =====
  
  // Data sources
  getIt.registerLazySingleton<ImportLocalDataSource>(
    () => ImportLocalDataSourceImpl(isar: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ImportRepository>(
    () => ImportRepositoryImpl(localDataSource: getIt(), isar: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => ParseCsvFile(getIt()));
  getIt.registerLazySingleton(() => ImportTransactions(getIt()));
  getIt.registerLazySingleton(() => GetImportHistory(getIt()));
  getIt.registerLazySingleton(() => DeleteImportBatch(getIt()));

  // Bloc
  getIt.registerFactory(
    () => ImportBloc(
      parseCsvFile: getIt(),
      importTransactions: getIt(),
      getImportHistory: getIt(),
      deleteImportBatch: getIt(),
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

