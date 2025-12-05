// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_config_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetImportConfigModelCollection on Isar {
  IsarCollection<ImportConfigModel> get importConfigModels => this.collection();
}

const ImportConfigModelSchema = CollectionSchema(
  name: r'ImportConfigModel',
  id: 8034304880795830666,
  properties: {
    r'amountColumn': PropertySchema(
      id: 0,
      name: r'amountColumn',
      type: IsarType.long,
    ),
    r'bankName': PropertySchema(
      id: 1,
      name: r'bankName',
      type: IsarType.string,
    ),
    r'categoryColumn': PropertySchema(
      id: 2,
      name: r'categoryColumn',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateColumn': PropertySchema(
      id: 4,
      name: r'dateColumn',
      type: IsarType.long,
    ),
    r'dateFormat': PropertySchema(
      id: 5,
      name: r'dateFormat',
      type: IsarType.string,
    ),
    r'defaultAccountId': PropertySchema(
      id: 6,
      name: r'defaultAccountId',
      type: IsarType.long,
    ),
    r'delimiter': PropertySchema(
      id: 7,
      name: r'delimiter',
      type: IsarType.string,
    ),
    r'descriptionColumn': PropertySchema(
      id: 8,
      name: r'descriptionColumn',
      type: IsarType.long,
    ),
    r'hasHeader': PropertySchema(
      id: 9,
      name: r'hasHeader',
      type: IsarType.bool,
    ),
    r'isDefault': PropertySchema(
      id: 10,
      name: r'isDefault',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'typeColumn': PropertySchema(
      id: 12,
      name: r'typeColumn',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _importConfigModelEstimateSize,
  serialize: _importConfigModelSerialize,
  deserialize: _importConfigModelDeserialize,
  deserializeProp: _importConfigModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isDefault': IndexSchema(
      id: -6569979013669400724,
      name: r'isDefault',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDefault',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _importConfigModelGetId,
  getLinks: _importConfigModelGetLinks,
  attach: _importConfigModelAttach,
  version: '3.1.0+1',
);

int _importConfigModelEstimateSize(
  ImportConfigModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bankName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.dateFormat.length * 3;
  bytesCount += 3 + object.delimiter.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _importConfigModelSerialize(
  ImportConfigModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amountColumn);
  writer.writeString(offsets[1], object.bankName);
  writer.writeLong(offsets[2], object.categoryColumn);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.dateColumn);
  writer.writeString(offsets[5], object.dateFormat);
  writer.writeLong(offsets[6], object.defaultAccountId);
  writer.writeString(offsets[7], object.delimiter);
  writer.writeLong(offsets[8], object.descriptionColumn);
  writer.writeBool(offsets[9], object.hasHeader);
  writer.writeBool(offsets[10], object.isDefault);
  writer.writeString(offsets[11], object.name);
  writer.writeLong(offsets[12], object.typeColumn);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

ImportConfigModel _importConfigModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImportConfigModel();
  object.amountColumn = reader.readLongOrNull(offsets[0]);
  object.bankName = reader.readStringOrNull(offsets[1]);
  object.categoryColumn = reader.readLongOrNull(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.dateColumn = reader.readLongOrNull(offsets[4]);
  object.dateFormat = reader.readString(offsets[5]);
  object.defaultAccountId = reader.readLongOrNull(offsets[6]);
  object.delimiter = reader.readString(offsets[7]);
  object.descriptionColumn = reader.readLongOrNull(offsets[8]);
  object.hasHeader = reader.readBool(offsets[9]);
  object.id = id;
  object.isDefault = reader.readBool(offsets[10]);
  object.name = reader.readString(offsets[11]);
  object.typeColumn = reader.readLongOrNull(offsets[12]);
  object.updatedAt = reader.readDateTime(offsets[13]);
  return object;
}

P _importConfigModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _importConfigModelGetId(ImportConfigModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _importConfigModelGetLinks(
    ImportConfigModel object) {
  return [];
}

void _importConfigModelAttach(
    IsarCollection<dynamic> col, Id id, ImportConfigModel object) {
  object.id = id;
}

extension ImportConfigModelQueryWhereSort
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QWhere> {
  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhere>
      anyIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDefault'),
      );
    });
  }
}

