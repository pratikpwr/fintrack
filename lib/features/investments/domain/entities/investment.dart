import 'package:equatable/equatable.dart';

/// Investment type enumeration
enum InvestmentType {
  stock,
  mutualFund,
  etf,
  bond,
  gold,
  realEstate,
  crypto,
  other,
}

/// Extension for InvestmentType
extension InvestmentTypeExtension on InvestmentType {
  String get displayName {
    switch (this) {
      case InvestmentType.stock:
        return 'Stock';
      case InvestmentType.mutualFund:
        return 'Mutual Fund';
      case InvestmentType.etf:
        return 'ETF';
      case InvestmentType.bond:
        return 'Bond';
      case InvestmentType.gold:
        return 'Gold';
      case InvestmentType.realEstate:
        return 'Real Estate';
      case InvestmentType.crypto:
        return 'Cryptocurrency';
      case InvestmentType.other:
        return 'Other';
    }
  }

  String get shortName {
    switch (this) {
      case InvestmentType.stock:
        return 'Stock';
      case InvestmentType.mutualFund:
        return 'MF';
      case InvestmentType.etf:
        return 'ETF';
      case InvestmentType.bond:
        return 'Bond';
      case InvestmentType.gold:
        return 'Gold';
      case InvestmentType.realEstate:
        return 'RE';
      case InvestmentType.crypto:
        return 'Crypto';
      case InvestmentType.other:
        return 'Other';
    }
  }
}

/// Investment entity representing a financial investment
class Investment extends Equatable {
  final int id;
  final String name;
  final String? symbol;
  final InvestmentType type;
  final double quantity;
  final double purchasePrice;
  final double currentPrice;
  final DateTime purchaseDate;
  final int? linkedAccountId;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Investment({
    required this.id,
    required this.name,
    this.symbol,
    required this.type,
    required this.quantity,
    required this.purchasePrice,
    required this.currentPrice,
    required this.purchaseDate,
    this.linkedAccountId,
    this.notes,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Calculate invested amount
  double get investedAmount => quantity * purchasePrice;

  /// Calculate current value
  double get currentValue => quantity * currentPrice;

  /// Calculate profit/loss
  double get profitLoss => currentValue - investedAmount;

  /// Calculate profit/loss percentage
  double get profitLossPercentage {
    if (investedAmount == 0) return 0;
    return (profitLoss / investedAmount) * 100;
  }

  /// Check if investment is profitable
  bool get isProfitable => profitLoss >= 0;

  /// Create a new investment with default values
  factory Investment.create({
    required String name,
    String? symbol,
    required InvestmentType type,
    required double quantity,
    required double purchasePrice,
    double? currentPrice,
    required DateTime purchaseDate,
    int? linkedAccountId,
    String? notes,
  }) {
    final now = DateTime.now();
    return Investment(
      id: 0,
      name: name,
      symbol: symbol,
      type: type,
      quantity: quantity,
      purchasePrice: purchasePrice,
      currentPrice: currentPrice ?? purchasePrice,
      purchaseDate: purchaseDate,
      linkedAccountId: linkedAccountId,
      notes: notes,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Create a copy with updated fields
  Investment copyWith({
    int? id,
    String? name,
    String? symbol,
    InvestmentType? type,
    double? quantity,
    double? purchasePrice,
    double? currentPrice,
    DateTime? purchaseDate,
    int? linkedAccountId,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Investment(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      currentPrice: currentPrice ?? this.currentPrice,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        type,
        quantity,
        purchasePrice,
        currentPrice,
        purchaseDate,
        linkedAccountId,
        notes,
        isActive,
        createdAt,
        updatedAt,
      ];
}

