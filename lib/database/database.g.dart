// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WhitelistEntitiesTable extends WhitelistEntities
    with TableInfo<$WhitelistEntitiesTable, WhitelistEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WhitelistEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _annotationMeta =
      const VerificationMeta('annotation');
  @override
  late final GeneratedColumn<String> annotation = GeneratedColumn<String>(
      'annotation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _readOnlyMeta =
      const VerificationMeta('readOnly');
  @override
  late final GeneratedColumn<bool> readOnly = GeneratedColumn<bool>(
      'read_only', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("read_only" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, path, type, annotation, readOnly, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'whitelist_entities';
  @override
  VerificationContext validateIntegrity(Insertable<WhitelistEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('annotation')) {
      context.handle(
          _annotationMeta,
          annotation.isAcceptableOrUnknown(
              data['annotation']!, _annotationMeta));
    }
    if (data.containsKey('read_only')) {
      context.handle(_readOnlyMeta,
          readOnly.isAcceptableOrUnknown(data['read_only']!, _readOnlyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WhitelistEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WhitelistEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      annotation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}annotation'])!,
      readOnly: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}read_only'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WhitelistEntitiesTable createAlias(String alias) {
    return $WhitelistEntitiesTable(attachedDatabase, alias);
  }
}

class WhitelistEntity extends DataClass implements Insertable<WhitelistEntity> {
  final int id;
  final String path;
  final int type;
  final String annotation;
  final bool readOnly;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WhitelistEntity(
      {required this.id,
      required this.path,
      required this.type,
      required this.annotation,
      required this.readOnly,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    map['type'] = Variable<int>(type);
    map['annotation'] = Variable<String>(annotation);
    map['read_only'] = Variable<bool>(readOnly);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WhitelistEntitiesCompanion toCompanion(bool nullToAbsent) {
    return WhitelistEntitiesCompanion(
      id: Value(id),
      path: Value(path),
      type: Value(type),
      annotation: Value(annotation),
      readOnly: Value(readOnly),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WhitelistEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WhitelistEntity(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      type: serializer.fromJson<int>(json['type']),
      annotation: serializer.fromJson<String>(json['annotation']),
      readOnly: serializer.fromJson<bool>(json['readOnly']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'type': serializer.toJson<int>(type),
      'annotation': serializer.toJson<String>(annotation),
      'readOnly': serializer.toJson<bool>(readOnly),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WhitelistEntity copyWith(
          {int? id,
          String? path,
          int? type,
          String? annotation,
          bool? readOnly,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WhitelistEntity(
        id: id ?? this.id,
        path: path ?? this.path,
        type: type ?? this.type,
        annotation: annotation ?? this.annotation,
        readOnly: readOnly ?? this.readOnly,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WhitelistEntity copyWithCompanion(WhitelistEntitiesCompanion data) {
    return WhitelistEntity(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      type: data.type.present ? data.type.value : this.type,
      annotation:
          data.annotation.present ? data.annotation.value : this.annotation,
      readOnly: data.readOnly.present ? data.readOnly.value : this.readOnly,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WhitelistEntity(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('type: $type, ')
          ..write('annotation: $annotation, ')
          ..write('readOnly: $readOnly, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, path, type, annotation, readOnly, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WhitelistEntity &&
          other.id == this.id &&
          other.path == this.path &&
          other.type == this.type &&
          other.annotation == this.annotation &&
          other.readOnly == this.readOnly &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WhitelistEntitiesCompanion extends UpdateCompanion<WhitelistEntity> {
  final Value<int> id;
  final Value<String> path;
  final Value<int> type;
  final Value<String> annotation;
  final Value<bool> readOnly;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WhitelistEntitiesCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.type = const Value.absent(),
    this.annotation = const Value.absent(),
    this.readOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WhitelistEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    this.type = const Value.absent(),
    this.annotation = const Value.absent(),
    this.readOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : path = Value(path);
  static Insertable<WhitelistEntity> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<int>? type,
    Expression<String>? annotation,
    Expression<bool>? readOnly,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (type != null) 'type': type,
      if (annotation != null) 'annotation': annotation,
      if (readOnly != null) 'read_only': readOnly,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WhitelistEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<int>? type,
      Value<String>? annotation,
      Value<bool>? readOnly,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WhitelistEntitiesCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      type: type ?? this.type,
      annotation: annotation ?? this.annotation,
      readOnly: readOnly ?? this.readOnly,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (annotation.present) {
      map['annotation'] = Variable<String>(annotation.value);
    }
    if (readOnly.present) {
      map['read_only'] = Variable<bool>(readOnly.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WhitelistEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('type: $type, ')
          ..write('annotation: $annotation, ')
          ..write('readOnly: $readOnly, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RuleEntitiesTable extends RuleEntities
    with TableInfo<$RuleEntitiesTable, RuleEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _isSystemRuleMeta =
      const VerificationMeta('isSystemRule');
  @override
  late final GeneratedColumn<bool> isSystemRule = GeneratedColumn<bool>(
      'is_system_rule', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_system_rule" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, isSystemRule, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_entities';
  @override
  VerificationContext validateIntegrity(Insertable<RuleEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_system_rule')) {
      context.handle(
          _isSystemRuleMeta,
          isSystemRule.isAcceptableOrUnknown(
              data['is_system_rule']!, _isSystemRuleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isSystemRule: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_system_rule'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RuleEntitiesTable createAlias(String alias) {
    return $RuleEntitiesTable(attachedDatabase, alias);
  }
}

class RuleEntity extends DataClass implements Insertable<RuleEntity> {
  final int id;
  final String name;
  final bool isSystemRule;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RuleEntity(
      {required this.id,
      required this.name,
      required this.isSystemRule,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_system_rule'] = Variable<bool>(isSystemRule);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RuleEntitiesCompanion toCompanion(bool nullToAbsent) {
    return RuleEntitiesCompanion(
      id: Value(id),
      name: Value(name),
      isSystemRule: Value(isSystemRule),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RuleEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isSystemRule: serializer.fromJson<bool>(json['isSystemRule']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isSystemRule': serializer.toJson<bool>(isSystemRule),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RuleEntity copyWith(
          {int? id,
          String? name,
          bool? isSystemRule,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RuleEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        isSystemRule: isSystemRule ?? this.isSystemRule,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RuleEntity copyWithCompanion(RuleEntitiesCompanion data) {
    return RuleEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isSystemRule: data.isSystemRule.present
          ? data.isSystemRule.value
          : this.isSystemRule,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isSystemRule: $isSystemRule, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isSystemRule, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.isSystemRule == this.isSystemRule &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RuleEntitiesCompanion extends UpdateCompanion<RuleEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isSystemRule;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RuleEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isSystemRule = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RuleEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isSystemRule = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<RuleEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isSystemRule,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isSystemRule != null) 'is_system_rule': isSystemRule,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RuleEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? isSystemRule,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RuleEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isSystemRule: isSystemRule ?? this.isSystemRule,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isSystemRule.present) {
      map['is_system_rule'] = Variable<bool>(isSystemRule.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isSystemRule: $isSystemRule, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RuleItemEntitiesTable extends RuleItemEntities
    with TableInfo<$RuleItemEntitiesTable, RuleItemEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleItemEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
      'rule_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES rule_entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMatchTypeMeta =
      const VerificationMeta('pathMatchType');
  @override
  late final GeneratedColumn<int> pathMatchType = GeneratedColumn<int>(
      'path_match_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _triggerCountMeta =
      const VerificationMeta('triggerCount');
  @override
  late final GeneratedColumn<int> triggerCount = GeneratedColumn<int>(
      'trigger_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastTriggeredAtMeta =
      const VerificationMeta('lastTriggeredAt');
  @override
  late final GeneratedColumn<DateTime> lastTriggeredAt =
      GeneratedColumn<DateTime>('last_triggered_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _actionTypeMeta =
      const VerificationMeta('actionType');
  @override
  late final GeneratedColumn<int> actionType = GeneratedColumn<int>(
      'action_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _annotationMeta =
      const VerificationMeta('annotation');
  @override
  late final GeneratedColumn<String> annotation = GeneratedColumn<String>(
      'annotation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ruleId,
        path,
        pathMatchType,
        tags,
        priority,
        enabled,
        triggerCount,
        lastTriggeredAt,
        actionType,
        annotation,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_item_entities';
  @override
  VerificationContext validateIntegrity(Insertable<RuleItemEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rule_id')) {
      context.handle(_ruleIdMeta,
          ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta));
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('path_match_type')) {
      context.handle(
          _pathMatchTypeMeta,
          pathMatchType.isAcceptableOrUnknown(
              data['path_match_type']!, _pathMatchTypeMeta));
    } else if (isInserting) {
      context.missing(_pathMatchTypeMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('trigger_count')) {
      context.handle(
          _triggerCountMeta,
          triggerCount.isAcceptableOrUnknown(
              data['trigger_count']!, _triggerCountMeta));
    }
    if (data.containsKey('last_triggered_at')) {
      context.handle(
          _lastTriggeredAtMeta,
          lastTriggeredAt.isAcceptableOrUnknown(
              data['last_triggered_at']!, _lastTriggeredAtMeta));
    }
    if (data.containsKey('action_type')) {
      context.handle(
          _actionTypeMeta,
          actionType.isAcceptableOrUnknown(
              data['action_type']!, _actionTypeMeta));
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('annotation')) {
      context.handle(
          _annotationMeta,
          annotation.isAcceptableOrUnknown(
              data['annotation']!, _annotationMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleItemEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleItemEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ruleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rule_id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      pathMatchType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}path_match_type'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
      triggerCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trigger_count'])!,
      lastTriggeredAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_triggered_at']),
      actionType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}action_type'])!,
      annotation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}annotation'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RuleItemEntitiesTable createAlias(String alias) {
    return $RuleItemEntitiesTable(attachedDatabase, alias);
  }
}

class RuleItemEntity extends DataClass implements Insertable<RuleItemEntity> {
  final int id;
  final int ruleId;
  final String path;
  final int pathMatchType;
  final String? tags;
  final int priority;
  final bool enabled;
  final int triggerCount;
  final DateTime? lastTriggeredAt;
  final int actionType;
  final String annotation;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RuleItemEntity(
      {required this.id,
      required this.ruleId,
      required this.path,
      required this.pathMatchType,
      this.tags,
      required this.priority,
      required this.enabled,
      required this.triggerCount,
      this.lastTriggeredAt,
      required this.actionType,
      required this.annotation,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rule_id'] = Variable<int>(ruleId);
    map['path'] = Variable<String>(path);
    map['path_match_type'] = Variable<int>(pathMatchType);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['priority'] = Variable<int>(priority);
    map['enabled'] = Variable<bool>(enabled);
    map['trigger_count'] = Variable<int>(triggerCount);
    if (!nullToAbsent || lastTriggeredAt != null) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt);
    }
    map['action_type'] = Variable<int>(actionType);
    map['annotation'] = Variable<String>(annotation);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RuleItemEntitiesCompanion toCompanion(bool nullToAbsent) {
    return RuleItemEntitiesCompanion(
      id: Value(id),
      ruleId: Value(ruleId),
      path: Value(path),
      pathMatchType: Value(pathMatchType),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      priority: Value(priority),
      enabled: Value(enabled),
      triggerCount: Value(triggerCount),
      lastTriggeredAt: lastTriggeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTriggeredAt),
      actionType: Value(actionType),
      annotation: Value(annotation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RuleItemEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleItemEntity(
      id: serializer.fromJson<int>(json['id']),
      ruleId: serializer.fromJson<int>(json['ruleId']),
      path: serializer.fromJson<String>(json['path']),
      pathMatchType: serializer.fromJson<int>(json['pathMatchType']),
      tags: serializer.fromJson<String?>(json['tags']),
      priority: serializer.fromJson<int>(json['priority']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      triggerCount: serializer.fromJson<int>(json['triggerCount']),
      lastTriggeredAt: serializer.fromJson<DateTime?>(json['lastTriggeredAt']),
      actionType: serializer.fromJson<int>(json['actionType']),
      annotation: serializer.fromJson<String>(json['annotation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruleId': serializer.toJson<int>(ruleId),
      'path': serializer.toJson<String>(path),
      'pathMatchType': serializer.toJson<int>(pathMatchType),
      'tags': serializer.toJson<String?>(tags),
      'priority': serializer.toJson<int>(priority),
      'enabled': serializer.toJson<bool>(enabled),
      'triggerCount': serializer.toJson<int>(triggerCount),
      'lastTriggeredAt': serializer.toJson<DateTime?>(lastTriggeredAt),
      'actionType': serializer.toJson<int>(actionType),
      'annotation': serializer.toJson<String>(annotation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RuleItemEntity copyWith(
          {int? id,
          int? ruleId,
          String? path,
          int? pathMatchType,
          Value<String?> tags = const Value.absent(),
          int? priority,
          bool? enabled,
          int? triggerCount,
          Value<DateTime?> lastTriggeredAt = const Value.absent(),
          int? actionType,
          String? annotation,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RuleItemEntity(
        id: id ?? this.id,
        ruleId: ruleId ?? this.ruleId,
        path: path ?? this.path,
        pathMatchType: pathMatchType ?? this.pathMatchType,
        tags: tags.present ? tags.value : this.tags,
        priority: priority ?? this.priority,
        enabled: enabled ?? this.enabled,
        triggerCount: triggerCount ?? this.triggerCount,
        lastTriggeredAt: lastTriggeredAt.present
            ? lastTriggeredAt.value
            : this.lastTriggeredAt,
        actionType: actionType ?? this.actionType,
        annotation: annotation ?? this.annotation,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RuleItemEntity copyWithCompanion(RuleItemEntitiesCompanion data) {
    return RuleItemEntity(
      id: data.id.present ? data.id.value : this.id,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      path: data.path.present ? data.path.value : this.path,
      pathMatchType: data.pathMatchType.present
          ? data.pathMatchType.value
          : this.pathMatchType,
      tags: data.tags.present ? data.tags.value : this.tags,
      priority: data.priority.present ? data.priority.value : this.priority,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      triggerCount: data.triggerCount.present
          ? data.triggerCount.value
          : this.triggerCount,
      lastTriggeredAt: data.lastTriggeredAt.present
          ? data.lastTriggeredAt.value
          : this.lastTriggeredAt,
      actionType:
          data.actionType.present ? data.actionType.value : this.actionType,
      annotation:
          data.annotation.present ? data.annotation.value : this.annotation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleItemEntity(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('path: $path, ')
          ..write('pathMatchType: $pathMatchType, ')
          ..write('tags: $tags, ')
          ..write('priority: $priority, ')
          ..write('enabled: $enabled, ')
          ..write('triggerCount: $triggerCount, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('actionType: $actionType, ')
          ..write('annotation: $annotation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      ruleId,
      path,
      pathMatchType,
      tags,
      priority,
      enabled,
      triggerCount,
      lastTriggeredAt,
      actionType,
      annotation,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleItemEntity &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.path == this.path &&
          other.pathMatchType == this.pathMatchType &&
          other.tags == this.tags &&
          other.priority == this.priority &&
          other.enabled == this.enabled &&
          other.triggerCount == this.triggerCount &&
          other.lastTriggeredAt == this.lastTriggeredAt &&
          other.actionType == this.actionType &&
          other.annotation == this.annotation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RuleItemEntitiesCompanion extends UpdateCompanion<RuleItemEntity> {
  final Value<int> id;
  final Value<int> ruleId;
  final Value<String> path;
  final Value<int> pathMatchType;
  final Value<String?> tags;
  final Value<int> priority;
  final Value<bool> enabled;
  final Value<int> triggerCount;
  final Value<DateTime?> lastTriggeredAt;
  final Value<int> actionType;
  final Value<String> annotation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RuleItemEntitiesCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.path = const Value.absent(),
    this.pathMatchType = const Value.absent(),
    this.tags = const Value.absent(),
    this.priority = const Value.absent(),
    this.enabled = const Value.absent(),
    this.triggerCount = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    this.actionType = const Value.absent(),
    this.annotation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RuleItemEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required int ruleId,
    required String path,
    required int pathMatchType,
    this.tags = const Value.absent(),
    this.priority = const Value.absent(),
    this.enabled = const Value.absent(),
    this.triggerCount = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    required int actionType,
    this.annotation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : ruleId = Value(ruleId),
        path = Value(path),
        pathMatchType = Value(pathMatchType),
        actionType = Value(actionType);
  static Insertable<RuleItemEntity> custom({
    Expression<int>? id,
    Expression<int>? ruleId,
    Expression<String>? path,
    Expression<int>? pathMatchType,
    Expression<String>? tags,
    Expression<int>? priority,
    Expression<bool>? enabled,
    Expression<int>? triggerCount,
    Expression<DateTime>? lastTriggeredAt,
    Expression<int>? actionType,
    Expression<String>? annotation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (path != null) 'path': path,
      if (pathMatchType != null) 'path_match_type': pathMatchType,
      if (tags != null) 'tags': tags,
      if (priority != null) 'priority': priority,
      if (enabled != null) 'enabled': enabled,
      if (triggerCount != null) 'trigger_count': triggerCount,
      if (lastTriggeredAt != null) 'last_triggered_at': lastTriggeredAt,
      if (actionType != null) 'action_type': actionType,
      if (annotation != null) 'annotation': annotation,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RuleItemEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<int>? ruleId,
      Value<String>? path,
      Value<int>? pathMatchType,
      Value<String?>? tags,
      Value<int>? priority,
      Value<bool>? enabled,
      Value<int>? triggerCount,
      Value<DateTime?>? lastTriggeredAt,
      Value<int>? actionType,
      Value<String>? annotation,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RuleItemEntitiesCompanion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      path: path ?? this.path,
      pathMatchType: pathMatchType ?? this.pathMatchType,
      tags: tags ?? this.tags,
      priority: priority ?? this.priority,
      enabled: enabled ?? this.enabled,
      triggerCount: triggerCount ?? this.triggerCount,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      actionType: actionType ?? this.actionType,
      annotation: annotation ?? this.annotation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (pathMatchType.present) {
      map['path_match_type'] = Variable<int>(pathMatchType.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (triggerCount.present) {
      map['trigger_count'] = Variable<int>(triggerCount.value);
    }
    if (lastTriggeredAt.present) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<int>(actionType.value);
    }
    if (annotation.present) {
      map['annotation'] = Variable<String>(annotation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleItemEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('path: $path, ')
          ..write('pathMatchType: $pathMatchType, ')
          ..write('tags: $tags, ')
          ..write('priority: $priority, ')
          ..write('enabled: $enabled, ')
          ..write('triggerCount: $triggerCount, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('actionType: $actionType, ')
          ..write('annotation: $annotation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HistoryEntitiesTable extends HistoryEntities
    with TableInfo<$HistoryEntitiesTable, HistoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _actionTypeMeta =
      const VerificationMeta('actionType');
  @override
  late final GeneratedColumn<int> actionType = GeneratedColumn<int>(
      'action_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _spaceChangeMeta =
      const VerificationMeta('spaceChange');
  @override
  late final GeneratedColumn<int> spaceChange = GeneratedColumn<int>(
      'space_change', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
      'rule_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES rule_item_entities (id) ON DELETE SET NULL'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(models.HistoryStatus.success.index));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        path,
        time,
        actionType,
        spaceChange,
        ruleId,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_entities';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('action_type')) {
      context.handle(
          _actionTypeMeta,
          actionType.isAcceptableOrUnknown(
              data['action_type']!, _actionTypeMeta));
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('space_change')) {
      context.handle(
          _spaceChangeMeta,
          spaceChange.isAcceptableOrUnknown(
              data['space_change']!, _spaceChangeMeta));
    }
    if (data.containsKey('rule_id')) {
      context.handle(_ruleIdMeta,
          ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      actionType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}action_type'])!,
      spaceChange: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}space_change']),
      ruleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rule_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HistoryEntitiesTable createAlias(String alias) {
    return $HistoryEntitiesTable(attachedDatabase, alias);
  }
}

class HistoryEntity extends DataClass implements Insertable<HistoryEntity> {
  final int id;
  final String name;
  final String path;
  final DateTime time;
  final int actionType;
  final int? spaceChange;
  final int? ruleId;
  final int status;
  final DateTime createdAt;
  const HistoryEntity(
      {required this.id,
      required this.name,
      required this.path,
      required this.time,
      required this.actionType,
      this.spaceChange,
      this.ruleId,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['time'] = Variable<DateTime>(time);
    map['action_type'] = Variable<int>(actionType);
    if (!nullToAbsent || spaceChange != null) {
      map['space_change'] = Variable<int>(spaceChange);
    }
    if (!nullToAbsent || ruleId != null) {
      map['rule_id'] = Variable<int>(ruleId);
    }
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HistoryEntitiesCompanion toCompanion(bool nullToAbsent) {
    return HistoryEntitiesCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
      time: Value(time),
      actionType: Value(actionType),
      spaceChange: spaceChange == null && nullToAbsent
          ? const Value.absent()
          : Value(spaceChange),
      ruleId:
          ruleId == null && nullToAbsent ? const Value.absent() : Value(ruleId),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory HistoryEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      time: serializer.fromJson<DateTime>(json['time']),
      actionType: serializer.fromJson<int>(json['actionType']),
      spaceChange: serializer.fromJson<int?>(json['spaceChange']),
      ruleId: serializer.fromJson<int?>(json['ruleId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'time': serializer.toJson<DateTime>(time),
      'actionType': serializer.toJson<int>(actionType),
      'spaceChange': serializer.toJson<int?>(spaceChange),
      'ruleId': serializer.toJson<int?>(ruleId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HistoryEntity copyWith(
          {int? id,
          String? name,
          String? path,
          DateTime? time,
          int? actionType,
          Value<int?> spaceChange = const Value.absent(),
          Value<int?> ruleId = const Value.absent(),
          int? status,
          DateTime? createdAt}) =>
      HistoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        path: path ?? this.path,
        time: time ?? this.time,
        actionType: actionType ?? this.actionType,
        spaceChange: spaceChange.present ? spaceChange.value : this.spaceChange,
        ruleId: ruleId.present ? ruleId.value : this.ruleId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  HistoryEntity copyWithCompanion(HistoryEntitiesCompanion data) {
    return HistoryEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
      time: data.time.present ? data.time.value : this.time,
      actionType:
          data.actionType.present ? data.actionType.value : this.actionType,
      spaceChange:
          data.spaceChange.present ? data.spaceChange.value : this.spaceChange,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('time: $time, ')
          ..write('actionType: $actionType, ')
          ..write('spaceChange: $spaceChange, ')
          ..write('ruleId: $ruleId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, path, time, actionType, spaceChange, ruleId, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path &&
          other.time == this.time &&
          other.actionType == this.actionType &&
          other.spaceChange == this.spaceChange &&
          other.ruleId == this.ruleId &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class HistoryEntitiesCompanion extends UpdateCompanion<HistoryEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> path;
  final Value<DateTime> time;
  final Value<int> actionType;
  final Value<int?> spaceChange;
  final Value<int?> ruleId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  const HistoryEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.time = const Value.absent(),
    this.actionType = const Value.absent(),
    this.spaceChange = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistoryEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
    required DateTime time,
    required int actionType,
    this.spaceChange = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        path = Value(path),
        time = Value(time),
        actionType = Value(actionType);
  static Insertable<HistoryEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? path,
    Expression<DateTime>? time,
    Expression<int>? actionType,
    Expression<int>? spaceChange,
    Expression<int>? ruleId,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (time != null) 'time': time,
      if (actionType != null) 'action_type': actionType,
      if (spaceChange != null) 'space_change': spaceChange,
      if (ruleId != null) 'rule_id': ruleId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HistoryEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? path,
      Value<DateTime>? time,
      Value<int>? actionType,
      Value<int?>? spaceChange,
      Value<int?>? ruleId,
      Value<int>? status,
      Value<DateTime>? createdAt}) {
    return HistoryEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      time: time ?? this.time,
      actionType: actionType ?? this.actionType,
      spaceChange: spaceChange ?? this.spaceChange,
      ruleId: ruleId ?? this.ruleId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<int>(actionType.value);
    }
    if (spaceChange.present) {
      map['space_change'] = Variable<int>(spaceChange.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('time: $time, ')
          ..write('actionType: $actionType, ')
          ..write('spaceChange: $spaceChange, ')
          ..write('ruleId: $ruleId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PathAnnotationEntitiesTable extends PathAnnotationEntities
    with TableInfo<$PathAnnotationEntitiesTable, PathAnnotationEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PathAnnotationEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _suggestDeleteMeta =
      const VerificationMeta('suggestDelete');
  @override
  late final GeneratedColumn<bool> suggestDelete = GeneratedColumn<bool>(
      'suggest_delete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("suggest_delete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isBuiltInMeta =
      const VerificationMeta('isBuiltIn');
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
      'is_built_in', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_built_in" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _pathMatchTypeMeta =
      const VerificationMeta('pathMatchType');
  @override
  late final GeneratedColumn<int> pathMatchType = GeneratedColumn<int>(
      'path_match_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        path,
        description,
        suggestDelete,
        isBuiltIn,
        pathMatchType,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'path_annotation_entities';
  @override
  VerificationContext validateIntegrity(
      Insertable<PathAnnotationEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('suggest_delete')) {
      context.handle(
          _suggestDeleteMeta,
          suggestDelete.isAcceptableOrUnknown(
              data['suggest_delete']!, _suggestDeleteMeta));
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
          _isBuiltInMeta,
          isBuiltIn.isAcceptableOrUnknown(
              data['is_built_in']!, _isBuiltInMeta));
    }
    if (data.containsKey('path_match_type')) {
      context.handle(
          _pathMatchTypeMeta,
          pathMatchType.isAcceptableOrUnknown(
              data['path_match_type']!, _pathMatchTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PathAnnotationEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PathAnnotationEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      suggestDelete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}suggest_delete'])!,
      isBuiltIn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_built_in'])!,
      pathMatchType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}path_match_type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PathAnnotationEntitiesTable createAlias(String alias) {
    return $PathAnnotationEntitiesTable(attachedDatabase, alias);
  }
}

class PathAnnotationEntity extends DataClass
    implements Insertable<PathAnnotationEntity> {
  final int id;
  final String path;
  final String description;
  final bool suggestDelete;
  final bool isBuiltIn;
  final int pathMatchType;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PathAnnotationEntity(
      {required this.id,
      required this.path,
      required this.description,
      required this.suggestDelete,
      required this.isBuiltIn,
      required this.pathMatchType,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    map['description'] = Variable<String>(description);
    map['suggest_delete'] = Variable<bool>(suggestDelete);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['path_match_type'] = Variable<int>(pathMatchType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PathAnnotationEntitiesCompanion toCompanion(bool nullToAbsent) {
    return PathAnnotationEntitiesCompanion(
      id: Value(id),
      path: Value(path),
      description: Value(description),
      suggestDelete: Value(suggestDelete),
      isBuiltIn: Value(isBuiltIn),
      pathMatchType: Value(pathMatchType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PathAnnotationEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PathAnnotationEntity(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      description: serializer.fromJson<String>(json['description']),
      suggestDelete: serializer.fromJson<bool>(json['suggestDelete']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      pathMatchType: serializer.fromJson<int>(json['pathMatchType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'description': serializer.toJson<String>(description),
      'suggestDelete': serializer.toJson<bool>(suggestDelete),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'pathMatchType': serializer.toJson<int>(pathMatchType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PathAnnotationEntity copyWith(
          {int? id,
          String? path,
          String? description,
          bool? suggestDelete,
          bool? isBuiltIn,
          int? pathMatchType,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PathAnnotationEntity(
        id: id ?? this.id,
        path: path ?? this.path,
        description: description ?? this.description,
        suggestDelete: suggestDelete ?? this.suggestDelete,
        isBuiltIn: isBuiltIn ?? this.isBuiltIn,
        pathMatchType: pathMatchType ?? this.pathMatchType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PathAnnotationEntity copyWithCompanion(PathAnnotationEntitiesCompanion data) {
    return PathAnnotationEntity(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      description:
          data.description.present ? data.description.value : this.description,
      suggestDelete: data.suggestDelete.present
          ? data.suggestDelete.value
          : this.suggestDelete,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      pathMatchType: data.pathMatchType.present
          ? data.pathMatchType.value
          : this.pathMatchType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PathAnnotationEntity(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('description: $description, ')
          ..write('suggestDelete: $suggestDelete, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('pathMatchType: $pathMatchType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path, description, suggestDelete,
      isBuiltIn, pathMatchType, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PathAnnotationEntity &&
          other.id == this.id &&
          other.path == this.path &&
          other.description == this.description &&
          other.suggestDelete == this.suggestDelete &&
          other.isBuiltIn == this.isBuiltIn &&
          other.pathMatchType == this.pathMatchType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PathAnnotationEntitiesCompanion
    extends UpdateCompanion<PathAnnotationEntity> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> description;
  final Value<bool> suggestDelete;
  final Value<bool> isBuiltIn;
  final Value<int> pathMatchType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PathAnnotationEntitiesCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.description = const Value.absent(),
    this.suggestDelete = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.pathMatchType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PathAnnotationEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    this.description = const Value.absent(),
    this.suggestDelete = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.pathMatchType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : path = Value(path);
  static Insertable<PathAnnotationEntity> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? description,
    Expression<bool>? suggestDelete,
    Expression<bool>? isBuiltIn,
    Expression<int>? pathMatchType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (description != null) 'description': description,
      if (suggestDelete != null) 'suggest_delete': suggestDelete,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (pathMatchType != null) 'path_match_type': pathMatchType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PathAnnotationEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? description,
      Value<bool>? suggestDelete,
      Value<bool>? isBuiltIn,
      Value<int>? pathMatchType,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PathAnnotationEntitiesCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      description: description ?? this.description,
      suggestDelete: suggestDelete ?? this.suggestDelete,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      pathMatchType: pathMatchType ?? this.pathMatchType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (suggestDelete.present) {
      map['suggest_delete'] = Variable<bool>(suggestDelete.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (pathMatchType.present) {
      map['path_match_type'] = Variable<int>(pathMatchType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PathAnnotationEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('description: $description, ')
          ..write('suggestDelete: $suggestDelete, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('pathMatchType: $pathMatchType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WhitelistEntitiesTable whitelistEntities =
      $WhitelistEntitiesTable(this);
  late final $RuleEntitiesTable ruleEntities = $RuleEntitiesTable(this);
  late final $RuleItemEntitiesTable ruleItemEntities =
      $RuleItemEntitiesTable(this);
  late final $HistoryEntitiesTable historyEntities =
      $HistoryEntitiesTable(this);
  late final $PathAnnotationEntitiesTable pathAnnotationEntities =
      $PathAnnotationEntitiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        whitelistEntities,
        ruleEntities,
        ruleItemEntities,
        historyEntities,
        pathAnnotationEntities
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('rule_entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('rule_item_entities', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('rule_item_entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('history_entities', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $$WhitelistEntitiesTableCreateCompanionBuilder
    = WhitelistEntitiesCompanion Function({
  Value<int> id,
  required String path,
  Value<int> type,
  Value<String> annotation,
  Value<bool> readOnly,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WhitelistEntitiesTableUpdateCompanionBuilder
    = WhitelistEntitiesCompanion Function({
  Value<int> id,
  Value<String> path,
  Value<int> type,
  Value<String> annotation,
  Value<bool> readOnly,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$WhitelistEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $WhitelistEntitiesTable> {
  $$WhitelistEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get readOnly => $composableBuilder(
      column: $table.readOnly, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WhitelistEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $WhitelistEntitiesTable> {
  $$WhitelistEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get readOnly => $composableBuilder(
      column: $table.readOnly, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WhitelistEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WhitelistEntitiesTable> {
  $$WhitelistEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => column);

  GeneratedColumn<bool> get readOnly =>
      $composableBuilder(column: $table.readOnly, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WhitelistEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WhitelistEntitiesTable,
    WhitelistEntity,
    $$WhitelistEntitiesTableFilterComposer,
    $$WhitelistEntitiesTableOrderingComposer,
    $$WhitelistEntitiesTableAnnotationComposer,
    $$WhitelistEntitiesTableCreateCompanionBuilder,
    $$WhitelistEntitiesTableUpdateCompanionBuilder,
    (
      WhitelistEntity,
      BaseReferences<_$AppDatabase, $WhitelistEntitiesTable, WhitelistEntity>
    ),
    WhitelistEntity,
    PrefetchHooks Function()> {
  $$WhitelistEntitiesTableTableManager(
      _$AppDatabase db, $WhitelistEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WhitelistEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WhitelistEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WhitelistEntitiesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<bool> readOnly = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhitelistEntitiesCompanion(
            id: id,
            path: path,
            type: type,
            annotation: annotation,
            readOnly: readOnly,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String path,
            Value<int> type = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<bool> readOnly = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhitelistEntitiesCompanion.insert(
            id: id,
            path: path,
            type: type,
            annotation: annotation,
            readOnly: readOnly,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WhitelistEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WhitelistEntitiesTable,
    WhitelistEntity,
    $$WhitelistEntitiesTableFilterComposer,
    $$WhitelistEntitiesTableOrderingComposer,
    $$WhitelistEntitiesTableAnnotationComposer,
    $$WhitelistEntitiesTableCreateCompanionBuilder,
    $$WhitelistEntitiesTableUpdateCompanionBuilder,
    (
      WhitelistEntity,
      BaseReferences<_$AppDatabase, $WhitelistEntitiesTable, WhitelistEntity>
    ),
    WhitelistEntity,
    PrefetchHooks Function()>;
typedef $$RuleEntitiesTableCreateCompanionBuilder = RuleEntitiesCompanion
    Function({
  Value<int> id,
  required String name,
  Value<bool> isSystemRule,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RuleEntitiesTableUpdateCompanionBuilder = RuleEntitiesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<bool> isSystemRule,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$RuleEntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $RuleEntitiesTable, RuleEntity> {
  $$RuleEntitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RuleItemEntitiesTable, List<RuleItemEntity>>
      _ruleItemEntitiesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.ruleItemEntities,
              aliasName: $_aliasNameGenerator(
                  db.ruleEntities.id, db.ruleItemEntities.ruleId));

  $$RuleItemEntitiesTableProcessedTableManager get ruleItemEntitiesRefs {
    final manager =
        $$RuleItemEntitiesTableTableManager($_db, $_db.ruleItemEntities)
            .filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_ruleItemEntitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RuleEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $RuleEntitiesTable> {
  $$RuleEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSystemRule => $composableBuilder(
      column: $table.isSystemRule, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> ruleItemEntitiesRefs(
      Expression<bool> Function($$RuleItemEntitiesTableFilterComposer f) f) {
    final $$RuleItemEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ruleItemEntities,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.ruleItemEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RuleEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleEntitiesTable> {
  $$RuleEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSystemRule => $composableBuilder(
      column: $table.isSystemRule,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RuleEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleEntitiesTable> {
  $$RuleEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isSystemRule => $composableBuilder(
      column: $table.isSystemRule, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> ruleItemEntitiesRefs<T extends Object>(
      Expression<T> Function($$RuleItemEntitiesTableAnnotationComposer a) f) {
    final $$RuleItemEntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ruleItemEntities,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemEntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.ruleItemEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RuleEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RuleEntitiesTable,
    RuleEntity,
    $$RuleEntitiesTableFilterComposer,
    $$RuleEntitiesTableOrderingComposer,
    $$RuleEntitiesTableAnnotationComposer,
    $$RuleEntitiesTableCreateCompanionBuilder,
    $$RuleEntitiesTableUpdateCompanionBuilder,
    (RuleEntity, $$RuleEntitiesTableReferences),
    RuleEntity,
    PrefetchHooks Function({bool ruleItemEntitiesRefs})> {
  $$RuleEntitiesTableTableManager(_$AppDatabase db, $RuleEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isSystemRule = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleEntitiesCompanion(
            id: id,
            name: name,
            isSystemRule: isSystemRule,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<bool> isSystemRule = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleEntitiesCompanion.insert(
            id: id,
            name: name,
            isSystemRule: isSystemRule,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RuleEntitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ruleItemEntitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ruleItemEntitiesRefs) db.ruleItemEntities
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ruleItemEntitiesRefs)
                    await $_getPrefetchedData<RuleEntity, $RuleEntitiesTable,
                            RuleItemEntity>(
                        currentTable: table,
                        referencedTable: $$RuleEntitiesTableReferences
                            ._ruleItemEntitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RuleEntitiesTableReferences(db, table, p0)
                                .ruleItemEntitiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ruleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RuleEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RuleEntitiesTable,
    RuleEntity,
    $$RuleEntitiesTableFilterComposer,
    $$RuleEntitiesTableOrderingComposer,
    $$RuleEntitiesTableAnnotationComposer,
    $$RuleEntitiesTableCreateCompanionBuilder,
    $$RuleEntitiesTableUpdateCompanionBuilder,
    (RuleEntity, $$RuleEntitiesTableReferences),
    RuleEntity,
    PrefetchHooks Function({bool ruleItemEntitiesRefs})>;
typedef $$RuleItemEntitiesTableCreateCompanionBuilder
    = RuleItemEntitiesCompanion Function({
  Value<int> id,
  required int ruleId,
  required String path,
  required int pathMatchType,
  Value<String?> tags,
  Value<int> priority,
  Value<bool> enabled,
  Value<int> triggerCount,
  Value<DateTime?> lastTriggeredAt,
  required int actionType,
  Value<String> annotation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RuleItemEntitiesTableUpdateCompanionBuilder
    = RuleItemEntitiesCompanion Function({
  Value<int> id,
  Value<int> ruleId,
  Value<String> path,
  Value<int> pathMatchType,
  Value<String?> tags,
  Value<int> priority,
  Value<bool> enabled,
  Value<int> triggerCount,
  Value<DateTime?> lastTriggeredAt,
  Value<int> actionType,
  Value<String> annotation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$RuleItemEntitiesTableReferences extends BaseReferences<
    _$AppDatabase, $RuleItemEntitiesTable, RuleItemEntity> {
  $$RuleItemEntitiesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RuleEntitiesTable _ruleIdTable(_$AppDatabase db) =>
      db.ruleEntities.createAlias(
          $_aliasNameGenerator(db.ruleItemEntities.ruleId, db.ruleEntities.id));

  $$RuleEntitiesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<int>('rule_id')!;

    final manager = $$RuleEntitiesTableTableManager($_db, $_db.ruleEntities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$HistoryEntitiesTable, List<HistoryEntity>>
      _historyEntitiesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.historyEntities,
              aliasName: $_aliasNameGenerator(
                  db.ruleItemEntities.id, db.historyEntities.ruleId));

  $$HistoryEntitiesTableProcessedTableManager get historyEntitiesRefs {
    final manager =
        $$HistoryEntitiesTableTableManager($_db, $_db.historyEntities)
            .filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_historyEntitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RuleItemEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $RuleItemEntitiesTable> {
  $$RuleItemEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pathMatchType => $composableBuilder(
      column: $table.pathMatchType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get triggerCount => $composableBuilder(
      column: $table.triggerCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastTriggeredAt => $composableBuilder(
      column: $table.lastTriggeredAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$RuleEntitiesTableFilterComposer get ruleId {
    final $$RuleEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.ruleEntities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.ruleEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> historyEntitiesRefs(
      Expression<bool> Function($$HistoryEntitiesTableFilterComposer f) f) {
    final $$HistoryEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.historyEntities,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HistoryEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.historyEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RuleItemEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleItemEntitiesTable> {
  $$RuleItemEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pathMatchType => $composableBuilder(
      column: $table.pathMatchType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get triggerCount => $composableBuilder(
      column: $table.triggerCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastTriggeredAt => $composableBuilder(
      column: $table.lastTriggeredAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$RuleEntitiesTableOrderingComposer get ruleId {
    final $$RuleEntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.ruleEntities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleEntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.ruleEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RuleItemEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleItemEntitiesTable> {
  $$RuleItemEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get pathMatchType => $composableBuilder(
      column: $table.pathMatchType, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get triggerCount => $composableBuilder(
      column: $table.triggerCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTriggeredAt => $composableBuilder(
      column: $table.lastTriggeredAt, builder: (column) => column);

  GeneratedColumn<int> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => column);

  GeneratedColumn<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$RuleEntitiesTableAnnotationComposer get ruleId {
    final $$RuleEntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.ruleEntities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleEntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.ruleEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> historyEntitiesRefs<T extends Object>(
      Expression<T> Function($$HistoryEntitiesTableAnnotationComposer a) f) {
    final $$HistoryEntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.historyEntities,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HistoryEntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.historyEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RuleItemEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RuleItemEntitiesTable,
    RuleItemEntity,
    $$RuleItemEntitiesTableFilterComposer,
    $$RuleItemEntitiesTableOrderingComposer,
    $$RuleItemEntitiesTableAnnotationComposer,
    $$RuleItemEntitiesTableCreateCompanionBuilder,
    $$RuleItemEntitiesTableUpdateCompanionBuilder,
    (RuleItemEntity, $$RuleItemEntitiesTableReferences),
    RuleItemEntity,
    PrefetchHooks Function({bool ruleId, bool historyEntitiesRefs})> {
  $$RuleItemEntitiesTableTableManager(
      _$AppDatabase db, $RuleItemEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleItemEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleItemEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleItemEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ruleId = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> pathMatchType = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<int> triggerCount = const Value.absent(),
            Value<DateTime?> lastTriggeredAt = const Value.absent(),
            Value<int> actionType = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleItemEntitiesCompanion(
            id: id,
            ruleId: ruleId,
            path: path,
            pathMatchType: pathMatchType,
            tags: tags,
            priority: priority,
            enabled: enabled,
            triggerCount: triggerCount,
            lastTriggeredAt: lastTriggeredAt,
            actionType: actionType,
            annotation: annotation,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ruleId,
            required String path,
            required int pathMatchType,
            Value<String?> tags = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<int> triggerCount = const Value.absent(),
            Value<DateTime?> lastTriggeredAt = const Value.absent(),
            required int actionType,
            Value<String> annotation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleItemEntitiesCompanion.insert(
            id: id,
            ruleId: ruleId,
            path: path,
            pathMatchType: pathMatchType,
            tags: tags,
            priority: priority,
            enabled: enabled,
            triggerCount: triggerCount,
            lastTriggeredAt: lastTriggeredAt,
            actionType: actionType,
            annotation: annotation,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RuleItemEntitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {ruleId = false, historyEntitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (historyEntitiesRefs) db.historyEntities
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ruleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ruleId,
                    referencedTable:
                        $$RuleItemEntitiesTableReferences._ruleIdTable(db),
                    referencedColumn:
                        $$RuleItemEntitiesTableReferences._ruleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (historyEntitiesRefs)
                    await $_getPrefetchedData<RuleItemEntity,
                            $RuleItemEntitiesTable, HistoryEntity>(
                        currentTable: table,
                        referencedTable: $$RuleItemEntitiesTableReferences
                            ._historyEntitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RuleItemEntitiesTableReferences(db, table, p0)
                                .historyEntitiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ruleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RuleItemEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RuleItemEntitiesTable,
    RuleItemEntity,
    $$RuleItemEntitiesTableFilterComposer,
    $$RuleItemEntitiesTableOrderingComposer,
    $$RuleItemEntitiesTableAnnotationComposer,
    $$RuleItemEntitiesTableCreateCompanionBuilder,
    $$RuleItemEntitiesTableUpdateCompanionBuilder,
    (RuleItemEntity, $$RuleItemEntitiesTableReferences),
    RuleItemEntity,
    PrefetchHooks Function({bool ruleId, bool historyEntitiesRefs})>;
typedef $$HistoryEntitiesTableCreateCompanionBuilder = HistoryEntitiesCompanion
    Function({
  Value<int> id,
  required String name,
  required String path,
  required DateTime time,
  required int actionType,
  Value<int?> spaceChange,
  Value<int?> ruleId,
  Value<int> status,
  Value<DateTime> createdAt,
});
typedef $$HistoryEntitiesTableUpdateCompanionBuilder = HistoryEntitiesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> path,
  Value<DateTime> time,
  Value<int> actionType,
  Value<int?> spaceChange,
  Value<int?> ruleId,
  Value<int> status,
  Value<DateTime> createdAt,
});

final class $$HistoryEntitiesTableReferences extends BaseReferences<
    _$AppDatabase, $HistoryEntitiesTable, HistoryEntity> {
  $$HistoryEntitiesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RuleItemEntitiesTable _ruleIdTable(_$AppDatabase db) =>
      db.ruleItemEntities.createAlias($_aliasNameGenerator(
          db.historyEntities.ruleId, db.ruleItemEntities.id));

  $$RuleItemEntitiesTableProcessedTableManager? get ruleId {
    final $_column = $_itemColumn<int>('rule_id');
    if ($_column == null) return null;
    final manager =
        $$RuleItemEntitiesTableTableManager($_db, $_db.ruleItemEntities)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HistoryEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryEntitiesTable> {
  $$HistoryEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get spaceChange => $composableBuilder(
      column: $table.spaceChange, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$RuleItemEntitiesTableFilterComposer get ruleId {
    final $$RuleItemEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.ruleItemEntities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.ruleItemEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HistoryEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryEntitiesTable> {
  $$HistoryEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get spaceChange => $composableBuilder(
      column: $table.spaceChange, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$RuleItemEntitiesTableOrderingComposer get ruleId {
    final $$RuleItemEntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.ruleItemEntities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemEntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.ruleItemEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HistoryEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryEntitiesTable> {
  $$HistoryEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => column);

  GeneratedColumn<int> get spaceChange => $composableBuilder(
      column: $table.spaceChange, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RuleItemEntitiesTableAnnotationComposer get ruleId {
    final $$RuleItemEntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.ruleItemEntities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemEntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.ruleItemEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HistoryEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistoryEntitiesTable,
    HistoryEntity,
    $$HistoryEntitiesTableFilterComposer,
    $$HistoryEntitiesTableOrderingComposer,
    $$HistoryEntitiesTableAnnotationComposer,
    $$HistoryEntitiesTableCreateCompanionBuilder,
    $$HistoryEntitiesTableUpdateCompanionBuilder,
    (HistoryEntity, $$HistoryEntitiesTableReferences),
    HistoryEntity,
    PrefetchHooks Function({bool ruleId})> {
  $$HistoryEntitiesTableTableManager(
      _$AppDatabase db, $HistoryEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<int> actionType = const Value.absent(),
            Value<int?> spaceChange = const Value.absent(),
            Value<int?> ruleId = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HistoryEntitiesCompanion(
            id: id,
            name: name,
            path: path,
            time: time,
            actionType: actionType,
            spaceChange: spaceChange,
            ruleId: ruleId,
            status: status,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String path,
            required DateTime time,
            required int actionType,
            Value<int?> spaceChange = const Value.absent(),
            Value<int?> ruleId = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HistoryEntitiesCompanion.insert(
            id: id,
            name: name,
            path: path,
            time: time,
            actionType: actionType,
            spaceChange: spaceChange,
            ruleId: ruleId,
            status: status,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HistoryEntitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ruleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ruleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ruleId,
                    referencedTable:
                        $$HistoryEntitiesTableReferences._ruleIdTable(db),
                    referencedColumn:
                        $$HistoryEntitiesTableReferences._ruleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HistoryEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistoryEntitiesTable,
    HistoryEntity,
    $$HistoryEntitiesTableFilterComposer,
    $$HistoryEntitiesTableOrderingComposer,
    $$HistoryEntitiesTableAnnotationComposer,
    $$HistoryEntitiesTableCreateCompanionBuilder,
    $$HistoryEntitiesTableUpdateCompanionBuilder,
    (HistoryEntity, $$HistoryEntitiesTableReferences),
    HistoryEntity,
    PrefetchHooks Function({bool ruleId})>;
typedef $$PathAnnotationEntitiesTableCreateCompanionBuilder
    = PathAnnotationEntitiesCompanion Function({
  Value<int> id,
  required String path,
  Value<String> description,
  Value<bool> suggestDelete,
  Value<bool> isBuiltIn,
  Value<int> pathMatchType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PathAnnotationEntitiesTableUpdateCompanionBuilder
    = PathAnnotationEntitiesCompanion Function({
  Value<int> id,
  Value<String> path,
  Value<String> description,
  Value<bool> suggestDelete,
  Value<bool> isBuiltIn,
  Value<int> pathMatchType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$PathAnnotationEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PathAnnotationEntitiesTable> {
  $$PathAnnotationEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get suggestDelete => $composableBuilder(
      column: $table.suggestDelete, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
      column: $table.isBuiltIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pathMatchType => $composableBuilder(
      column: $table.pathMatchType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PathAnnotationEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PathAnnotationEntitiesTable> {
  $$PathAnnotationEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get suggestDelete => $composableBuilder(
      column: $table.suggestDelete,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
      column: $table.isBuiltIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pathMatchType => $composableBuilder(
      column: $table.pathMatchType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PathAnnotationEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PathAnnotationEntitiesTable> {
  $$PathAnnotationEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get suggestDelete => $composableBuilder(
      column: $table.suggestDelete, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<int> get pathMatchType => $composableBuilder(
      column: $table.pathMatchType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PathAnnotationEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PathAnnotationEntitiesTable,
    PathAnnotationEntity,
    $$PathAnnotationEntitiesTableFilterComposer,
    $$PathAnnotationEntitiesTableOrderingComposer,
    $$PathAnnotationEntitiesTableAnnotationComposer,
    $$PathAnnotationEntitiesTableCreateCompanionBuilder,
    $$PathAnnotationEntitiesTableUpdateCompanionBuilder,
    (
      PathAnnotationEntity,
      BaseReferences<_$AppDatabase, $PathAnnotationEntitiesTable,
          PathAnnotationEntity>
    ),
    PathAnnotationEntity,
    PrefetchHooks Function()> {
  $$PathAnnotationEntitiesTableTableManager(
      _$AppDatabase db, $PathAnnotationEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PathAnnotationEntitiesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PathAnnotationEntitiesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PathAnnotationEntitiesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> suggestDelete = const Value.absent(),
            Value<bool> isBuiltIn = const Value.absent(),
            Value<int> pathMatchType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PathAnnotationEntitiesCompanion(
            id: id,
            path: path,
            description: description,
            suggestDelete: suggestDelete,
            isBuiltIn: isBuiltIn,
            pathMatchType: pathMatchType,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String path,
            Value<String> description = const Value.absent(),
            Value<bool> suggestDelete = const Value.absent(),
            Value<bool> isBuiltIn = const Value.absent(),
            Value<int> pathMatchType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PathAnnotationEntitiesCompanion.insert(
            id: id,
            path: path,
            description: description,
            suggestDelete: suggestDelete,
            isBuiltIn: isBuiltIn,
            pathMatchType: pathMatchType,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PathAnnotationEntitiesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PathAnnotationEntitiesTable,
        PathAnnotationEntity,
        $$PathAnnotationEntitiesTableFilterComposer,
        $$PathAnnotationEntitiesTableOrderingComposer,
        $$PathAnnotationEntitiesTableAnnotationComposer,
        $$PathAnnotationEntitiesTableCreateCompanionBuilder,
        $$PathAnnotationEntitiesTableUpdateCompanionBuilder,
        (
          PathAnnotationEntity,
          BaseReferences<_$AppDatabase, $PathAnnotationEntitiesTable,
              PathAnnotationEntity>
        ),
        PathAnnotationEntity,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WhitelistEntitiesTableTableManager get whitelistEntities =>
      $$WhitelistEntitiesTableTableManager(_db, _db.whitelistEntities);
  $$RuleEntitiesTableTableManager get ruleEntities =>
      $$RuleEntitiesTableTableManager(_db, _db.ruleEntities);
  $$RuleItemEntitiesTableTableManager get ruleItemEntities =>
      $$RuleItemEntitiesTableTableManager(_db, _db.ruleItemEntities);
  $$HistoryEntitiesTableTableManager get historyEntities =>
      $$HistoryEntitiesTableTableManager(_db, _db.historyEntities);
  $$PathAnnotationEntitiesTableTableManager get pathAnnotationEntities =>
      $$PathAnnotationEntitiesTableTableManager(
          _db, _db.pathAnnotationEntities);
}