extension ImportConfigModelQueryWhere
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QWhereClause> {
  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      isDefaultEqualTo(bool isDefault) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDefault',
        value: [isDefault],
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterWhereClause>
      isDefaultNotEqualTo(bool isDefault) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [],
              upper: [isDefault],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [isDefault],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [isDefault],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [],
              upper: [isDefault],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ImportConfigModelQueryFilter
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QFilterCondition> {
  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      amountColumnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      amountColumnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      amountColumnEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      amountColumnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      amountColumnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      amountColumnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountColumn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bankName',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bankName',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankName',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      bankNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankName',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      categoryColumnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      categoryColumnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      categoryColumnEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      categoryColumnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      categoryColumnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      categoryColumnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryColumn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateColumnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateColumnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateColumnEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateColumnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateColumnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateColumnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateColumn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateFormat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateFormat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateFormat',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      dateFormatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateFormat',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      defaultAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultAccountId',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      defaultAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultAccountId',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      defaultAccountIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      defaultAccountIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      defaultAccountIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      defaultAccountIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'delimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'delimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'delimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'delimiter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'delimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'delimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'delimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'delimiter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'delimiter',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      delimiterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'delimiter',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      descriptionColumnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descriptionColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      descriptionColumnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descriptionColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      descriptionColumnEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      descriptionColumnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      descriptionColumnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      descriptionColumnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionColumn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      hasHeaderEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasHeader',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      isDefaultEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      typeColumnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'typeColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      typeColumnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'typeColumn',
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      typeColumnEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      typeColumnGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typeColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      typeColumnLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typeColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      typeColumnBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typeColumn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImportConfigModelQueryObject
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QFilterCondition> {}

extension ImportConfigModelQueryLinks
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QFilterCondition> {}

extension ImportConfigModelQuerySortBy
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QSortBy> {
  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByAmountColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByAmountColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByBankName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByBankNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByCategoryColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByCategoryColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDateColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDateColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDateFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDefaultAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultAccountId', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDefaultAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultAccountId', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDelimiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delimiter', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDelimiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delimiter', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDescriptionColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByDescriptionColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByHasHeader() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHeader', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByHasHeaderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHeader', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByTypeColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByTypeColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ImportConfigModelQuerySortThenBy
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QSortThenBy> {
  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByAmountColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByAmountColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByBankName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByBankNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByCategoryColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByCategoryColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDateColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDateColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDateFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDefaultAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultAccountId', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDefaultAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultAccountId', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDelimiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delimiter', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDelimiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delimiter', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDescriptionColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByDescriptionColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByHasHeader() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHeader', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByHasHeaderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHeader', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByTypeColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeColumn', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByTypeColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeColumn', Sort.desc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ImportConfigModelQueryWhereDistinct
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct> {
  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByAmountColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountColumn');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByBankName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByCategoryColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryColumn');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByDateColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateColumn');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByDateFormat({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateFormat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByDefaultAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultAccountId');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByDelimiter({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'delimiter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByDescriptionColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descriptionColumn');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByHasHeader() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasHeader');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDefault');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByTypeColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeColumn');
    });
  }

  QueryBuilder<ImportConfigModel, ImportConfigModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ImportConfigModelQueryProperty
    on QueryBuilder<ImportConfigModel, ImportConfigModel, QQueryProperty> {
  QueryBuilder<ImportConfigModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ImportConfigModel, int?, QQueryOperations>
      amountColumnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountColumn');
    });
  }

  QueryBuilder<ImportConfigModel, String?, QQueryOperations>
      bankNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankName');
    });
  }

  QueryBuilder<ImportConfigModel, int?, QQueryOperations>
      categoryColumnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryColumn');
    });
  }

  QueryBuilder<ImportConfigModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ImportConfigModel, int?, QQueryOperations> dateColumnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateColumn');
    });
  }

  QueryBuilder<ImportConfigModel, String, QQueryOperations>
      dateFormatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateFormat');
    });
  }

  QueryBuilder<ImportConfigModel, int?, QQueryOperations>
      defaultAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultAccountId');
    });
  }

  QueryBuilder<ImportConfigModel, String, QQueryOperations>
      delimiterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'delimiter');
    });
  }

  QueryBuilder<ImportConfigModel, int?, QQueryOperations>
      descriptionColumnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descriptionColumn');
    });
  }

  QueryBuilder<ImportConfigModel, bool, QQueryOperations> hasHeaderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasHeader');
    });
  }

  QueryBuilder<ImportConfigModel, bool, QQueryOperations> isDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDefault');
    });
  }

  QueryBuilder<ImportConfigModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ImportConfigModel, int?, QQueryOperations> typeColumnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeColumn');
    });
  }

  QueryBuilder<ImportConfigModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
