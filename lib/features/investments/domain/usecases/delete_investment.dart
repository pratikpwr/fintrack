import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/investment_repository.dart';

/// Use case to delete an investment
class DeleteInvestment {
  final InvestmentRepository repository;

  DeleteInvestment(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    if (id <= 0) {
      return const Left(ValidationFailure('Invalid investment ID'));
    }

    return repository.deleteInvestment(id);
  }
}

