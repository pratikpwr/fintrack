// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_batch_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetImportBatchModelCollection on Isar {
  IsarCollection<ImportBatchModel> get importBatchModels => this.collection();
}

const ImportBatchModelSchema = CollectionSchema(
  name: r'ImportBatchModel',
  id: -3074125849536843113,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.long,
    ),
    r'completedAt': PropertySchema(
      id: 1,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'errors': PropertySchema(
      id: 3,
      name: r'errors',
      type: IsarType.stringList,
    ),
    r'failedRows': PropertySchema(
      id: 4,
      name: r'failedRows',
      type: IsarType.long,
    ),
    r'fileName': PropertySchema(
      id: 5,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'importDate': PropertySchema(
      id: 7,
      name: r'importDate',
      type: IsarType.dateTime,
    ),
    r'importedRows': PropertySchema(
      id: 8,
      name: r'importedRows',
      type: IsarType.long,
    ),
    r'skippedRows': PropertySchema(
      id: 9,
      name: r'skippedRows',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 10,
      name: r'status',
      type: IsarType.string,
      enumMap: _ImportBatchModelstatusEnumValueMap,
    ),
    r'totalRows': PropertySchema(
      id: 11,
      name: r'totalRows',
      type: IsarType.long,
    )
  },
  estimateSize: _importBatchModelEstimateSize,
  serialize: _importBatchModelSerialize,
  deserialize: _importBatchModelDeserialize,
  deserializeProp: _importBatchModelDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'fileName': IndexSchema(
      id: -6213672517780651480,
      name: r'fileName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fileName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'importDate': IndexSchema(
      id: 7960976230929175791,
      name: r'importDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'importDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _importBatchModelGetId,
  getLinks: _importBatchModelGetLinks,
  attach: _importBatchModelAttach,
  version: '3.1.0+1',
);

int _importBatchModelEstimateSize(
  ImportBatchModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.errors;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.fileName.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  return bytesCount;
}

void _importBatchModelSerialize(
  ImportBatchModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accountId);
  writer.writeDateTime(offsets[1], object.completedAt);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeStringList(offsets[3], object.errors);
  writer.writeLong(offsets[4], object.failedRows);
  writer.writeString(offsets[5], object.fileName);
  writer.writeString(offsets[6], object.id);
  writer.writeDateTime(offsets[7], object.importDate);
  writer.writeLong(offsets[8], object.importedRows);
  writer.writeLong(offsets[9], object.skippedRows);
  writer.writeString(offsets[10], object.status.name);
  writer.writeLong(offsets[11], object.totalRows);
}

ImportBatchModel _importBatchModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImportBatchModel();
  object.accountId = reader.readLong(offsets[0]);
  object.completedAt = reader.readDateTimeOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.errors = reader.readStringList(offsets[3]);
  object.failedRows = reader.readLong(offsets[4]);
  object.fileName = reader.readString(offsets[5]);
  object.id = reader.readString(offsets[6]);
  object.importDate = reader.readDateTime(offsets[7]);
  object.importedRows = reader.readLong(offsets[8]);
  object.isarId = id;
  object.skippedRows = reader.readLong(offsets[9]);
  object.status = _ImportBatchModelstatusValueEnumMap[
          reader.readStringOrNull(offsets[10])] ??
      ImportStatus.pending;
  object.totalRows = reader.readLong(offsets[11]);
  return object;
}

P _importBatchModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (_ImportBatchModelstatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ImportStatus.pending) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ImportBatchModelstatusEnumValueMap = {
  r'pending': r'pending',
  r'processing': r'processing',
  r'completed': r'completed',
  r'failed': r'failed',
  r'partiallyCompleted': r'partiallyCompleted',
};
const _ImportBatchModelstatusValueEnumMap = {
  r'pending': ImportStatus.pending,
  r'processing': ImportStatus.processing,
  r'completed': ImportStatus.completed,
  r'failed': ImportStatus.failed,
  r'partiallyCompleted': ImportStatus.partiallyCompleted,
};

Id _importBatchModelGetId(ImportBatchModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _importBatchModelGetLinks(ImportBatchModel object) {
  return [];
}

void _importBatchModelAttach(
    IsarCollection<dynamic> col, Id id, ImportBatchModel object) {
  object.isarId = id;
}

extension ImportBatchModelByIndex on IsarCollection<ImportBatchModel> {
  Future<ImportBatchModel?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  ImportBatchModel? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<ImportBatchModel?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<ImportBatchModel?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(ImportBatchModel object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(ImportBatchModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<ImportBatchModel> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<ImportBatchModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension ImportBatchModelQueryWhereSort
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QWhere> {
  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhere>
      anyImportDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'importDate'),
      );
    });
  }
}

