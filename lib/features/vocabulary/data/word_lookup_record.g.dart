// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lookup_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetWordLookupRecordCollection on Isar {
  IsarCollection<WordLookupRecord> get wordLookupRecords => this.collection();
}

const WordLookupRecordSchema = CollectionSchema(
  name: r'WordLookupRecord',
  id: 4279403810978433186,
  properties: {
    r'fetchedAt': PropertySchema(
      id: 0,
      name: r'fetchedAt',
      type: IsarType.dateTime,
    ),
    r'normalizedWord': PropertySchema(
      id: 1,
      name: r'normalizedWord',
      type: IsarType.string,
    ),
    r'translation': PropertySchema(
      id: 2,
      name: r'translation',
      type: IsarType.string,
    ),
    r'translationSource': PropertySchema(
      id: 3,
      name: r'translationSource',
      type: IsarType.string,
    ),
    r'word': PropertySchema(id: 4, name: r'word', type: IsarType.string),
  },

  estimateSize: _wordLookupRecordEstimateSize,
  serialize: _wordLookupRecordSerialize,
  deserialize: _wordLookupRecordDeserialize,
  deserializeProp: _wordLookupRecordDeserializeProp,
  idName: r'id',
  indexes: {
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

  getId: _wordLookupRecordGetId,
  getLinks: _wordLookupRecordGetLinks,
  attach: _wordLookupRecordAttach,
  version: '3.4.1',
);

int _wordLookupRecordEstimateSize(
  WordLookupRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.normalizedWord.length * 3;
  bytesCount += 3 + object.translation.length * 3;
  bytesCount += 3 + object.translationSource.length * 3;
  bytesCount += 3 + object.word.length * 3;
  return bytesCount;
}

void _wordLookupRecordSerialize(
  WordLookupRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fetchedAt);
  writer.writeString(offsets[1], object.normalizedWord);
  writer.writeString(offsets[2], object.translation);
  writer.writeString(offsets[3], object.translationSource);
  writer.writeString(offsets[4], object.word);
}

WordLookupRecord _wordLookupRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WordLookupRecord();
  object.fetchedAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.normalizedWord = reader.readString(offsets[1]);
  object.translation = reader.readString(offsets[2]);
  object.translationSource = reader.readString(offsets[3]);
  object.word = reader.readString(offsets[4]);
  return object;
}

P _wordLookupRecordDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _wordLookupRecordGetId(WordLookupRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _wordLookupRecordGetLinks(WordLookupRecord object) {
  return [];
}

void _wordLookupRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  WordLookupRecord object,
) {
  object.id = id;
}

extension WordLookupRecordByIndex on IsarCollection<WordLookupRecord> {
  Future<WordLookupRecord?> getByNormalizedWord(String normalizedWord) {
    return getByIndex(r'normalizedWord', [normalizedWord]);
  }

  WordLookupRecord? getByNormalizedWordSync(String normalizedWord) {
    return getByIndexSync(r'normalizedWord', [normalizedWord]);
  }

  Future<bool> deleteByNormalizedWord(String normalizedWord) {
    return deleteByIndex(r'normalizedWord', [normalizedWord]);
  }

  bool deleteByNormalizedWordSync(String normalizedWord) {
    return deleteByIndexSync(r'normalizedWord', [normalizedWord]);
  }

  Future<List<WordLookupRecord?>> getAllByNormalizedWord(
    List<String> normalizedWordValues,
  ) {
    final values = normalizedWordValues.map((e) => [e]).toList();
    return getAllByIndex(r'normalizedWord', values);
  }

  List<WordLookupRecord?> getAllByNormalizedWordSync(
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

  Future<Id> putByNormalizedWord(WordLookupRecord object) {
    return putByIndex(r'normalizedWord', object);
  }

  Id putByNormalizedWordSync(WordLookupRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'normalizedWord', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNormalizedWord(List<WordLookupRecord> objects) {
    return putAllByIndex(r'normalizedWord', objects);
  }

  List<Id> putAllByNormalizedWordSync(
    List<WordLookupRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'normalizedWord', objects, saveLinks: saveLinks);
  }
}

extension WordLookupRecordQueryWhereSort
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QWhere> {
  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WordLookupRecordQueryWhere
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QWhereClause> {
  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterWhereClause>
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

extension WordLookupRecordQueryFilter
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QFilterCondition> {
  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  fetchedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fetchedAt', value: value),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  fetchedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fetchedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  fetchedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fetchedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  fetchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fetchedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  normalizedWordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'normalizedWord', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  normalizedWordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'normalizedWord', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'translation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'translation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'translation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'translation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'translation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'translation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'translation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'translation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'translation', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'translation', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'translationSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'translationSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'translationSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'translationSource',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'translationSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'translationSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'translationSource',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'translationSource',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'translationSource', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  translationSourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'translationSource', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
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

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  wordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'word', value: ''),
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterFilterCondition>
  wordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'word', value: ''),
      );
    });
  }
}

extension WordLookupRecordQueryObject
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QFilterCondition> {}

extension WordLookupRecordQueryLinks
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QFilterCondition> {}

extension WordLookupRecordQuerySortBy
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QSortBy> {
  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByFetchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByFetchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByNormalizedWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByNormalizedWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translation', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translation', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByTranslationSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationSource', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByTranslationSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationSource', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy> sortByWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  sortByWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.desc);
    });
  }
}

extension WordLookupRecordQuerySortThenBy
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QSortThenBy> {
  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByFetchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByFetchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByNormalizedWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByNormalizedWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedWord', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translation', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translation', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByTranslationSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationSource', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByTranslationSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationSource', Sort.desc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy> thenByWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.asc);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QAfterSortBy>
  thenByWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.desc);
    });
  }
}

extension WordLookupRecordQueryWhereDistinct
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QDistinct> {
  QueryBuilder<WordLookupRecord, WordLookupRecord, QDistinct>
  distinctByFetchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fetchedAt');
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QDistinct>
  distinctByNormalizedWord({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'normalizedWord',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QDistinct>
  distinctByTranslation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'translation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QDistinct>
  distinctByTranslationSource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'translationSource',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<WordLookupRecord, WordLookupRecord, QDistinct> distinctByWord({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'word', caseSensitive: caseSensitive);
    });
  }
}

extension WordLookupRecordQueryProperty
    on QueryBuilder<WordLookupRecord, WordLookupRecord, QQueryProperty> {
  QueryBuilder<WordLookupRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WordLookupRecord, DateTime, QQueryOperations>
  fetchedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fetchedAt');
    });
  }

  QueryBuilder<WordLookupRecord, String, QQueryOperations>
  normalizedWordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'normalizedWord');
    });
  }

  QueryBuilder<WordLookupRecord, String, QQueryOperations>
  translationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translation');
    });
  }

  QueryBuilder<WordLookupRecord, String, QQueryOperations>
  translationSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translationSource');
    });
  }

  QueryBuilder<WordLookupRecord, String, QQueryOperations> wordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'word');
    });
  }
}
