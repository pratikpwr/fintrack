import 'package:equatable/equatable.dart';

/// Account type enumeration
enum AccountType {
  bank,
  cash,
  investment,
  fixedDeposit,
  loan,
  creditCard,
  family,
}

/// Extension for AccountType
extension AccountTypeExtension on AccountType {
  String get displayName {
    switch (this) {
      case AccountType.bank:
        return 'Bank Account';
      case AccountType.cash:
        return 'Cash';
      case AccountType.investment:
        return 'Investment';
      case AccountType.fixedDeposit:
        return 'Fixed Deposit';
      case AccountType.loan:
        return 'Loan';
      case AccountType.creditCard:
        return 'Credit Card';
      case AccountType.family:
        return 'Family';
    }
  }

  String get shortName {
    switch (this) {
      case AccountType.bank:
        return 'Bank';
      case AccountType.cash:
        return 'Cash';
      case AccountType.investment:
        return 'Investment';
      case AccountType.fixedDeposit:
        return 'FD';
      case AccountType.loan:
        return 'Loan';
      case AccountType.creditCard:
        return 'Card';
      case AccountType.family:
        return 'Family';
    }
  }

  /// Whether this account type is an asset
  bool get isAsset {
    switch (this) {
      case AccountType.bank:
      case AccountType.cash:
      case AccountType.investment:
      case AccountType.fixedDeposit:
        return true;
      case AccountType.loan:
      case AccountType.creditCard:
      case AccountType.family:
        return false;
    }
  }

  /// Whether this account type is a liability
  bool get isLiability {
    switch (this) {
      case AccountType.loan:
      case AccountType.creditCard:
        return true;
      default:
        return false;
    }
  }
}

/// Account entity representing a financial account
class Account extends Equatable {
  final int id;
  final String name;
  final AccountType type;
  final double balance;
  final String? bankName;
  final String? accountNumber;
  final String? description;
  final bool isActive;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    this.bankName,
    this.accountNumber,
    this.description,
    this.isActive = true,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a new account with default values
  factory Account.create({
    required String name,
    required AccountType type,
    double balance = 0,
    String? bankName,
    String? accountNumber,
    String? description,
  }) {
    final now = DateTime.now();
    return Account(
      id: 0, // Will be assigned by database
      name: name,
      type: type,
      balance: balance,
      bankName: bankName,
      accountNumber: accountNumber,
      description: description,
      isActive: true,
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Create a copy with updated fields
  Account copyWith({
    int? id,
    String? name,
    AccountType? type,
    double? balance,
    String? bankName,
    String? accountNumber,
    String? description,
    bool? isActive,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        balance,
        bankName,
        accountNumber,
        description,
        isActive,
        isArchived,
        createdAt,
        updatedAt,
      ];
}

