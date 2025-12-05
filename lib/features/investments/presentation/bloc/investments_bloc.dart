import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/investment.dart';
import '../../domain/usecases/create_investment.dart';
import '../../domain/usecases/delete_investment.dart';
import '../../domain/usecases/get_investment.dart';
import '../../domain/usecases/get_investments.dart';
import '../../domain/usecases/update_investment.dart';
import '../../domain/usecases/update_investment_price.dart';

part 'investments_event.dart';
part 'investments_state.dart';

/// Bloc for managing investments state
class InvestmentsBloc extends Bloc<InvestmentsEvent, InvestmentsState> {
  final GetInvestments getInvestments;
  final GetInvestment getInvestment;
  final CreateInvestment createInvestment;
  final UpdateInvestment updateInvestment;
  final DeleteInvestment deleteInvestment;
  final UpdateInvestmentPrice updateInvestmentPrice;

  InvestmentsBloc({
    required this.getInvestments,
    required this.getInvestment,
    required this.createInvestment,
    required this.updateInvestment,
    required this.deleteInvestment,
    required this.updateInvestmentPrice,
  }) : super(const InvestmentsState()) {
    on<LoadInvestments>(_onLoadInvestments);
    on<LoadInvestment>(_onLoadInvestment);
    on<CreateInvestmentEvent>(_onCreateInvestment);
    on<UpdateInvestmentEvent>(_onUpdateInvestment);
    on<DeleteInvestmentEvent>(_onDeleteInvestment);
    on<UpdatePriceEvent>(_onUpdatePrice);
    on<FilterByInvestmentType>(_onFilterByType);
  }

  Future<void> _onLoadInvestments(
    LoadInvestments event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(state.copyWith(status: InvestmentsStatus.loading, clearError: true));

    final result = await getInvestments(
      GetInvestmentsParams(includeInactive: event.includeInactive),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: InvestmentsStatus.error,
        errorMessage: failure.message,
      )),
      (investments) {
        final totalInvested = investments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.investedAmount);
        final totalCurrentValue = investments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.currentValue);

        emit(state.copyWith(
          status: InvestmentsStatus.loaded,
          investments: investments,
          totalInvested: totalInvested,
          totalCurrentValue: totalCurrentValue,
        ));
      },
    );
  }

  Future<void> _onLoadInvestment(
    LoadInvestment event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(state.copyWith(status: InvestmentsStatus.loading, clearError: true));

    final result = await getInvestment(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: InvestmentsStatus.error,
        errorMessage: failure.message,
      )),
      (investment) => emit(state.copyWith(
        status: InvestmentsStatus.loaded,
        selectedInvestment: investment,
      )),
    );
  }

  Future<void> _onCreateInvestment(
    CreateInvestmentEvent event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(state.copyWith(status: InvestmentsStatus.loading, clearError: true));

    final result = await createInvestment(event.investment);

    result.fold(
      (failure) => emit(state.copyWith(
        status: InvestmentsStatus.error,
        errorMessage: failure.message,
      )),
      (investment) {
        final updatedInvestments = [...state.investments, investment];
        final totalInvested = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.investedAmount);
        final totalCurrentValue = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.currentValue);

        emit(state.copyWith(
          status: InvestmentsStatus.loaded,
          investments: updatedInvestments,
          selectedInvestment: investment,
          totalInvested: totalInvested,
          totalCurrentValue: totalCurrentValue,
        ));
      },
    );
  }

  Future<void> _onUpdateInvestment(
    UpdateInvestmentEvent event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(state.copyWith(status: InvestmentsStatus.loading, clearError: true));

    final result = await updateInvestment(event.investment);

    result.fold(
      (failure) => emit(state.copyWith(
        status: InvestmentsStatus.error,
        errorMessage: failure.message,
      )),
      (investment) {
        final updatedInvestments = state.investments
            .map((i) => i.id == investment.id ? investment : i)
            .toList();
        final totalInvested = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.investedAmount);
        final totalCurrentValue = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.currentValue);

        emit(state.copyWith(
          status: InvestmentsStatus.loaded,
          investments: updatedInvestments,
          selectedInvestment: investment,
          totalInvested: totalInvested,
          totalCurrentValue: totalCurrentValue,
        ));
      },
    );
  }

  Future<void> _onDeleteInvestment(
    DeleteInvestmentEvent event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(state.copyWith(status: InvestmentsStatus.loading, clearError: true));

    final result = await deleteInvestment(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: InvestmentsStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedInvestments =
            state.investments.where((i) => i.id != event.id).toList();
        final totalInvested = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.investedAmount);
        final totalCurrentValue = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.currentValue);

        emit(state.copyWith(
          status: InvestmentsStatus.loaded,
          investments: updatedInvestments,
          clearSelectedInvestment: true,
          totalInvested: totalInvested,
          totalCurrentValue: totalCurrentValue,
        ));
      },
    );
  }

  Future<void> _onUpdatePrice(
    UpdatePriceEvent event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(state.copyWith(status: InvestmentsStatus.loading, clearError: true));

    final result = await updateInvestmentPrice(event.id, event.newPrice);

    result.fold(
      (failure) => emit(state.copyWith(
        status: InvestmentsStatus.error,
        errorMessage: failure.message,
      )),
      (investment) {
        final updatedInvestments = state.investments
            .map((i) => i.id == investment.id ? investment : i)
            .toList();
        final totalInvested = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.investedAmount);
        final totalCurrentValue = updatedInvestments
            .where((i) => i.isActive)
            .fold(0.0, (sum, i) => sum + i.currentValue);

        emit(state.copyWith(
          status: InvestmentsStatus.loaded,
          investments: updatedInvestments,
          totalInvested: totalInvested,
          totalCurrentValue: totalCurrentValue,
        ));
      },
    );
  }

  void _onFilterByType(
    FilterByInvestmentType event,
    Emitter<InvestmentsState> emit,
  ) {
    if (event.type == null) {
      emit(state.copyWith(clearFilterType: true));
    } else {
      emit(state.copyWith(filterType: event.type));
    }
  }
}

