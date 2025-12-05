import 'package:isar/isar.dart';
import '../../domain/entities/monthly_payment.dart';

part 'monthly_payment_model.g.dart';

/// Isar collection for storing monthly payments
@collection
class MonthlyPaymentModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  late double amount;

  @Enumerated(EnumType.name)
  late PaymentCategory category;

  @Enumerated(EnumType.name)
  late PaymentFrequency frequency;

  late int dueDay;

  int? linkedAccountId;

  String? description;

  @Index()
  late bool isActive;

  late bool autoDebit;

  DateTime? lastPaidDate;

  @Index()
  DateTime? nextDueDate;

  late DateTime createdAt;

  late DateTime updatedAt;

  /// Convert to domain entity
  MonthlyPayment toDomain() {
    return MonthlyPayment(
      id: id,
      name: name,
      amount: amount,
      category: category,
      frequency: frequency,
      dueDay: dueDay,
      linkedAccountId: linkedAccountId,
      description: description,
      isActive: isActive,
      autoDebit: autoDebit,
      lastPaidDate: lastPaidDate,
      nextDueDate: nextDueDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  static MonthlyPaymentModel fromDomain(MonthlyPayment payment) {
    return MonthlyPaymentModel()
      ..id = payment.id == 0 ? Isar.autoIncrement : payment.id
      ..name = payment.name
      ..amount = payment.amount
      ..category = payment.category
      ..frequency = payment.frequency
      ..dueDay = payment.dueDay
      ..linkedAccountId = payment.linkedAccountId
      ..description = payment.description
      ..isActive = payment.isActive
      ..autoDebit = payment.autoDebit
      ..lastPaidDate = payment.lastPaidDate
      ..nextDueDate = payment.nextDueDate
      ..createdAt = payment.createdAt
      ..updatedAt = payment.updatedAt;
  }
}

