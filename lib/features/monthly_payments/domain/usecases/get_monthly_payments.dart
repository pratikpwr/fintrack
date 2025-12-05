import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_payment.dart';
import '../repositories/monthly_payment_repository.dart';

/// Parameters for getting monthly payments
class GetMonthlyPaymentsParams {
  final bool includeInactive;
  final PaymentCategory? filterByCategory;

  const GetMonthlyPaymentsParams({
    this.includeInactive = false,
    this.filterByCategory,
  });
}

/// Use case to get all monthly payments
class GetMonthlyPayments {
  final MonthlyPaymentRepository repository;

  GetMonthlyPayments(this.repository);

  Future<Either<Failure, List<MonthlyPayment>>> call([
    GetMonthlyPaymentsParams params = const GetMonthlyPaymentsParams(),
  ]) async {
    if (params.filterByCategory != null) {
      return repository.getMonthlyPaymentsByCategory(params.filterByCategory!);
    }
    return repository.getMonthlyPayments(
      includeInactive: params.includeInactive,
    );
  }

  /// Watch monthly payments for changes
  Stream<List<MonthlyPayment>> watch({bool includeInactive = false}) {
    return repository.watchMonthlyPayments(includeInactive: includeInactive);
  }
}

