import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/investment.dart';
import '../repositories/investment_repository.dart';

/// Use case to update the current price of an investment
class UpdateInvestmentPrice {
  final InvestmentRepository repository;

  UpdateInvestmentPrice(this.repository);

  Future<Either<Failure, Investment>> call(int id, double newPrice) async {
    if (id <= 0) {
      return const Left(ValidationFailure('Invalid investment ID'));
    }

    if (newPrice < 0) {
      return const Left(ValidationFailure('Price cannot be negative'));
    }

    return repository.updateCurrentPrice(id, newPrice);
  }
}

