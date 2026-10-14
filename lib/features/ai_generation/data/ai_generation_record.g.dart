// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_generation_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetAiGenerationRecordCollection on Isar {
  IsarCollection<AiGenerationRecord> get aiGenerationRecords =>
      this.collection();
}

const AiGenerationRecordSchema = CollectionSchema(
  name: r'AiGenerationRecord',
  id: -5055682050847086717,
  properties: {
    r'generatedAt': PropertySchema(
      id: 0,
      name: r'generatedAt',
      type: IsarType.dateTime,
    ),
    r'generationId': PropertySchema(
      id: 1,
      name: r'generationId',
      type: IsarType.string,
    ),
    r'notebookId': PropertySchema(
      id: 2,
      name: r'notebookId',
      type: IsarType.string,
    ),
    r'profileId': PropertySchema(
      id: 3,
      name: r'profileId',
      type: IsarType.string,
    ),
    r'profileLabel': PropertySchema(
      id: 4,
      name: r'profileLabel',
      type: IsarType.string,
    ),
    r'promptVersion': PropertySchema(
      id: 5,
      name: r'promptVersion',
      type: IsarType.string,
    ),
    r'provider': PropertySchema(
      id: 6,
      name: r'provider',
      type: IsarType.string,
    ),
    r'status': PropertySchema(id: 7, name: r'status', type: IsarType.string),
  },

  estimateSize: _aiGenerationRecordEstimateSize,
  serialize: _aiGenerationRecordSerialize,
  deserialize: _aiGenerationRecordDeserialize,
  deserializeProp: _aiGenerationRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'generationId': IndexSchema(
      id: 1503012540019586226,
      name: r'generationId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'generationId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _aiGenerationRecordGetId,
  getLinks: _aiGenerationRecordGetLinks,
  attach: _aiGenerationRecordAttach,
  version: '3.4.1',
);

int _aiGenerationRecordEstimateSize(
  AiGenerationRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.generationId.length * 3;
  {
    final value = object.notebookId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.profileId.length * 3;
  bytesCount += 3 + object.profileLabel.length * 3;
  bytesCount += 3 + object.promptVersion.length * 3;
  bytesCount += 3 + object.provider.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _aiGenerationRecordSerialize(
  AiGenerationRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.generatedAt);
  writer.writeString(offsets[1], object.generationId);
  writer.writeString(offsets[2], object.notebookId);
  writer.writeString(offsets[3], object.profileId);
  writer.writeString(offsets[4], object.profileLabel);
  writer.writeString(offsets[5], object.promptVersion);
  writer.writeString(offsets[6], object.provider);
  writer.writeString(offsets[7], object.status);
}

AiGenerationRecord _aiGenerationRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AiGenerationRecord();
  object.generatedAt = reader.readDateTime(offsets[0]);
  object.generationId = reader.readString(offsets[1]);
  object.id = id;
  object.notebookId = reader.readStringOrNull(offsets[2]);
  object.profileId = reader.readString(offsets[3]);
  object.profileLabel = reader.readString(offsets[4]);
  object.promptVersion = reader.readString(offsets[5]);
  object.provider = reader.readString(offsets[6]);
  object.status = reader.readString(offsets[7]);
  return object;
}

P _aiGenerationRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _aiGenerationRecordGetId(AiGenerationRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aiGenerationRecordGetLinks(
  AiGenerationRecord object,
) {
  return [];
}

void _aiGenerationRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  AiGenerationRecord object,
) {
  object.id = id;
}

extension AiGenerationRecordByIndex on IsarCollection<AiGenerationRecord> {
  Future<AiGenerationRecord?> getByGenerationId(String generationId) {
    return getByIndex(r'generationId', [generationId]);
  }

  AiGenerationRecord? getByGenerationIdSync(String generationId) {
    return getByIndexSync(r'generationId', [generationId]);
  }

  Future<bool> deleteByGenerationId(String generationId) {
    return deleteByIndex(r'generationId', [generationId]);
  }

  bool deleteByGenerationIdSync(String generationId) {
    return deleteByIndexSync(r'generationId', [generationId]);
  }

  Future<List<AiGenerationRecord?>> getAllByGenerationId(
    List<String> generationIdValues,
  ) {
    final values = generationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'generationId', values);
  }

  List<AiGenerationRecord?> getAllByGenerationIdSync(
    List<String> generationIdValues,
  ) {
    final values = generationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'generationId', values);
  }

  Future<int> deleteAllByGenerationId(List<String> generationIdValues) {
    final values = generationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'generationId', values);
  }

  int deleteAllByGenerationIdSync(List<String> generationIdValues) {
    final values = generationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'generationId', values);
  }

  Future<Id> putByGenerationId(AiGenerationRecord object) {
    return putByIndex(r'generationId', object);
  }

  Id putByGenerationIdSync(AiGenerationRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'generationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGenerationId(List<AiGenerationRecord> objects) {
    return putAllByIndex(r'generationId', objects);
  }

  List<Id> putAllByGenerationIdSync(
    List<AiGenerationRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'generationId', objects, saveLinks: saveLinks);
  }
}

