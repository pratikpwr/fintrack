import 'package:isar/isar.dart';
import '../../domain/entities/account.dart';

part 'account_model.g.dart';

/// Isar collection for storing accounts
@collection
class AccountModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  @Enumerated(EnumType.name)
  late AccountType type;

  late double balance;

  String? bankName;

  String? accountNumber;

  String? description;

  late bool isActive;

  @Index()
  late bool isArchived;

  late DateTime createdAt;

  late DateTime updatedAt;

  /// Convert to domain entity
  Account toDomain() {
    return Account(
      id: id,
      name: name,
      type: type,
      balance: balance,
      bankName: bankName,
      accountNumber: accountNumber,
      description: description,
      isActive: isActive,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  static AccountModel fromDomain(Account account) {
    return AccountModel()
      ..id = account.id == 0 ? Isar.autoIncrement : account.id
      ..name = account.name
      ..type = account.type
      ..balance = account.balance
      ..bankName = account.bankName
      ..accountNumber = account.accountNumber
      ..description = account.description
      ..isActive = account.isActive
      ..isArchived = account.isArchived
      ..createdAt = account.createdAt
      ..updatedAt = account.updatedAt;
  }
}

