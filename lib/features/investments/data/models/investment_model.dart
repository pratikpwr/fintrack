import 'package:isar/isar.dart';
import '../../domain/entities/investment.dart';

part 'investment_model.g.dart';

/// Isar collection for storing investments
@collection
class InvestmentModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  String? symbol;

  @Enumerated(EnumType.name)
  late InvestmentType type;

  late double quantity;

  late double purchasePrice;

  late double currentPrice;

  late DateTime purchaseDate;

  int? linkedAccountId;

  String? notes;

  @Index()
  late bool isActive;

  late DateTime createdAt;

  late DateTime updatedAt;

  /// Convert to domain entity
  Investment toDomain() {
    return Investment(
      id: id,
      name: name,
      symbol: symbol,
      type: type,
      quantity: quantity,
      purchasePrice: purchasePrice,
      currentPrice: currentPrice,
      purchaseDate: purchaseDate,
      linkedAccountId: linkedAccountId,
      notes: notes,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  static InvestmentModel fromDomain(Investment investment) {
    return InvestmentModel()
      ..id = investment.id == 0 ? Isar.autoIncrement : investment.id
      ..name = investment.name
      ..symbol = investment.symbol
      ..type = investment.type
      ..quantity = investment.quantity
      ..purchasePrice = investment.purchasePrice
      ..currentPrice = investment.currentPrice
      ..purchaseDate = investment.purchaseDate
      ..linkedAccountId = investment.linkedAccountId
      ..notes = investment.notes
      ..isActive = investment.isActive
      ..createdAt = investment.createdAt
      ..updatedAt = investment.updatedAt;
  }
}

