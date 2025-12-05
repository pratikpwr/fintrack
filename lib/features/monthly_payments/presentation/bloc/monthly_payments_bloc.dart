import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/monthly_payment.dart';
import '../../domain/usecases/create_monthly_payment.dart';
import '../../domain/usecases/delete_monthly_payment.dart';
import '../../domain/usecases/get_monthly_payment.dart';
import '../../domain/usecases/get_monthly_payments.dart';
import '../../domain/usecases/mark_payment_as_paid.dart';
import '../../domain/usecases/update_monthly_payment.dart';

part 'monthly_payments_event.dart';
part 'monthly_payments_state.dart';

/// Bloc for managing monthly payments state
class MonthlyPaymentsBloc
    extends Bloc<MonthlyPaymentsEvent, MonthlyPaymentsState> {
  final GetMonthlyPayments getMonthlyPayments;
  final GetMonthlyPayment getMonthlyPayment;
  final CreateMonthlyPayment createMonthlyPayment;
  final UpdateMonthlyPayment updateMonthlyPayment;
  final DeleteMonthlyPayment deleteMonthlyPayment;
  final MarkPaymentAsPaid markPaymentAsPaid;

  MonthlyPaymentsBloc({
    required this.getMonthlyPayments,
    required this.getMonthlyPayment,
    required this.createMonthlyPayment,
    required this.updateMonthlyPayment,
    required this.deleteMonthlyPayment,
    required this.markPaymentAsPaid,
  }) : super(const MonthlyPaymentsState()) {
    on<LoadMonthlyPayments>(_onLoadMonthlyPayments);
    on<LoadMonthlyPayment>(_onLoadMonthlyPayment);
    on<CreateMonthlyPaymentEvent>(_onCreateMonthlyPayment);
    on<UpdateMonthlyPaymentEvent>(_onUpdateMonthlyPayment);
    on<DeleteMonthlyPaymentEvent>(_onDeleteMonthlyPayment);
    on<MarkAsPaidEvent>(_onMarkAsPaid);
    on<FilterByPaymentCategory>(_onFilterByCategory);
  }

  Future<void> _onLoadMonthlyPayments(
    LoadMonthlyPayments event,
    Emitter<MonthlyPaymentsState> emit,
  ) async {
    emit(state.copyWith(status: MonthlyPaymentsStatus.loading, clearError: true));

    final result = await getMonthlyPayments(
      GetMonthlyPaymentsParams(includeInactive: event.includeInactive),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.error,
        errorMessage: failure.message,
      )),
      (payments) {
        final totalMonthly = payments
            .where((p) => p.isActive)
            .fold(0.0, (sum, p) => sum + (p.amount / p.frequency.monthsInterval));

        emit(state.copyWith(
          status: MonthlyPaymentsStatus.loaded,
          payments: payments,
          totalMonthlyExpenses: totalMonthly,
        ));
      },
    );
  }

  Future<void> _onLoadMonthlyPayment(
    LoadMonthlyPayment event,
    Emitter<MonthlyPaymentsState> emit,
  ) async {
    emit(state.copyWith(status: MonthlyPaymentsStatus.loading, clearError: true));

    final result = await getMonthlyPayment(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.error,
        errorMessage: failure.message,
      )),
      (payment) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.loaded,
        selectedPayment: payment,
      )),
    );
  }

  Future<void> _onCreateMonthlyPayment(
    CreateMonthlyPaymentEvent event,
    Emitter<MonthlyPaymentsState> emit,
  ) async {
    emit(state.copyWith(status: MonthlyPaymentsStatus.loading, clearError: true));

    final result = await createMonthlyPayment(event.payment);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.error,
        errorMessage: failure.message,
      )),
      (payment) {
        final updatedPayments = [...state.payments, payment];
        final totalMonthly = updatedPayments
            .where((p) => p.isActive)
            .fold(0.0, (sum, p) => sum + (p.amount / p.frequency.monthsInterval));

        emit(state.copyWith(
          status: MonthlyPaymentsStatus.loaded,
          payments: updatedPayments,
          selectedPayment: payment,
          totalMonthlyExpenses: totalMonthly,
        ));
      },
    );
  }

  Future<void> _onUpdateMonthlyPayment(
    UpdateMonthlyPaymentEvent event,
    Emitter<MonthlyPaymentsState> emit,
  ) async {
    emit(state.copyWith(status: MonthlyPaymentsStatus.loading, clearError: true));

    final result = await updateMonthlyPayment(event.payment);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.error,
        errorMessage: failure.message,
      )),
      (payment) {
        final updatedPayments = state.payments
            .map((p) => p.id == payment.id ? payment : p)
            .toList();
        final totalMonthly = updatedPayments
            .where((p) => p.isActive)
            .fold(0.0, (sum, p) => sum + (p.amount / p.frequency.monthsInterval));

        emit(state.copyWith(
          status: MonthlyPaymentsStatus.loaded,
          payments: updatedPayments,
          selectedPayment: payment,
          totalMonthlyExpenses: totalMonthly,
        ));
      },
    );
  }

  Future<void> _onDeleteMonthlyPayment(
    DeleteMonthlyPaymentEvent event,
    Emitter<MonthlyPaymentsState> emit,
  ) async {
    emit(state.copyWith(status: MonthlyPaymentsStatus.loading, clearError: true));

    final result = await deleteMonthlyPayment(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedPayments =
            state.payments.where((p) => p.id != event.id).toList();
        final totalMonthly = updatedPayments
            .where((p) => p.isActive)
            .fold(0.0, (sum, p) => sum + (p.amount / p.frequency.monthsInterval));

        emit(state.copyWith(
          status: MonthlyPaymentsStatus.loaded,
          payments: updatedPayments,
          clearSelectedPayment: true,
          totalMonthlyExpenses: totalMonthly,
        ));
      },
    );
  }

  Future<void> _onMarkAsPaid(
    MarkAsPaidEvent event,
    Emitter<MonthlyPaymentsState> emit,
  ) async {
    emit(state.copyWith(status: MonthlyPaymentsStatus.loading, clearError: true));

    final result = await markPaymentAsPaid(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MonthlyPaymentsStatus.error,
        errorMessage: failure.message,
      )),
      (payment) {
        final updatedPayments = state.payments
            .map((p) => p.id == payment.id ? payment : p)
            .toList();

        emit(state.copyWith(
          status: MonthlyPaymentsStatus.loaded,
          payments: updatedPayments,
        ));
      },
    );
  }

  void _onFilterByCategory(
    FilterByPaymentCategory event,
    Emitter<MonthlyPaymentsState> emit,
  ) {
    if (event.category == null) {
      emit(state.copyWith(clearFilterCategory: true));
    } else {
      emit(state.copyWith(filterCategory: event.category));
    }
  }
}

