import 'package:equatable/equatable.dart';

/// Transaction type enumeration
enum TransactionType {
  income,
  expense,
  transfer,
  familyTransfer,
  investment,
  loanPayment,
  adjustment,
}

/// Extension for TransactionType
extension TransactionTypeExtension on TransactionType {
  String get displayName {
    switch (this) {
      case TransactionType.income:
        return 'Income';
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.transfer:
        return 'Transfer';
      case TransactionType.familyTransfer:
        return 'Family Transfer';
      case TransactionType.investment:
        return 'Investment';
      case TransactionType.loanPayment:
        return 'Loan Payment';
      case TransactionType.adjustment:
        return 'Adjustment';
    }
  }

  /// Whether this transaction affects analytics (income/expense)
  bool get affectsAnalytics {
    return this == TransactionType.income || this == TransactionType.expense;
  }

  /// Whether this is a transfer between accounts
  bool get isTransfer {
    return this == TransactionType.transfer ||
        this == TransactionType.familyTransfer;
  }
}

/// Payment method enumeration
enum PaymentMethod {
  cash,
  bankTransfer,
  upi,
  creditCard,
  debitCard,
  cheque,
  other,
}

/// Extension for PaymentMethod
extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.upi:
        return 'UPI';
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.debitCard:
        return 'Debit Card';
      case PaymentMethod.cheque:
        return 'Cheque';
      case PaymentMethod.other:
        return 'Other';
    }
  }
}

/// Transaction source enumeration
enum TransactionSource {
  manual,
  excelImport,
  smsImport,
  recurring,
}

/// Transaction entity representing a financial transaction
class Transaction extends Equatable {
  final int id;
  final DateTime date;
  final double amount;
  final TransactionType type;
  final int accountId;
  final int? toAccountId; // For transfers
  final String? categoryId;
  final String? description;
  final String? notes;
  final PaymentMethod paymentMethod;
  final TransactionSource source;
  final String? familyMemberId; // For family transfers
  final String? creditCardId; // For credit card expenses
  final String? importBatchId; // For imported transactions
  final DateTime createdAt;
  final DateTime updatedAt;

  const Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.accountId,
    this.toAccountId,
    this.categoryId,
    this.description,
    this.notes,
    this.paymentMethod = PaymentMethod.other,
    this.source = TransactionSource.manual,
    this.familyMemberId,
    this.creditCardId,
    this.importBatchId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a new transaction with default values
  factory Transaction.create({
    required DateTime date,
    required double amount,
    required TransactionType type,
    required int accountId,
    int? toAccountId,
    String? categoryId,
    String? description,
    String? notes,
    PaymentMethod paymentMethod = PaymentMethod.other,
    TransactionSource source = TransactionSource.manual,
    String? familyMemberId,
    String? creditCardId,
  }) {
    final now = DateTime.now();
    return Transaction(
      id: 0,
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
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Create a copy with updated fields
  Transaction copyWith({
    int? id,
    DateTime? date,
    double? amount,
    TransactionType? type,
    int? accountId,
    int? toAccountId,
    String? categoryId,
    String? description,
    String? notes,
    PaymentMethod? paymentMethod,
    TransactionSource? source,
    String? familyMemberId,
    String? creditCardId,
    String? importBatchId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearToAccountId = false,
    bool clearCategoryId = false,
    bool clearFamilyMemberId = false,
    bool clearCreditCardId = false,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      toAccountId: clearToAccountId ? null : toAccountId ?? this.toAccountId,
      categoryId: clearCategoryId ? null : categoryId ?? this.categoryId,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      source: source ?? this.source,
      familyMemberId:
          clearFamilyMemberId ? null : familyMemberId ?? this.familyMemberId,
      creditCardId:
          clearCreditCardId ? null : creditCardId ?? this.creditCardId,
      importBatchId: importBatchId ?? this.importBatchId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Get signed amount (negative for expenses)
  double get signedAmount {
    if (type == TransactionType.expense ||
        type == TransactionType.familyTransfer ||
        type == TransactionType.loanPayment) {
      return -amount.abs();
    }
    return amount.abs();
  }

  @override
  List<Object?> get props => [
        id,
        date,
        amount,
        type,
        accountId,
        toAccountId,
        categoryId,
        description,
        notes,
        paymentMethod,
        source,
        familyMemberId,
        creditCardId,
        importBatchId,
        createdAt,
        updatedAt,
      ];
}

