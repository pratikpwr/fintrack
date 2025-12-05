part of 'investments_bloc.dart';

/// State status enum
enum InvestmentsStatus {
  initial,
  loading,
  loaded,
  error,
}

/// State class for investments
class InvestmentsState extends Equatable {
  final InvestmentsStatus status;
  final List<Investment> investments;
  final Investment? selectedInvestment;
  final InvestmentType? filterType;
  final String? errorMessage;
  final double totalInvested;
  final double totalCurrentValue;

  const InvestmentsState({
    this.status = InvestmentsStatus.initial,
    this.investments = const [],
    this.selectedInvestment,
    this.filterType,
    this.errorMessage,
    this.totalInvested = 0,
    this.totalCurrentValue = 0,
  });

  /// Total profit/loss
  double get totalProfitLoss => totalCurrentValue - totalInvested;

  /// Profit/loss percentage
  double get profitLossPercentage {
    if (totalInvested == 0) return 0;
    return (totalProfitLoss / totalInvested) * 100;
  }

  /// Check if overall portfolio is profitable
  bool get isProfitable => totalProfitLoss >= 0;

  /// Get investments grouped by type
  Map<InvestmentType, List<Investment>> get investmentsByType {
    final grouped = <InvestmentType, List<Investment>>{};
    for (final investment in investments) {
      grouped.putIfAbsent(investment.type, () => []).add(investment);
    }
    return grouped;
  }

  /// Get filtered investments
  List<Investment> get filteredInvestments {
    if (filterType == null) return investments;
    return investments.where((i) => i.type == filterType).toList();
  }

  /// Get profitable investments
  List<Investment> get profitableInvestments {
    return investments.where((i) => i.isProfitable).toList();
  }

  /// Get loss-making investments
  List<Investment> get lossMakingInvestments {
    return investments.where((i) => !i.isProfitable).toList();
  }

  InvestmentsState copyWith({
    InvestmentsStatus? status,
    List<Investment>? investments,
    Investment? selectedInvestment,
    InvestmentType? filterType,
    String? errorMessage,
    double? totalInvested,
    double? totalCurrentValue,
    bool clearSelectedInvestment = false,
    bool clearFilterType = false,
    bool clearError = false,
  }) {
    return InvestmentsState(
      status: status ?? this.status,
      investments: investments ?? this.investments,
      selectedInvestment: clearSelectedInvestment
          ? null
          : selectedInvestment ?? this.selectedInvestment,
      filterType: clearFilterType ? null : filterType ?? this.filterType,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      totalInvested: totalInvested ?? this.totalInvested,
      totalCurrentValue: totalCurrentValue ?? this.totalCurrentValue,
    );
  }

  @override
  List<Object?> get props => [
        status,
        investments,
        selectedInvestment,
        filterType,
        errorMessage,
        totalInvested,
        totalCurrentValue,
      ];
}

