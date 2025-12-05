import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_payment.dart';
import '../repositories/monthly_payment_repository.dart';

/// Use case to create a new monthly payment
class CreateMonthlyPayment {
  final MonthlyPaymentRepository repository;

  CreateMonthlyPayment(this.repository);

  Future<Either<Failure, MonthlyPayment>> call(MonthlyPayment payment) async {
    // Validate payment data
    if (payment.name.trim().isEmpty) {
      return const Left(ValidationFailure('Payment name is required'));
    }

    if (payment.amount <= 0) {
      return const Left(ValidationFailure('Amount must be greater than 0'));
    }

    if (payment.dueDay < 1 || payment.dueDay > 31) {
      return const Left(ValidationFailure('Due day must be between 1 and 31'));
    }

    return repository.createMonthlyPayment(payment);
  }
}

