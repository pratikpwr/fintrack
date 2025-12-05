// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_payment_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonthlyPaymentModelCollection on Isar {
  IsarCollection<MonthlyPaymentModel> get monthlyPaymentModels =>
      this.collection();
}

const MonthlyPaymentModelSchema = CollectionSchema(
  name: r'MonthlyPaymentModel',
  id: 1521050565361272266,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'autoDebit': PropertySchema(
      id: 1,
      name: r'autoDebit',
      type: IsarType.bool,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
      enumMap: _MonthlyPaymentModelcategoryEnumValueMap,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 4,
      name: r'description',
      type: IsarType.string,
    ),
    r'dueDay': PropertySchema(
      id: 5,
      name: r'dueDay',
      type: IsarType.long,
    ),
    r'frequency': PropertySchema(
      id: 6,
      name: r'frequency',
      type: IsarType.string,
      enumMap: _MonthlyPaymentModelfrequencyEnumValueMap,
    ),
    r'isActive': PropertySchema(
      id: 7,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'lastPaidDate': PropertySchema(
      id: 8,
      name: r'lastPaidDate',
      type: IsarType.dateTime,
    ),
    r'linkedAccountId': PropertySchema(
      id: 9,
      name: r'linkedAccountId',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'nextDueDate': PropertySchema(
      id: 11,
      name: r'nextDueDate',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _monthlyPaymentModelEstimateSize,
  serialize: _monthlyPaymentModelSerialize,
  deserialize: _monthlyPaymentModelDeserialize,
  deserializeProp: _monthlyPaymentModelDeserializeProp,
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
    r'isActive': IndexSchema(
      id: 8092228061260947457,
      name: r'isActive',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isActive',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'nextDueDate': IndexSchema(
      id: -1749684646791026574,
      name: r'nextDueDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nextDueDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _monthlyPaymentModelGetId,
  getLinks: _monthlyPaymentModelGetLinks,
  attach: _monthlyPaymentModelAttach,
  version: '3.1.0+1',
);

int _monthlyPaymentModelEstimateSize(
  MonthlyPaymentModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.name.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.frequency.name.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _monthlyPaymentModelSerialize(
  MonthlyPaymentModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeBool(offsets[1], object.autoDebit);
  writer.writeString(offsets[2], object.category.name);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.description);
  writer.writeLong(offsets[5], object.dueDay);
  writer.writeString(offsets[6], object.frequency.name);
  writer.writeBool(offsets[7], object.isActive);
  writer.writeDateTime(offsets[8], object.lastPaidDate);
  writer.writeLong(offsets[9], object.linkedAccountId);
  writer.writeString(offsets[10], object.name);
  writer.writeDateTime(offsets[11], object.nextDueDate);
  writer.writeDateTime(offsets[12], object.updatedAt);
}

MonthlyPaymentModel _monthlyPaymentModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthlyPaymentModel();
  object.amount = reader.readDouble(offsets[0]);
  object.autoDebit = reader.readBool(offsets[1]);
  object.category = _MonthlyPaymentModelcategoryValueEnumMap[
          reader.readStringOrNull(offsets[2])] ??
      PaymentCategory.subscription;
  object.createdAt = reader.readDateTime(offsets[3]);
  object.description = reader.readStringOrNull(offsets[4]);
  object.dueDay = reader.readLong(offsets[5]);
  object.frequency = _MonthlyPaymentModelfrequencyValueEnumMap[
          reader.readStringOrNull(offsets[6])] ??
      PaymentFrequency.monthly;
  object.id = id;
  object.isActive = reader.readBool(offsets[7]);
  object.lastPaidDate = reader.readDateTimeOrNull(offsets[8]);
  object.linkedAccountId = reader.readLongOrNull(offsets[9]);
  object.name = reader.readString(offsets[10]);
  object.nextDueDate = reader.readDateTimeOrNull(offsets[11]);
  object.updatedAt = reader.readDateTime(offsets[12]);
  return object;
}

P _monthlyPaymentModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (_MonthlyPaymentModelcategoryValueEnumMap[
              reader.readStringOrNull(offset)] ??
          PaymentCategory.subscription) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (_MonthlyPaymentModelfrequencyValueEnumMap[
              reader.readStringOrNull(offset)] ??
          PaymentFrequency.monthly) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MonthlyPaymentModelcategoryEnumValueMap = {
  r'subscription': r'subscription',
  r'utility': r'utility',
  r'insurance': r'insurance',
  r'loan': r'loan',
  r'rent': r'rent',
  r'education': r'education',
  r'other': r'other',
};
const _MonthlyPaymentModelcategoryValueEnumMap = {
  r'subscription': PaymentCategory.subscription,
  r'utility': PaymentCategory.utility,
  r'insurance': PaymentCategory.insurance,
  r'loan': PaymentCategory.loan,
  r'rent': PaymentCategory.rent,
  r'education': PaymentCategory.education,
  r'other': PaymentCategory.other,
};
const _MonthlyPaymentModelfrequencyEnumValueMap = {
  r'monthly': r'monthly',
  r'quarterly': r'quarterly',
  r'halfYearly': r'halfYearly',
  r'yearly': r'yearly',
};
const _MonthlyPaymentModelfrequencyValueEnumMap = {
  r'monthly': PaymentFrequency.monthly,
  r'quarterly': PaymentFrequency.quarterly,
  r'halfYearly': PaymentFrequency.halfYearly,
  r'yearly': PaymentFrequency.yearly,
};

Id _monthlyPaymentModelGetId(MonthlyPaymentModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monthlyPaymentModelGetLinks(
    MonthlyPaymentModel object) {
  return [];
}

void _monthlyPaymentModelAttach(
    IsarCollection<dynamic> col, Id id, MonthlyPaymentModel object) {
  object.id = id;
}

extension MonthlyPaymentModelQueryWhereSort
    on QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QWhere> {
  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhere>
      anyIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isActive'),
      );
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhere>
      anyNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'nextDueDate'),
      );
    });
  }
}

