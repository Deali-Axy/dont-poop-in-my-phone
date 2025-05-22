/// path : ""
/// annotation : ""

import 'whitelist_type.dart';

class Whitelist {
  Whitelist({
    this.id,
    required this.path,
    this.type = WhitelistType.path,
    this.annotation = '',
    this.readOnly = false,
    this.createdAt,
    this.updatedAt,
  });

  Whitelist.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
    type = WhitelistType.values[json['type'] ?? WhitelistType.path.index];
    annotation = json['annotation'];
    readOnly = json['readOnly'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
  }

  int? id;
  late final String path;
  late WhitelistType type;
  late final String annotation;
  late final bool readOnly;
  DateTime? createdAt;
  DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['path'] = path;
    map['type'] = type.index;
    map['annotation'] = annotation;
    map['readOnly'] = readOnly;
    if (createdAt != null) map['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) map['updatedAt'] = updatedAt!.toIso8601String();
    return map;
  }

  Whitelist copyWith({
    int? id,
    String? path,
    WhitelistType? type,
    String? annotation,
    bool? readOnly,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Whitelist(
      id: id ?? this.id,
      path: path ?? this.path,
      type: type ?? this.type,
      annotation: annotation ?? this.annotation,
      readOnly: readOnly ?? this.readOnly,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
