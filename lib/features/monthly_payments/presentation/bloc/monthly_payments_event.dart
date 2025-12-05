part of 'monthly_payments_bloc.dart';

/// Base event class for monthly payments
abstract class MonthlyPaymentsEvent extends Equatable {
  const MonthlyPaymentsEvent();

  @override
  List<Object?> get props => [];
}

/// Load all monthly payments
class LoadMonthlyPayments extends MonthlyPaymentsEvent {
  final bool includeInactive;

  const LoadMonthlyPayments({this.includeInactive = false});

  @override
  List<Object?> get props => [includeInactive];
}

/// Load a single monthly payment
class LoadMonthlyPayment extends MonthlyPaymentsEvent {
  final int id;

  const LoadMonthlyPayment(this.id);

  @override
  List<Object?> get props => [id];
}

/// Create a new monthly payment
class CreateMonthlyPaymentEvent extends MonthlyPaymentsEvent {
  final MonthlyPayment payment;

  const CreateMonthlyPaymentEvent(this.payment);

  @override
  List<Object?> get props => [payment];
}

/// Update an existing monthly payment
class UpdateMonthlyPaymentEvent extends MonthlyPaymentsEvent {
  final MonthlyPayment payment;

  const UpdateMonthlyPaymentEvent(this.payment);

  @override
  List<Object?> get props => [payment];
}

/// Delete a monthly payment
class DeleteMonthlyPaymentEvent extends MonthlyPaymentsEvent {
  final int id;

  const DeleteMonthlyPaymentEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Mark payment as paid
class MarkAsPaidEvent extends MonthlyPaymentsEvent {
  final int id;

  const MarkAsPaidEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Filter payments by category
class FilterByPaymentCategory extends MonthlyPaymentsEvent {
  final PaymentCategory? category;

  const FilterByPaymentCategory(this.category);

  @override
  List<Object?> get props => [category];
}