extension MonthlyPaymentModelQueryWhere
    on QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QWhereClause> {
  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      isActiveEqualTo(bool isActive) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isActive',
        value: [isActive],
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      isActiveNotEqualTo(bool isActive) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nextDueDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextDueDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateEqualTo(DateTime? nextDueDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nextDueDate',
        value: [nextDueDate],
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateNotEqualTo(DateTime? nextDueDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextDueDate',
              lower: [],
              upper: [nextDueDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextDueDate',
              lower: [nextDueDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextDueDate',
              lower: [nextDueDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextDueDate',
              lower: [],
              upper: [nextDueDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateGreaterThan(
    DateTime? nextDueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextDueDate',
        lower: [nextDueDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateLessThan(
    DateTime? nextDueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextDueDate',
        lower: [],
        upper: [nextDueDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterWhereClause>
      nextDueDateBetween(
    DateTime? lowerNextDueDate,
    DateTime? upperNextDueDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextDueDate',
        lower: [lowerNextDueDate],
        includeLower: includeLower,
        upper: [upperNextDueDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MonthlyPaymentModelQueryFilter on QueryBuilder<MonthlyPaymentModel,
    MonthlyPaymentModel, QFilterCondition> {
  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      autoDebitEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoDebit',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryEqualTo(
    PaymentCategory value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryGreaterThan(
    PaymentCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryLessThan(
    PaymentCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryBetween(
    PaymentCategory lower,
    PaymentCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      dueDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      dueDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      dueDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      dueDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyEqualTo(
    PaymentFrequency value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyGreaterThan(
    PaymentFrequency value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyLessThan(
    PaymentFrequency value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyBetween(
    PaymentFrequency lower,
    PaymentFrequency upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frequency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      frequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      lastPaidDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPaidDate',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      lastPaidDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPaidDate',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      lastPaidDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPaidDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      lastPaidDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPaidDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      lastPaidDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPaidDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      lastPaidDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPaidDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      linkedAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      linkedAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      linkedAccountIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      linkedAccountIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      linkedAccountIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      linkedAccountIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nextDueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextDueDate',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nextDueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextDueDate',
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nextDueDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nextDueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nextDueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      nextDueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterFilterCondition>
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

extension MonthlyPaymentModelQueryObject on QueryBuilder<MonthlyPaymentModel,
    MonthlyPaymentModel, QFilterCondition> {}

extension MonthlyPaymentModelQueryLinks on QueryBuilder<MonthlyPaymentModel,
    MonthlyPaymentModel, QFilterCondition> {}

extension MonthlyPaymentModelQuerySortBy
    on QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QSortBy> {
  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByAutoDebit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDebit', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByAutoDebitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDebit', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByDueDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByDueDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByLastPaidDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaidDate', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByLastPaidDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaidDate', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByNextDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MonthlyPaymentModelQuerySortThenBy
    on QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QSortThenBy> {
  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByAutoDebit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDebit', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByAutoDebitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDebit', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByDueDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByDueDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByLastPaidDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaidDate', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByLastPaidDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaidDate', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByNextDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.desc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MonthlyPaymentModelQueryWhereDistinct
    on QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct> {
  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByAutoDebit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoDebit');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByDueDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDay');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByFrequency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByLastPaidDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPaidDate');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedAccountId');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDueDate');
    });
  }

  QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension MonthlyPaymentModelQueryProperty
    on QueryBuilder<MonthlyPaymentModel, MonthlyPaymentModel, QQueryProperty> {
  QueryBuilder<MonthlyPaymentModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonthlyPaymentModel, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<MonthlyPaymentModel, bool, QQueryOperations>
      autoDebitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoDebit');
    });
  }

  QueryBuilder<MonthlyPaymentModel, PaymentCategory, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<MonthlyPaymentModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MonthlyPaymentModel, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<MonthlyPaymentModel, int, QQueryOperations> dueDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDay');
    });
  }

  QueryBuilder<MonthlyPaymentModel, PaymentFrequency, QQueryOperations>
      frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<MonthlyPaymentModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<MonthlyPaymentModel, DateTime?, QQueryOperations>
      lastPaidDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPaidDate');
    });
  }

  QueryBuilder<MonthlyPaymentModel, int?, QQueryOperations>
      linkedAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedAccountId');
    });
  }

  QueryBuilder<MonthlyPaymentModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MonthlyPaymentModel, DateTime?, QQueryOperations>
      nextDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDueDate');
    });
  }

  QueryBuilder<MonthlyPaymentModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
