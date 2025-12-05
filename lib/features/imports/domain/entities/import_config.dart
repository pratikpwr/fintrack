import 'package:equatable/equatable.dart';

/// Column mapping for CSV import
class ColumnMapping extends Equatable {
  final int? dateColumn;
  final int? amountColumn;
  final int? descriptionColumn;
  final int? typeColumn;
  final int? categoryColumn;
  final String dateFormat;
  final bool hasHeader;
  final String delimiter;

  const ColumnMapping({
    this.dateColumn,
    this.amountColumn,
    this.descriptionColumn,
    this.typeColumn,
    this.categoryColumn,
    this.dateFormat = 'dd/MM/yyyy',
    this.hasHeader = true,
    this.delimiter = ',',
  });

  ColumnMapping copyWith({
    int? dateColumn,
    int? amountColumn,
    int? descriptionColumn,
    int? typeColumn,
    int? categoryColumn,
    String? dateFormat,
    bool? hasHeader,
    String? delimiter,
  }) {
    return ColumnMapping(
      dateColumn: dateColumn ?? this.dateColumn,
      amountColumn: amountColumn ?? this.amountColumn,
      descriptionColumn: descriptionColumn ?? this.descriptionColumn,
      typeColumn: typeColumn ?? this.typeColumn,
      categoryColumn: categoryColumn ?? this.categoryColumn,
      dateFormat: dateFormat ?? this.dateFormat,
      hasHeader: hasHeader ?? this.hasHeader,
      delimiter: delimiter ?? this.delimiter,
    );
  }

  bool get isValid =>
      dateColumn != null && amountColumn != null;

  @override
  List<Object?> get props => [
        dateColumn,
        amountColumn,
        descriptionColumn,
        typeColumn,
        categoryColumn,
        dateFormat,
        hasHeader,
        delimiter,
      ];
}

/// Import configuration for a specific account/bank format
class ImportConfig extends Equatable {
  final int id;
  final String name;
  final String? bankName;
  final ColumnMapping columnMapping;
  final int? defaultAccountId;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ImportConfig({
    required this.id,
    required this.name,
    this.bankName,
    required this.columnMapping,
    this.defaultAccountId,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImportConfig.create({
    required String name,
    String? bankName,
    required ColumnMapping columnMapping,
    int? defaultAccountId,
    bool isDefault = false,
  }) {
    final now = DateTime.now();
    return ImportConfig(
      id: 0,
      name: name,
      bankName: bankName,
      columnMapping: columnMapping,
      defaultAccountId: defaultAccountId,
      isDefault: isDefault,
      createdAt: now,
      updatedAt: now,
    );
  }

  ImportConfig copyWith({
    int? id,
    String? name,
    String? bankName,
    ColumnMapping? columnMapping,
    int? defaultAccountId,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ImportConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      bankName: bankName ?? this.bankName,
      columnMapping: columnMapping ?? this.columnMapping,
      defaultAccountId: defaultAccountId ?? this.defaultAccountId,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        bankName,
        columnMapping,
        defaultAccountId,
        isDefault,
        createdAt,
        updatedAt,
      ];
}

