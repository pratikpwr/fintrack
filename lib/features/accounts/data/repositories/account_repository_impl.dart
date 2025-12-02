import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_local_datasource.dart';
import '../models/account_model.dart';

/// Implementation of AccountRepository
class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDataSource localDataSource;

  AccountRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Account>>> getAccounts({
    bool includeArchived = false,
  }) async {
    try {
      final models = await localDataSource.getAccounts(
        includeArchived: includeArchived,
      );
      return Right(models.map((m) => m.toDomain()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Account>>> getAccountsByType(
    AccountType type,
  ) async {
    try {
      final models = await localDataSource.getAccountsByType(type);
      return Right(models.map((m) => m.toDomain()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> getAccount(int id) async {
    try {
      final model = await localDataSource.getAccount(id);
      return Right(model.toDomain());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> createAccount(Account account) async {
    try {
      final model = AccountModel.fromDomain(account);
      final created = await localDataSource.createAccount(model);
      return Right(created.toDomain());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> updateAccount(Account account) async {
    try {
      final model = AccountModel.fromDomain(account);
      final updated = await localDataSource.updateAccount(model);
      return Right(updated.toDomain());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> updateBalance(
    int id,
    double newBalance,
  ) async {
    try {
      final model = await localDataSource.getAccount(id);
      model.balance = newBalance;
      model.updatedAt = DateTime.now();
      final updated = await localDataSource.updateAccount(model);
      return Right(updated.toDomain());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> archiveAccount(int id) async {
    try {
      final model = await localDataSource.getAccount(id);
      model.isArchived = true;
      model.updatedAt = DateTime.now();
      await localDataSource.updateAccount(model);
      return const Right(unit);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount(int id) async {
    try {
      await localDataSource.deleteAccount(id);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalAssets() async {
    try {
      final total = await localDataSource.getTotalAssets();
      return Right(total);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalLiabilities() async {
    try {
      final total = await localDataSource.getTotalLiabilities();
      return Right(total);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<List<Account>> watchAccounts({bool includeArchived = false}) {
    return localDataSource
        .watchAccounts(includeArchived: includeArchived)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }
}

