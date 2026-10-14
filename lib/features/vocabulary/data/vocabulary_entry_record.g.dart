// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_entry_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetVocabularyEntryRecordCollection on Isar {
  IsarCollection<VocabularyEntryRecord> get vocabularyEntryRecords =>
      this.collection();
}

const VocabularyEntryRecordSchema = CollectionSchema(
  name: r'VocabularyEntryRecord',
  id: 4831196267557630155,
  properties: {
    r'meaning': PropertySchema(id: 0, name: r'meaning', type: IsarType.string),
    r'meaningSource': PropertySchema(
      id: 1,
      name: r'meaningSource',
      type: IsarType.string,
    ),
    r'normalizedWord': PropertySchema(
      id: 2,
      name: r'normalizedWord',
      type: IsarType.string,
    ),
    r'savedAt': PropertySchema(
      id: 3,
      name: r'savedAt',
      type: IsarType.dateTime,
    ),
    r'sourceTextIds': PropertySchema(
      id: 4,
      name: r'sourceTextIds',
      type: IsarType.stringList,
    ),
    r'status': PropertySchema(id: 5, name: r'status', type: IsarType.string),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(id: 7, name: r'uuid', type: IsarType.string),
    r'word': PropertySchema(id: 8, name: r'word', type: IsarType.string),
  },

  estimateSize: _vocabularyEntryRecordEstimateSize,
  serialize: _vocabularyEntryRecordSerialize,
  deserialize: _vocabularyEntryRecordDeserialize,
  deserializeProp: _vocabularyEntryRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'normalizedWord': IndexSchema(
      id: -7425437128200080956,
      name: r'normalizedWord',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'normalizedWord',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _vocabularyEntryRecordGetId,
  getLinks: _vocabularyEntryRecordGetLinks,
  attach: _vocabularyEntryRecordAttach,
  version: '3.4.1',
);

int _vocabularyEntryRecordEstimateSize(
  VocabularyEntryRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.meaning.length * 3;
  {
    final value = object.meaningSource;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.normalizedWord.length * 3;
  bytesCount += 3 + object.sourceTextIds.length * 3;
  {
    for (var i = 0; i < object.sourceTextIds.length; i++) {
      final value = object.sourceTextIds[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  bytesCount += 3 + object.word.length * 3;
  return bytesCount;
}

void _vocabularyEntryRecordSerialize(
  VocabularyEntryRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.meaning);
  writer.writeString(offsets[1], object.meaningSource);
  writer.writeString(offsets[2], object.normalizedWord);
  writer.writeDateTime(offsets[3], object.savedAt);
  writer.writeStringList(offsets[4], object.sourceTextIds);
  writer.writeString(offsets[5], object.status);
  writer.writeDateTime(offsets[6], object.updatedAt);
  writer.writeString(offsets[7], object.uuid);
  writer.writeString(offsets[8], object.word);
}

VocabularyEntryRecord _vocabularyEntryRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VocabularyEntryRecord();
  object.id = id;
  object.meaning = reader.readString(offsets[0]);
  object.meaningSource = reader.readStringOrNull(offsets[1]);
  object.normalizedWord = reader.readString(offsets[2]);
  object.savedAt = reader.readDateTime(offsets[3]);
  object.sourceTextIds = reader.readStringList(offsets[4]) ?? [];
  object.status = reader.readString(offsets[5]);
  object.updatedAt = reader.readDateTime(offsets[6]);
  object.uuid = reader.readString(offsets[7]);
  object.word = reader.readString(offsets[8]);
  return object;
}

P _vocabularyEntryRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vocabularyEntryRecordGetId(VocabularyEntryRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vocabularyEntryRecordGetLinks(
  VocabularyEntryRecord object,
) {
  return [];
}

void _vocabularyEntryRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  VocabularyEntryRecord object,
) {
  object.id = id;
}

extension VocabularyEntryRecordByIndex
    on IsarCollection<VocabularyEntryRecord> {
  Future<VocabularyEntryRecord?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  VocabularyEntryRecord? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<VocabularyEntryRecord?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<VocabularyEntryRecord?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(VocabularyEntryRecord object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(VocabularyEntryRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<VocabularyEntryRecord> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(
    List<VocabularyEntryRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }

  Future<VocabularyEntryRecord?> getByNormalizedWord(String normalizedWord) {
    return getByIndex(r'normalizedWord', [normalizedWord]);
  }

  VocabularyEntryRecord? getByNormalizedWordSync(String normalizedWord) {
    return getByIndexSync(r'normalizedWord', [normalizedWord]);
  }

  Future<bool> deleteByNormalizedWord(String normalizedWord) {
    return deleteByIndex(r'normalizedWord', [normalizedWord]);
  }

  bool deleteByNormalizedWordSync(String normalizedWord) {
    return deleteByIndexSync(r'normalizedWord', [normalizedWord]);
  }

  Future<List<VocabularyEntryRecord?>> getAllByNormalizedWord(
    List<String> normalizedWordValues,
  ) {
    final values = normalizedWordValues.map((e) => [e]).toList();
    return getAllByIndex(r'normalizedWord', values);
  }

  List<VocabularyEntryRecord?> getAllByNormalizedWordSync(
    List<String> normalizedWordValues,
  ) {
    final values = normalizedWordValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'normalizedWord', values);
  }

  Future<int> deleteAllByNormalizedWord(List<String> normalizedWordValues) {
    final values = normalizedWordValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'normalizedWord', values);
  }

  int deleteAllByNormalizedWordSync(List<String> normalizedWordValues) {
    final values = normalizedWordValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'normalizedWord', values);
  }

  Future<Id> putByNormalizedWord(VocabularyEntryRecord object) {
    return putByIndex(r'normalizedWord', object);
  }

  Id putByNormalizedWordSync(
    VocabularyEntryRecord object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'normalizedWord', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNormalizedWord(List<VocabularyEntryRecord> objects) {
    return putAllByIndex(r'normalizedWord', objects);
  }

  List<Id> putAllByNormalizedWordSync(
    List<VocabularyEntryRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'normalizedWord', objects, saveLinks: saveLinks);
  }
}

extension VocabularyEntryRecordQueryWhereSort
    on QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QWhere> {
  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VocabularyEntryRecordQueryWhere
    on
        QueryBuilder<
          VocabularyEntryRecord,
          VocabularyEntryRecord,
          QWhereClause
        > {
  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
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

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
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

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuid', value: [uuid]),
      );
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [],
                upper: [uuid],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [uuid],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [uuid],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [],
                upper: [uuid],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  normalizedWordEqualTo(String normalizedWord) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'normalizedWord',
          value: [normalizedWord],
        ),
      );
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterWhereClause>
  normalizedWordNotEqualTo(String normalizedWord) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'normalizedWord',
                lower: [],
                upper: [normalizedWord],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'normalizedWord',
                lower: [normalizedWord],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'normalizedWord',
                lower: [normalizedWord],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'normalizedWord',
                lower: [],
                upper: [normalizedWord],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension VocabularyEntryRecordQueryFilter
    on
        QueryBuilder<
          VocabularyEntryRecord,
          VocabularyEntryRecord,
          QFilterCondition
        > {
  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'meaning',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'meaning',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'meaning',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'meaning',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'meaning',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'meaning',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'meaning',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'meaning',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'meaning', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'meaning', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'meaningSource'),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'meaningSource'),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'meaningSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'meaningSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'meaningSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'meaningSource',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'meaningSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'meaningSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'meaningSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'meaningSource',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'meaningSource', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  meaningSourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'meaningSource', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'normalizedWord',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'normalizedWord',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'normalizedWord',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'normalizedWord',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'normalizedWord',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'normalizedWord',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'normalizedWord',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'normalizedWord',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'normalizedWord', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  normalizedWordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'normalizedWord', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  savedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'savedAt', value: value),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  savedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'savedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  savedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'savedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  savedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'savedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceTextIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceTextIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceTextIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceTextIds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceTextIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceTextIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceTextIds',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceTextIds',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceTextIds', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceTextIds', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sourceTextIds', length, true, length, true);
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sourceTextIds', 0, true, 0, true);
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sourceTextIds', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sourceTextIds', 0, true, length, include);
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sourceTextIds', length, include, 999999, true);
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  sourceTextIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceTextIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uuid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uuid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'word',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'word',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'word',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'word',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'word',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'word',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'word',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'word',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'word', value: ''),
      );
    });
  }

  QueryBuilder<
    VocabularyEntryRecord,
    VocabularyEntryRecord,
    QAfterFilterCondition
  >
  wordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'word', value: ''),
      );
    });
  }
}

