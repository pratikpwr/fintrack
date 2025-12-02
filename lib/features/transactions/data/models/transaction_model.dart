import 'package:isar/isar.dart';
import '../../domain/entities/transaction.dart';

part 'transaction_model.g.dart';

/// Isar collection for storing transactions
@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  late double amount;

  @Enumerated(EnumType.name)
  late TransactionType type;

  @Index()
  late int accountId;

  int? toAccountId;

  String? categoryId;

  String? description;

  String? notes;

  @Enumerated(EnumType.name)
  late PaymentMethod paymentMethod;

  @Enumerated(EnumType.name)
  late TransactionSource source;

  String? familyMemberId;

  String? creditCardId;

  String? importBatchId;

  late DateTime createdAt;

  late DateTime updatedAt;

  /// Convert to domain entity
  Transaction toDomain() {
    return Transaction(
      id: id,
      date: date,
      amount: amount,
      type: type,
      accountId: accountId,
      toAccountId: toAccountId,
      categoryId: categoryId,
      description: description,
      notes: notes,
      paymentMethod: paymentMethod,
      source: source,
      familyMemberId: familyMemberId,
      creditCardId: creditCardId,
      importBatchId: importBatchId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  static TransactionModel fromDomain(Transaction transaction) {
    return TransactionModel()
      ..id = transaction.id == 0 ? Isar.autoIncrement : transaction.id
      ..date = transaction.date
      ..amount = transaction.amount
      ..type = transaction.type
      ..accountId = transaction.accountId
      ..toAccountId = transaction.toAccountId
      ..categoryId = transaction.categoryId
      ..description = transaction.description
      ..notes = transaction.notes
      ..paymentMethod = transaction.paymentMethod
      ..source = transaction.source
      ..familyMemberId = transaction.familyMemberId
      ..creditCardId = transaction.creditCardId
      ..importBatchId = transaction.importBatchId
      ..createdAt = transaction.createdAt
      ..updatedAt = transaction.updatedAt;
  }
}