extension AiGenerationRecordQueryWhereSort
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QWhere> {
  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AiGenerationRecordQueryWhere
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QWhereClause> {
  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
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

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
  generationIdEqualTo(String generationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'generationId',
          value: [generationId],
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterWhereClause>
  generationIdNotEqualTo(String generationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'generationId',
                lower: [],
                upper: [generationId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'generationId',
                lower: [generationId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'generationId',
                lower: [generationId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'generationId',
                lower: [],
                upper: [generationId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension AiGenerationRecordQueryFilter
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QFilterCondition> {
  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'generatedAt', value: value),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'generatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'generatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'generatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'generationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'generationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'generationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'generationId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'generationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'generationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'generationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'generationId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'generationId', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  generationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'generationId', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notebookId'),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notebookId'),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notebookId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notebookId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notebookId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notebookId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notebookId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notebookId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notebookId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notebookId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notebookId', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  notebookIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notebookId', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'profileId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'profileId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'profileId', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'profileId', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'profileLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'profileLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'profileLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'profileLabel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'profileLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'profileLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'profileLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'profileLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'profileLabel', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  profileLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'profileLabel', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'promptVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'promptVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'promptVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'promptVersion',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'promptVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'promptVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'promptVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'promptVersion',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'promptVersion', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  promptVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'promptVersion', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'provider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'provider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'provider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'provider',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'provider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'provider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'provider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'provider',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'provider', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  providerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'provider', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension AiGenerationRecordQueryObject
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QFilterCondition> {}

extension AiGenerationRecordQueryLinks
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QFilterCondition> {}

extension AiGenerationRecordQuerySortBy
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QSortBy> {
  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByGenerationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generationId', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByGenerationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generationId', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByNotebookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notebookId', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByNotebookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notebookId', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByProfileLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileLabel', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByProfileLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileLabel', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByPromptVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'promptVersion', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByPromptVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'promptVersion', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension AiGenerationRecordQuerySortThenBy
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QSortThenBy> {
  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByGenerationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generationId', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByGenerationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generationId', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByNotebookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notebookId', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByNotebookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notebookId', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByProfileLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileLabel', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByProfileLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileLabel', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByPromptVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'promptVersion', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByPromptVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'promptVersion', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.desc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension AiGenerationRecordQueryWhereDistinct
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct> {
  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generatedAt');
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByGenerationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByNotebookId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notebookId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByProfileId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByProfileLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileLabel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByPromptVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'promptVersion',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByProvider({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'provider', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiGenerationRecord, AiGenerationRecord, QDistinct>
  distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension AiGenerationRecordQueryProperty
    on QueryBuilder<AiGenerationRecord, AiGenerationRecord, QQueryProperty> {
  QueryBuilder<AiGenerationRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AiGenerationRecord, DateTime, QQueryOperations>
  generatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generatedAt');
    });
  }

  QueryBuilder<AiGenerationRecord, String, QQueryOperations>
  generationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generationId');
    });
  }

  QueryBuilder<AiGenerationRecord, String?, QQueryOperations>
  notebookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notebookId');
    });
  }

  QueryBuilder<AiGenerationRecord, String, QQueryOperations>
  profileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileId');
    });
  }

  QueryBuilder<AiGenerationRecord, String, QQueryOperations>
  profileLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileLabel');
    });
  }

  QueryBuilder<AiGenerationRecord, String, QQueryOperations>
  promptVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'promptVersion');
    });
  }

  QueryBuilder<AiGenerationRecord, String, QQueryOperations>
  providerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'provider');
    });
  }

  QueryBuilder<AiGenerationRecord, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