extension VocabularyEntryRecordQueryObject
    on
        QueryBuilder<
          VocabularyEntryRecord,
          VocabularyEntryRecord,
          QFilterCondition
        > {}

extension VocabularyEntryRecordQueryLinks
    on
        QueryBuilder<
          VocabularyEntryRecord,
          VocabularyEntryRecord,
          QFilterCondition
        > {}

extension VocabularyEntryRecordQuerySortBy
    on QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QSortBy> {
  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByMeaningSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningSource', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByMeaningSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningSource', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByNormalizedWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByNormalizedWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortBySavedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  sortByWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.desc);
    });
  }
}

extension VocabularyEntryRecordQuerySortThenBy
    on QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QSortThenBy> {
  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByMeaningSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningSource', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByMeaningSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningSource', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByNormalizedWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByNormalizedWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenBySavedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.asc);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QAfterSortBy>
  thenByWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.desc);
    });
  }
}

extension VocabularyEntryRecordQueryWhereDistinct
    on QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct> {
  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByMeaning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meaning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByMeaningSource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'meaningSource',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByNormalizedWord({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'normalizedWord',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savedAt');
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctBySourceTextIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceTextIds');
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VocabularyEntryRecord, VocabularyEntryRecord, QDistinct>
  distinctByWord({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'word', caseSensitive: caseSensitive);
    });
  }
}

extension VocabularyEntryRecordQueryProperty
    on
        QueryBuilder<
          VocabularyEntryRecord,
          VocabularyEntryRecord,
          QQueryProperty
        > {
  QueryBuilder<VocabularyEntryRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VocabularyEntryRecord, String, QQueryOperations>
  meaningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaning');
    });
  }

  QueryBuilder<VocabularyEntryRecord, String?, QQueryOperations>
  meaningSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaningSource');
    });
  }

  QueryBuilder<VocabularyEntryRecord, String, QQueryOperations>
  normalizedWordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'normalizedWord');
    });
  }

  QueryBuilder<VocabularyEntryRecord, DateTime, QQueryOperations>
  savedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savedAt');
    });
  }

  QueryBuilder<VocabularyEntryRecord, List<String>, QQueryOperations>
  sourceTextIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceTextIds');
    });
  }

  QueryBuilder<VocabularyEntryRecord, String, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<VocabularyEntryRecord, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<VocabularyEntryRecord, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<VocabularyEntryRecord, String, QQueryOperations> wordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'word');
    });
  }
}