extension ImportBatchModelQueryWhere
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QWhereClause> {
  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      fileNameEqualTo(String fileName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileName',
        value: [fileName],
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      fileNameNotEqualTo(String fileName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileName',
              lower: [],
              upper: [fileName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileName',
              lower: [fileName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileName',
              lower: [fileName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileName',
              lower: [],
              upper: [fileName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      importDateEqualTo(DateTime importDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'importDate',
        value: [importDate],
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      importDateNotEqualTo(DateTime importDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'importDate',
              lower: [],
              upper: [importDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'importDate',
              lower: [importDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'importDate',
              lower: [importDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'importDate',
              lower: [],
              upper: [importDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      importDateGreaterThan(
    DateTime importDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'importDate',
        lower: [importDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      importDateLessThan(
    DateTime importDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'importDate',
        lower: [],
        upper: [importDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterWhereClause>
      importDateBetween(
    DateTime lowerImportDate,
    DateTime upperImportDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'importDate',
        lower: [lowerImportDate],
        includeLower: includeLower,
        upper: [upperImportDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImportBatchModelQueryFilter
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QFilterCondition> {
  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      accountIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      accountIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      accountIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      accountIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
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

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
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

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
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

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errors',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errors',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errors',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'errors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'errors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'errors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'errors',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errors',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'errors',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'errors',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'errors',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'errors',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'errors',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'errors',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      errorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'errors',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      failedRowsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      failedRowsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'failedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      failedRowsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'failedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      failedRowsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'failedRows',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importedRowsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importedRowsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importedRowsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      importedRowsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importedRows',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      skippedRowsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skippedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      skippedRowsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'skippedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      skippedRowsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'skippedRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      skippedRowsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'skippedRows',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusEqualTo(
    ImportStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusGreaterThan(
    ImportStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusLessThan(
    ImportStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusBetween(
    ImportStatus lower,
    ImportStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      totalRowsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      totalRowsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      totalRowsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRows',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterFilterCondition>
      totalRowsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRows',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImportBatchModelQueryObject
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QFilterCondition> {}

extension ImportBatchModelQueryLinks
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QFilterCondition> {}

extension ImportBatchModelQuerySortBy
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QSortBy> {
  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByFailedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByFailedRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedRows', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByImportDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importDate', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByImportDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importDate', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByImportedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByImportedRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedRows', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortBySkippedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skippedRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortBySkippedRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skippedRows', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByTotalRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      sortByTotalRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRows', Sort.desc);
    });
  }
}

extension ImportBatchModelQuerySortThenBy
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QSortThenBy> {
  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByFailedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByFailedRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedRows', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByImportDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importDate', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByImportDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importDate', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByImportedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByImportedRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedRows', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenBySkippedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skippedRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenBySkippedRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skippedRows', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByTotalRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRows', Sort.asc);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QAfterSortBy>
      thenByTotalRowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRows', Sort.desc);
    });
  }
}

extension ImportBatchModelQueryWhereDistinct
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct> {
  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByErrors() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errors');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByFailedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'failedRows');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByImportDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'importDate');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByImportedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'importedRows');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctBySkippedRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skippedRows');
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImportBatchModel, ImportBatchModel, QDistinct>
      distinctByTotalRows() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRows');
    });
  }
}

extension ImportBatchModelQueryProperty
    on QueryBuilder<ImportBatchModel, ImportBatchModel, QQueryProperty> {
  QueryBuilder<ImportBatchModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ImportBatchModel, int, QQueryOperations> accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<ImportBatchModel, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<ImportBatchModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ImportBatchModel, List<String>?, QQueryOperations>
      errorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errors');
    });
  }

  QueryBuilder<ImportBatchModel, int, QQueryOperations> failedRowsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'failedRows');
    });
  }

  QueryBuilder<ImportBatchModel, String, QQueryOperations> fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }

  QueryBuilder<ImportBatchModel, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ImportBatchModel, DateTime, QQueryOperations>
      importDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importDate');
    });
  }

  QueryBuilder<ImportBatchModel, int, QQueryOperations> importedRowsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importedRows');
    });
  }

  QueryBuilder<ImportBatchModel, int, QQueryOperations> skippedRowsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skippedRows');
    });
  }

  QueryBuilder<ImportBatchModel, ImportStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<ImportBatchModel, int, QQueryOperations> totalRowsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRows');
    });
  }
}
