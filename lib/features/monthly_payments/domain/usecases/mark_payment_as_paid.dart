import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_payment.dart';
import '../repositories/monthly_payment_repository.dart';

/// Use case to mark a payment as paid
class MarkPaymentAsPaid {
  final MonthlyPaymentRepository repository;

  MarkPaymentAsPaid(this.repository);

  Future<Either<Failure, MonthlyPayment>> call(int id) async {
    if (id <= 0) {
      return const Left(ValidationFailure('Invalid payment ID'));
    }

    return repository.markAsPaid(id);
  }
}

