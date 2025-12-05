import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_payment.dart';
import '../repositories/monthly_payment_repository.dart';

/// Use case to update an existing monthly payment
class UpdateMonthlyPayment {
  final MonthlyPaymentRepository repository;

  UpdateMonthlyPayment(this.repository);

  Future<Either<Failure, MonthlyPayment>> call(MonthlyPayment payment) async {
    // Validate payment data
    if (payment.id == 0) {
      return const Left(ValidationFailure('Invalid payment ID'));
    }

    if (payment.name.trim().isEmpty) {
      return const Left(ValidationFailure('Payment name is required'));
    }

    if (payment.amount <= 0) {
      return const Left(ValidationFailure('Amount must be greater than 0'));
    }

    if (payment.dueDay < 1 || payment.dueDay > 31) {
      return const Left(ValidationFailure('Due day must be between 1 and 31'));
    }

    return repository.updateMonthlyPayment(payment);
  }
}

