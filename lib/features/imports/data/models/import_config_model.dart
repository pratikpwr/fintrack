import 'package:isar/isar.dart';
import '../../domain/entities/import_config.dart';

part 'import_config_model.g.dart';

/// Isar collection for storing import configurations
@collection
class ImportConfigModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  String? bankName;

  // Column mapping
  int? dateColumn;
  int? amountColumn;
  int? descriptionColumn;
  int? typeColumn;
  int? categoryColumn;
  late String dateFormat;
  late bool hasHeader;
  late String delimiter;

  int? defaultAccountId;

  @Index()
  late bool isDefault;

  late DateTime createdAt;
  late DateTime updatedAt;

  /// Convert to domain entity
  ImportConfig toDomain() {
    return ImportConfig(
      id: id,
      name: name,
      bankName: bankName,
      columnMapping: ColumnMapping(
        dateColumn: dateColumn,
        amountColumn: amountColumn,
        descriptionColumn: descriptionColumn,
        typeColumn: typeColumn,
        categoryColumn: categoryColumn,
        dateFormat: dateFormat,
        hasHeader: hasHeader,
        delimiter: delimiter,
      ),
      defaultAccountId: defaultAccountId,
      isDefault: isDefault,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  static ImportConfigModel fromDomain(ImportConfig config) {
    return ImportConfigModel()
      ..id = config.id == 0 ? Isar.autoIncrement : config.id
      ..name = config.name
      ..bankName = config.bankName
      ..dateColumn = config.columnMapping.dateColumn
      ..amountColumn = config.columnMapping.amountColumn
      ..descriptionColumn = config.columnMapping.descriptionColumn
      ..typeColumn = config.columnMapping.typeColumn
      ..categoryColumn = config.columnMapping.categoryColumn
      ..dateFormat = config.columnMapping.dateFormat
      ..hasHeader = config.columnMapping.hasHeader
      ..delimiter = config.columnMapping.delimiter
      ..defaultAccountId = config.defaultAccountId
      ..isDefault = config.isDefault
      ..createdAt = config.createdAt
      ..updatedAt = config.updatedAt;
  }
}

