import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/investment.dart';
import '../repositories/investment_repository.dart';

/// Use case to create a new investment
class CreateInvestment {
  final InvestmentRepository repository;

  CreateInvestment(this.repository);

  Future<Either<Failure, Investment>> call(Investment investment) async {
    // Validate investment data
    if (investment.name.trim().isEmpty) {
      return const Left(ValidationFailure('Investment name is required'));
    }

    if (investment.quantity <= 0) {
      return const Left(ValidationFailure('Quantity must be greater than 0'));
    }

    if (investment.purchasePrice < 0) {
      return const Left(ValidationFailure('Purchase price cannot be negative'));
    }

    return repository.createInvestment(investment);
  }
}

