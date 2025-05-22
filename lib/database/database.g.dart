// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WhitelistsTable extends Whitelists
    with TableInfo<$WhitelistsTable, models.Whitelist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WhitelistsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'whitelists';
  @override
  VerificationContext validateIntegrity(Insertable<models.Whitelist> instance,
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
  models.Whitelist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Whitelist(
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
  $WhitelistsTable createAlias(String alias) {
    return $WhitelistsTable(attachedDatabase, alias);
  }
}

class Whitelist extends DataClass implements Insertable<models.Whitelist> {
  final int id;
  final String path;
  final String annotation;
  final bool readOnly;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Whitelist(
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

  WhitelistsCompanion toCompanion(bool nullToAbsent) {
    return WhitelistsCompanion(
      id: Value(id),
      path: Value(path),
      annotation: Value(annotation),
      readOnly: Value(readOnly),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Whitelist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Whitelist(
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

  Whitelist copyWith(
          {int? id,
          String? path,
          String? annotation,
          bool? readOnly,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Whitelist(
        id: id ?? this.id,
        path: path ?? this.path,
        annotation: annotation ?? this.annotation,
        readOnly: readOnly ?? this.readOnly,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Whitelist copyWithCompanion(WhitelistsCompanion data) {
    return Whitelist(
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
    return (StringBuffer('Whitelist(')
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
      (other is Whitelist &&
          other.id == this.id &&
          other.path == this.path &&
          other.annotation == this.annotation &&
          other.readOnly == this.readOnly &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WhitelistsCompanion extends UpdateCompanion<models.Whitelist> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> annotation;
  final Value<bool> readOnly;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WhitelistsCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.annotation = const Value.absent(),
    this.readOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WhitelistsCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    this.annotation = const Value.absent(),
    this.readOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : path = Value(path);
  static Insertable<models.Whitelist> custom({
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

  WhitelistsCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? annotation,
      Value<bool>? readOnly,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WhitelistsCompanion(
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
    return (StringBuffer('WhitelistsCompanion(')
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

class $RulesTable extends Rules with TableInfo<$RulesTable, models.Rule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(Insertable<models.Rule> instance,
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
  models.Rule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rule(
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
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }
}

class Rule extends DataClass implements Insertable<models.Rule> {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Rule(
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

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Rule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rule(
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

  Rule copyWith(
          {int? id, String? name, DateTime? createdAt, DateTime? updatedAt}) =>
      Rule(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Rule copyWithCompanion(RulesCompanion data) {
    return Rule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rule(')
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
      (other is Rule &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RulesCompanion extends UpdateCompanion<models.Rule> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<models.Rule> custom({
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

  RulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RulesCompanion(
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
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RuleItemsTable extends RuleItems
    with TableInfo<$RuleItemsTable, models.RuleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleItemsTable(this.attachedDatabase, [this._alias]);
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
          'REFERENCES rules (id) ON DELETE CASCADE'));
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
  static const String $name = 'rule_items';
  @override
  VerificationContext validateIntegrity(Insertable<models.RuleItem> instance,
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
  models.RuleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleItem(
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
  $RuleItemsTable createAlias(String alias) {
    return $RuleItemsTable(attachedDatabase, alias);
  }
}

class RuleItem extends DataClass implements Insertable<models.RuleItem> {
  final int id;
  final int ruleId;
  final String path;
  final int actionType;
  final String annotation;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RuleItem(
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

  RuleItemsCompanion toCompanion(bool nullToAbsent) {
    return RuleItemsCompanion(
      id: Value(id),
      ruleId: Value(ruleId),
      path: Value(path),
      actionType: Value(actionType),
      annotation: Value(annotation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RuleItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleItem(
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

  RuleItem copyWith(
          {int? id,
          int? ruleId,
          String? path,
          int? actionType,
          String? annotation,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RuleItem(
        id: id ?? this.id,
        ruleId: ruleId ?? this.ruleId,
        path: path ?? this.path,
        actionType: actionType ?? this.actionType,
        annotation: annotation ?? this.annotation,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RuleItem copyWithCompanion(RuleItemsCompanion data) {
    return RuleItem(
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
    return (StringBuffer('RuleItem(')
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
      (other is RuleItem &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.path == this.path &&
          other.actionType == this.actionType &&
          other.annotation == this.annotation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RuleItemsCompanion extends UpdateCompanion<models.RuleItem> {
  final Value<int> id;
  final Value<int> ruleId;
  final Value<String> path;
  final Value<int> actionType;
  final Value<String> annotation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RuleItemsCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.path = const Value.absent(),
    this.actionType = const Value.absent(),
    this.annotation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RuleItemsCompanion.insert({
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
  static Insertable<models.RuleItem> custom({
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

  RuleItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? ruleId,
      Value<String>? path,
      Value<int>? actionType,
      Value<String>? annotation,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RuleItemsCompanion(
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
    return (StringBuffer('RuleItemsCompanion(')
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

class $HistoriesTable extends Histories
    with TableInfo<$HistoriesTable, models.History> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriesTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'histories';
  @override
  VerificationContext validateIntegrity(Insertable<models.History> instance,
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
  models.History map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return History(
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
  $HistoriesTable createAlias(String alias) {
    return $HistoriesTable(attachedDatabase, alias);
  }
}

class History extends DataClass implements Insertable<models.History> {
  final int id;
  final String name;
  final String path;
  final DateTime time;
  final int actionType;
  final DateTime createdAt;
  const History(
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

  HistoriesCompanion toCompanion(bool nullToAbsent) {
    return HistoriesCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
      time: Value(time),
      actionType: Value(actionType),
      createdAt: Value(createdAt),
    );
  }

  factory History.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return History(
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

  History copyWith(
          {int? id,
          String? name,
          String? path,
          DateTime? time,
          int? actionType,
          DateTime? createdAt}) =>
      History(
        id: id ?? this.id,
        name: name ?? this.name,
        path: path ?? this.path,
        time: time ?? this.time,
        actionType: actionType ?? this.actionType,
        createdAt: createdAt ?? this.createdAt,
      );
  History copyWithCompanion(HistoriesCompanion data) {
    return History(
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
    return (StringBuffer('History(')
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
      (other is History &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path &&
          other.time == this.time &&
          other.actionType == this.actionType &&
          other.createdAt == this.createdAt);
}

class HistoriesCompanion extends UpdateCompanion<models.History> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> path;
  final Value<DateTime> time;
  final Value<int> actionType;
  final Value<DateTime> createdAt;
  const HistoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.time = const Value.absent(),
    this.actionType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistoriesCompanion.insert({
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
  static Insertable<models.History> custom({
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

  HistoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? path,
      Value<DateTime>? time,
      Value<int>? actionType,
      Value<DateTime>? createdAt}) {
    return HistoriesCompanion(
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
    return (StringBuffer('HistoriesCompanion(')
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
  late final $WhitelistsTable whitelists = $WhitelistsTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $RuleItemsTable ruleItems = $RuleItemsTable(this);
  late final $HistoriesTable histories = $HistoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [whitelists, rules, ruleItems, histories];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('rules',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('rule_items', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$WhitelistsTableCreateCompanionBuilder = WhitelistsCompanion Function({
  Value<int> id,
  required String path,
  Value<String> annotation,
  Value<bool> readOnly,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WhitelistsTableUpdateCompanionBuilder = WhitelistsCompanion Function({
  Value<int> id,
  Value<String> path,
  Value<String> annotation,
  Value<bool> readOnly,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$WhitelistsTableFilterComposer
    extends Composer<_$AppDatabase, $WhitelistsTable> {
  $$WhitelistsTableFilterComposer({
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

class $$WhitelistsTableOrderingComposer
    extends Composer<_$AppDatabase, $WhitelistsTable> {
  $$WhitelistsTableOrderingComposer({
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

class $$WhitelistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WhitelistsTable> {
  $$WhitelistsTableAnnotationComposer({
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

class $$WhitelistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WhitelistsTable,
    models.Whitelist,
    $$WhitelistsTableFilterComposer,
    $$WhitelistsTableOrderingComposer,
    $$WhitelistsTableAnnotationComposer,
    $$WhitelistsTableCreateCompanionBuilder,
    $$WhitelistsTableUpdateCompanionBuilder,
    (
      models.Whitelist,
      BaseReferences<_$AppDatabase, $WhitelistsTable, models.Whitelist>
    ),
    models.Whitelist,
    PrefetchHooks Function()> {
  $$WhitelistsTableTableManager(_$AppDatabase db, $WhitelistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WhitelistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WhitelistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WhitelistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<bool> readOnly = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WhitelistsCompanion(
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
              WhitelistsCompanion.insert(
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

typedef $$WhitelistsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WhitelistsTable,
    models.Whitelist,
    $$WhitelistsTableFilterComposer,
    $$WhitelistsTableOrderingComposer,
    $$WhitelistsTableAnnotationComposer,
    $$WhitelistsTableCreateCompanionBuilder,
    $$WhitelistsTableUpdateCompanionBuilder,
    (
      models.Whitelist,
      BaseReferences<_$AppDatabase, $WhitelistsTable, models.Whitelist>
    ),
    models.Whitelist,
    PrefetchHooks Function()>;
typedef $$RulesTableCreateCompanionBuilder = RulesCompanion Function({
  Value<int> id,
  required String name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RulesTableUpdateCompanionBuilder = RulesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$RulesTableReferences
    extends BaseReferences<_$AppDatabase, $RulesTable, models.Rule> {
  $$RulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RuleItemsTable, List<models.RuleItem>>
      _ruleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.ruleItems,
          aliasName: $_aliasNameGenerator(db.rules.id, db.ruleItems.ruleId));

  $$RuleItemsTableProcessedTableManager get ruleItemsRefs {
    final manager = $$RuleItemsTableTableManager($_db, $_db.ruleItems)
        .filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ruleItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RulesTableFilterComposer extends Composer<_$AppDatabase, $RulesTable> {
  $$RulesTableFilterComposer({
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

  Expression<bool> ruleItemsRefs(
      Expression<bool> Function($$RuleItemsTableFilterComposer f) f) {
    final $$RuleItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ruleItems,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemsTableFilterComposer(
              $db: $db,
              $table: $db.ruleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RulesTable> {
  $$RulesTableOrderingComposer({
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

class $$RulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RulesTable> {
  $$RulesTableAnnotationComposer({
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

  Expression<T> ruleItemsRefs<T extends Object>(
      Expression<T> Function($$RuleItemsTableAnnotationComposer a) f) {
    final $$RuleItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ruleItems,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RuleItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.ruleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RulesTable,
    models.Rule,
    $$RulesTableFilterComposer,
    $$RulesTableOrderingComposer,
    $$RulesTableAnnotationComposer,
    $$RulesTableCreateCompanionBuilder,
    $$RulesTableUpdateCompanionBuilder,
    (models.Rule, $$RulesTableReferences),
    models.Rule,
    PrefetchHooks Function({bool ruleItemsRefs})> {
  $$RulesTableTableManager(_$AppDatabase db, $RulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RulesCompanion(
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
              RulesCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RulesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({ruleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ruleItemsRefs) db.ruleItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ruleItemsRefs)
                    await $_getPrefetchedData<models.Rule, $RulesTable,
                            models.RuleItem>(
                        currentTable: table,
                        referencedTable:
                            $$RulesTableReferences._ruleItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RulesTableReferences(db, table, p0).ruleItemsRefs,
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

typedef $$RulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RulesTable,
    models.Rule,
    $$RulesTableFilterComposer,
    $$RulesTableOrderingComposer,
    $$RulesTableAnnotationComposer,
    $$RulesTableCreateCompanionBuilder,
    $$RulesTableUpdateCompanionBuilder,
    (models.Rule, $$RulesTableReferences),
    models.Rule,
    PrefetchHooks Function({bool ruleItemsRefs})>;
typedef $$RuleItemsTableCreateCompanionBuilder = RuleItemsCompanion Function({
  Value<int> id,
  required int ruleId,
  required String path,
  required int actionType,
  Value<String> annotation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RuleItemsTableUpdateCompanionBuilder = RuleItemsCompanion Function({
  Value<int> id,
  Value<int> ruleId,
  Value<String> path,
  Value<int> actionType,
  Value<String> annotation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$RuleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $RuleItemsTable, models.RuleItem> {
  $$RuleItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RulesTable _ruleIdTable(_$AppDatabase db) => db.rules
      .createAlias($_aliasNameGenerator(db.ruleItems.ruleId, db.rules.id));

  $$RulesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<int>('rule_id')!;

    final manager = $$RulesTableTableManager($_db, $_db.rules)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RuleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RuleItemsTable> {
  $$RuleItemsTableFilterComposer({
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

  $$RulesTableFilterComposer get ruleId {
    final $$RulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableFilterComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RuleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleItemsTable> {
  $$RuleItemsTableOrderingComposer({
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

  $$RulesTableOrderingComposer get ruleId {
    final $$RulesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableOrderingComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RuleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleItemsTable> {
  $$RuleItemsTableAnnotationComposer({
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

  $$RulesTableAnnotationComposer get ruleId {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableAnnotationComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RuleItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RuleItemsTable,
    models.RuleItem,
    $$RuleItemsTableFilterComposer,
    $$RuleItemsTableOrderingComposer,
    $$RuleItemsTableAnnotationComposer,
    $$RuleItemsTableCreateCompanionBuilder,
    $$RuleItemsTableUpdateCompanionBuilder,
    (models.RuleItem, $$RuleItemsTableReferences),
    models.RuleItem,
    PrefetchHooks Function({bool ruleId})> {
  $$RuleItemsTableTableManager(_$AppDatabase db, $RuleItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ruleId = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> actionType = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RuleItemsCompanion(
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
              RuleItemsCompanion.insert(
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
                    $$RuleItemsTableReferences(db, table, e)
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
                        $$RuleItemsTableReferences._ruleIdTable(db),
                    referencedColumn:
                        $$RuleItemsTableReferences._ruleIdTable(db).id,
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

typedef $$RuleItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RuleItemsTable,
    models.RuleItem,
    $$RuleItemsTableFilterComposer,
    $$RuleItemsTableOrderingComposer,
    $$RuleItemsTableAnnotationComposer,
    $$RuleItemsTableCreateCompanionBuilder,
    $$RuleItemsTableUpdateCompanionBuilder,
    (models.RuleItem, $$RuleItemsTableReferences),
    models.RuleItem,
    PrefetchHooks Function({bool ruleId})>;
typedef $$HistoriesTableCreateCompanionBuilder = HistoriesCompanion Function({
  Value<int> id,
  required String name,
  required String path,
  required DateTime time,
  required int actionType,
  Value<DateTime> createdAt,
});
typedef $$HistoriesTableUpdateCompanionBuilder = HistoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> path,
  Value<DateTime> time,
  Value<int> actionType,
  Value<DateTime> createdAt,
});

class $$HistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableFilterComposer({
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

class $$HistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableOrderingComposer({
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

class $$HistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableAnnotationComposer({
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

class $$HistoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistoriesTable,
    models.History,
    $$HistoriesTableFilterComposer,
    $$HistoriesTableOrderingComposer,
    $$HistoriesTableAnnotationComposer,
    $$HistoriesTableCreateCompanionBuilder,
    $$HistoriesTableUpdateCompanionBuilder,
    (
      models.History,
      BaseReferences<_$AppDatabase, $HistoriesTable, models.History>
    ),
    models.History,
    PrefetchHooks Function()> {
  $$HistoriesTableTableManager(_$AppDatabase db, $HistoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<int> actionType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HistoriesCompanion(
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
              HistoriesCompanion.insert(
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

typedef $$HistoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistoriesTable,
    models.History,
    $$HistoriesTableFilterComposer,
    $$HistoriesTableOrderingComposer,
    $$HistoriesTableAnnotationComposer,
    $$HistoriesTableCreateCompanionBuilder,
    $$HistoriesTableUpdateCompanionBuilder,
    (
      models.History,
      BaseReferences<_$AppDatabase, $HistoriesTable, models.History>
    ),
    models.History,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WhitelistsTableTableManager get whitelists =>
      $$WhitelistsTableTableManager(_db, _db.whitelists);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$RuleItemsTableTableManager get ruleItems =>
      $$RuleItemsTableTableManager(_db, _db.ruleItems);
  $$HistoriesTableTableManager get histories =>
      $$HistoriesTableTableManager(_db, _db.histories);
}
