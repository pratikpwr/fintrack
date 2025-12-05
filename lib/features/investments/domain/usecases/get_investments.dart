import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/investment.dart';
import '../repositories/investment_repository.dart';

/// Parameters for getting investments
class GetInvestmentsParams {
  final bool includeInactive;
  final InvestmentType? filterByType;

  const GetInvestmentsParams({
    this.includeInactive = false,
    this.filterByType,
  });
}

/// Use case to get all investments
class GetInvestments {
  final InvestmentRepository repository;

  GetInvestments(this.repository);

  Future<Either<Failure, List<Investment>>> call([
    GetInvestmentsParams params = const GetInvestmentsParams(),
  ]) async {
    if (params.filterByType != null) {
      return repository.getInvestmentsByType(params.filterByType!);
    }
    return repository.getInvestments(includeInactive: params.includeInactive);
  }

  /// Watch investments for changes
  Stream<List<Investment>> watch({bool includeInactive = false}) {
    return repository.watchInvestments(includeInactive: includeInactive);
  }
}

