import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/investment.dart';
import '../../domain/repositories/investment_repository.dart';
import '../datasources/investment_local_datasource.dart';
import '../models/investment_model.dart';

/// Implementation of InvestmentRepository
class InvestmentRepositoryImpl implements InvestmentRepository {
  final InvestmentLocalDataSource localDataSource;

  InvestmentRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Investment>>> getInvestments({
    bool includeInactive = false,
  }) async {
    try {
      final models = await localDataSource.getInvestments(
        includeInactive: includeInactive,
      );
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get investments: $e'));
    }
  }

  @override
  Future<Either<Failure, Investment>> getInvestmentById(int id) async {
    try {
      final model = await localDataSource.getInvestmentById(id);
      if (model == null) {
        return const Left(NotFoundFailure('Investment not found'));
      }
      return Right(model.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get investment: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Investment>>> getInvestmentsByType(
    InvestmentType type,
  ) async {
    try {
      final models = await localDataSource.getInvestmentsByType(type);
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get investments by type: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Investment>>> getInvestmentsByAccount(
    int accountId,
  ) async {
    try {
      final models = await localDataSource.getInvestmentsByAccount(accountId);
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get investments by account: $e'));
    }
  }

  @override
  Future<Either<Failure, Investment>> createInvestment(
    Investment investment,
  ) async {
    try {
      final model = InvestmentModel.fromDomain(investment);
      final created = await localDataSource.createInvestment(model);
      return Right(created.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to create investment: $e'));
    }
  }

  @override
  Future<Either<Failure, Investment>> updateInvestment(
    Investment investment,
  ) async {
    try {
      final model = InvestmentModel.fromDomain(investment);
      final updated = await localDataSource.updateInvestment(model);
      return Right(updated.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to update investment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInvestment(int id) async {
    try {
      await localDataSource.deleteInvestment(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete investment: $e'));
    }
  }

  @override
  Future<Either<Failure, Investment>> updateCurrentPrice(
    int id,
    double newPrice,
  ) async {
    try {
      final model = await localDataSource.getInvestmentById(id);
      if (model == null) {
        return const Left(NotFoundFailure('Investment not found'));
      }
      model.currentPrice = newPrice;
      model.updatedAt = DateTime.now();
      final updated = await localDataSource.updateInvestment(model);
      return Right(updated.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to update investment price: $e'));
    }
  }

  @override
  Stream<List<Investment>> watchInvestments({bool includeInactive = false}) {
    return localDataSource
        .watchInvestments(includeInactive: includeInactive)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }

  @override
  Future<Either<Failure, double>> getTotalInvestedAmount() async {
    try {
      final total = await localDataSource.getTotalInvestedAmount();
      return Right(total);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get total invested amount: $e'));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalCurrentValue() async {
    try {
      final total = await localDataSource.getTotalCurrentValue();
      return Right(total);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get total current value: $e'));
    }
  }
}

