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
      [id, path, annotation, readOnly, createdAt, updatedAt];
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
  final String annotation;
  final bool readOnly;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WhitelistEntity(
      {required this.id,
      required this.path,
      required this.annotation,
      required this.readOnly,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
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
      'annotation': serializer.toJson<String>(annotation),
      'readOnly': serializer.toJson<bool>(readOnly),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WhitelistEntity copyWith(
          {int? id,
          String? path,
          String? annotation,
          bool? readOnly,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WhitelistEntity(
        id: id ?? this.id,
        path: path ?? this.path,
        annotation: annotation ?? this.annotation,
        readOnly: readOnly ?? this.readOnly,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WhitelistEntity copyWithCompanion(WhitelistEntitiesCompanion data) {
    return WhitelistEntity(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
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
          ..write('annotation: $annotation, ')
          ..write('readOnly: $readOnly, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, path, annotation, readOnly, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WhitelistEntity &&
          other.id == this.id &&
          other.path == this.path &&
          other.annotation == this.annotation &&
          other.readOnly == this.readOnly &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WhitelistEntitiesCompanion extends UpdateCompanion<WhitelistEntity> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> annotation;
  final Value<bool> readOnly;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WhitelistEntitiesCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.annotation = const Value.absent(),
    this.readOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WhitelistEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    this.annotation = const Value.absent(),
    this.readOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : path = Value(path);
  static Insertable<WhitelistEntity> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? annotation,
    Expression<bool>? readOnly,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (annotation != null) 'annotation': annotation,
      if (readOnly != null) 'read_only': readOnly,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WhitelistEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? annotation,
      Value<bool>? readOnly,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WhitelistEntitiesCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
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
  final DateTime createdAt;
  final DateTime updatedAt;
  const RuleEntity(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RuleEntitiesCompanion toCompanion(bool nullToAbsent) {
    return RuleEntitiesCompanion(
      id: Value(id),
      name: Value(name),
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RuleEntity copyWith(
          {int? id, String? name, DateTime? createdAt, DateTime? updatedAt}) =>
      RuleEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RuleEntity copyWithCompanion(RuleEntitiesCompanion data) {
    return RuleEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RuleEntitiesCompanion extends UpdateCompanion<RuleEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RuleEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RuleEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<RuleEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RuleEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RuleEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
  List<GeneratedColumn> get $columns =>
      [id, ruleId, path, actionType, annotation, createdAt, updatedAt];
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
  final int actionType;
  final String annotation;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RuleItemEntity(
      {required this.id,
      required this.ruleId,
      required this.path,
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
          int? actionType,
          String? annotation,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RuleItemEntity(
        id: id ?? this.id,
        ruleId: ruleId ?? this.ruleId,
        path: path ?? this.path,
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
          ..write('actionType: $actionType, ')
          ..write('annotation: $annotation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, ruleId, path, actionType, annotation, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleItemEntity &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.path == this.path &&
          other.actionType == this.actionType &&
          other.annotation == this.annotation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RuleItemEntitiesCompanion extends UpdateCompanion<RuleItemEntity> {
  final Value<int> id;
  final Value<int> ruleId;
  final Value<String> path;
  final Value<int> actionType;
  final Value<String> annotation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RuleItemEntitiesCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.path = const Value.absent(),
    this.actionType = const Value.absent(),
    this.annotation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RuleItemEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required int ruleId,
    required String path,
    required int actionType,
    this.annotation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : ruleId = Value(ruleId),
        path = Value(path),
        actionType = Value(actionType);
  static Insertable<RuleItemEntity> custom({
    Expression<int>? id,
    Expression<int>? ruleId,
    Expression<String>? path,
    Expression<int>? actionType,
    Expression<String>? annotation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (path != null) 'path': path,
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
      Value<int>? actionType,
      Value<String>? annotation,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RuleItemEntitiesCompanion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      path: path ?? this.path,
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, path, time, actionType, createdAt];
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
  final DateTime createdAt;
  const HistoryEntity(
      {required this.id,
      required this.name,
      required this.path,
      required this.time,
      required this.actionType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['time'] = Variable<DateTime>(time);
    map['action_type'] = Variable<int>(actionType);
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HistoryEntity copyWith(
          {int? id,
          String? name,
          String? path,
          DateTime? time,
          int? actionType,
          DateTime? createdAt}) =>
      HistoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        path: path ?? this.path,
        time: time ?? this.time,
        actionType: actionType ?? this.actionType,
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
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, path, time, actionType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path &&
          other.time == this.time &&
          other.actionType == this.actionType &&
          other.createdAt == this.createdAt);
}

class HistoryEntitiesCompanion extends UpdateCompanion<HistoryEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> path;
  final Value<DateTime> time;
  final Value<int> actionType;
  final Value<DateTime> createdAt;
  const HistoryEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.time = const Value.absent(),
    this.actionType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistoryEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
    required DateTime time,
    required int actionType,
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
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (time != null) 'time': time,
      if (actionType != null) 'action_type': actionType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HistoryEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? path,
      Value<DateTime>? time,
      Value<int>? actionType,
      Value<DateTime>? createdAt}) {
    return HistoryEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      time: time ?? this.time,
      actionType: actionType ?? this.actionType,
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
          ..write('createdAt: $createdAt')
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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [whitelistEntities, ruleEntities, ruleItemEntities, historyEntities];
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
        ],
      );
}

typedef $$WhitelistEntitiesTableCreateCompanionBuilder
    = WhitelistEntitiesCompanion Function({
  Value<int> id,
  required String path,
  Value<String> annotation,
  Value<bool> readOnly,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WhitelistEntitiesTableUpdateCompanionBuilder
    = WhitelistEntitiesCompanion Function({
  Value<int> id,
  Value<String> path,
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
            Value<String> annotation = const Value.absent(),
            Value<bool> readOnly = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhitelistEntitiesCompanion(
            id: id,
            path: path,
            annotation: annotation,
            readOnly: readOnly,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String path,
            Value<String> annotation = const Value.absent(),
            Value<bool> readOnly = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhitelistEntitiesCompanion.insert(
            id: id,
            path: path,
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RuleEntitiesTableUpdateCompanionBuilder = RuleEntitiesCompanion
    Function({
  Value<int> id,
  Value<String> name,
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleEntitiesCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleEntitiesCompanion.insert(
            id: id,
            name: name,
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
    PrefetchHooks Function({bool ruleId})> {
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
            Value<int> actionType = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleItemEntitiesCompanion(
            id: id,
            ruleId: ruleId,
            path: path,
            actionType: actionType,
            annotation: annotation,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ruleId,
            required String path,
            required int actionType,
            Value<String> annotation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleItemEntitiesCompanion.insert(
            id: id,
            ruleId: ruleId,
            path: path,
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
                        $$RuleItemEntitiesTableReferences._ruleIdTable(db),
                    referencedColumn:
                        $$RuleItemEntitiesTableReferences._ruleIdTable(db).id,
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
    PrefetchHooks Function({bool ruleId})>;
typedef $$HistoryEntitiesTableCreateCompanionBuilder = HistoryEntitiesCompanion
    Function({
  Value<int> id,
  required String name,
  required String path,
  required DateTime time,
  required int actionType,
  Value<DateTime> createdAt,
});
typedef $$HistoryEntitiesTableUpdateCompanionBuilder = HistoryEntitiesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> path,
  Value<DateTime> time,
  Value<int> actionType,
  Value<DateTime> createdAt,
});

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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
    (
      HistoryEntity,
      BaseReferences<_$AppDatabase, $HistoryEntitiesTable, HistoryEntity>
    ),
    HistoryEntity,
    PrefetchHooks Function()> {
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
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HistoryEntitiesCompanion(
            id: id,
            name: name,
            path: path,
            time: time,
            actionType: actionType,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String path,
            required DateTime time,
            required int actionType,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HistoryEntitiesCompanion.insert(
            id: id,
            name: name,
            path: path,
            time: time,
            actionType: actionType,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      HistoryEntity,
      BaseReferences<_$AppDatabase, $HistoryEntitiesTable, HistoryEntity>
    ),
    HistoryEntity,
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
}
