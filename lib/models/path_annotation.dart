import 'path_match_type.dart';

/// 路径标注模型
class PathAnnotation {
  PathAnnotation({
    this.id,
    required this.path,
    this.description = '',
    this.suggestDelete = false,
    this.isBuiltIn = false,
    this.pathMatchType = PathMatchType.exact,
    this.createdAt,
    this.updatedAt,
  });

  PathAnnotation.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
    description = json['description'];
    suggestDelete = json['suggestDelete'];
    isBuiltIn = json['isBuiltIn'];
    pathMatchType = PathMatchType.values[json['pathMatchType'] ?? PathMatchType.exact.index];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
  }

  int? id;
  late final String path;
  late String description;
  late bool suggestDelete;
  late bool isBuiltIn;
  late PathMatchType pathMatchType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['path'] = path;
    map['description'] = description;
    map['suggestDelete'] = suggestDelete;
    map['isBuiltIn'] = isBuiltIn;
    map['pathMatchType'] = pathMatchType.index;
    if (createdAt != null) map['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) map['updatedAt'] = updatedAt!.toIso8601String();
    return map;
  }

  PathAnnotation copyWith({
    int? id,
    String? path,
    String? description,
    bool? suggestDelete,
    bool? isBuiltIn,
    PathMatchType? pathMatchType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PathAnnotation(
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
} 