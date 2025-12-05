import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/investment.dart';

/// Repository interface for investment operations
abstract class InvestmentRepository {
  /// Get all investments
  Future<Either<Failure, List<Investment>>> getInvestments({
    bool includeInactive = false,
  });

  /// Get investment by ID
  Future<Either<Failure, Investment>> getInvestmentById(int id);

  /// Get investments by type
  Future<Either<Failure, List<Investment>>> getInvestmentsByType(
    InvestmentType type,
  );

  /// Get investments by linked account
  Future<Either<Failure, List<Investment>>> getInvestmentsByAccount(
    int accountId,
  );

  /// Create a new investment
  Future<Either<Failure, Investment>> createInvestment(Investment investment);

  /// Update an existing investment
  Future<Either<Failure, Investment>> updateInvestment(Investment investment);

  /// Delete an investment
  Future<Either<Failure, void>> deleteInvestment(int id);

  /// Update current price of an investment
  Future<Either<Failure, Investment>> updateCurrentPrice(
    int id,
    double newPrice,
  );

  /// Watch investments for changes
  Stream<List<Investment>> watchInvestments({bool includeInactive = false});

  /// Get total invested amount
  Future<Either<Failure, double>> getTotalInvestedAmount();

  /// Get total current value
  Future<Either<Failure, double>> getTotalCurrentValue();
}

