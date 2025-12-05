part of 'investments_bloc.dart';

/// Base event class for investments
abstract class InvestmentsEvent extends Equatable {
  const InvestmentsEvent();

  @override
  List<Object?> get props => [];
}

/// Load all investments
class LoadInvestments extends InvestmentsEvent {
  final bool includeInactive;

  const LoadInvestments({this.includeInactive = false});

  @override
  List<Object?> get props => [includeInactive];
}

/// Load a single investment
class LoadInvestment extends InvestmentsEvent {
  final int id;

  const LoadInvestment(this.id);

  @override
  List<Object?> get props => [id];
}

/// Create a new investment
class CreateInvestmentEvent extends InvestmentsEvent {
  final Investment investment;

  const CreateInvestmentEvent(this.investment);

  @override
  List<Object?> get props => [investment];
}

/// Update an existing investment
class UpdateInvestmentEvent extends InvestmentsEvent {
  final Investment investment;

  const UpdateInvestmentEvent(this.investment);

  @override
  List<Object?> get props => [investment];
}

/// Delete an investment
class DeleteInvestmentEvent extends InvestmentsEvent {
  final int id;

  const DeleteInvestmentEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Update current price of an investment
class UpdatePriceEvent extends InvestmentsEvent {
  final int id;
  final double newPrice;

  const UpdatePriceEvent({required this.id, required this.newPrice});

  @override
  List<Object?> get props => [id, newPrice];
}

/// Filter investments by type
class FilterByInvestmentType extends InvestmentsEvent {
  final InvestmentType? type;

  const FilterByInvestmentType(this.type);

  @override
  List<Object?> get props => [type];
}

