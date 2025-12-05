import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_payment.dart';
import '../repositories/monthly_payment_repository.dart';

/// Use case to get a single monthly payment by ID
class GetMonthlyPayment {
  final MonthlyPaymentRepository repository;

  GetMonthlyPayment(this.repository);

  Future<Either<Failure, MonthlyPayment>> call(int id) async {
    return repository.getMonthlyPaymentById(id);
  }
}

