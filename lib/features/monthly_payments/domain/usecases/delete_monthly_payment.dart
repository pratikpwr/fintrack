import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/monthly_payment_repository.dart';

/// Use case to delete a monthly payment
class DeleteMonthlyPayment {
  final MonthlyPaymentRepository repository;

  DeleteMonthlyPayment(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    if (id <= 0) {
      return const Left(ValidationFailure('Invalid payment ID'));
    }

    return repository.deleteMonthlyPayment(id);
  }
}

