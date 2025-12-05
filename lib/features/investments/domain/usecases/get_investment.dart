import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/investment.dart';
import '../repositories/investment_repository.dart';

/// Use case to get a single investment by ID
class GetInvestment {
  final InvestmentRepository repository;

  GetInvestment(this.repository);

  Future<Either<Failure, Investment>> call(int id) async {
    return repository.getInvestmentById(id);
  }
}

