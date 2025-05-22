import 'index.dart';
import 'path_match_type.dart';

class RuleItem {
  RuleItem({
    this.id,
    this.ruleId,
    required this.path,
    required this.pathMatchType,
    this.tags,
    this.priority = 0,
    this.enabled = true,
    this.triggerCount = 0,
    this.lastTriggeredAt,
    required this.actionType,
    this.annotation = ''
  });

  RuleItem.fromJson(dynamic json) {
    id = json['id'];
    ruleId = json['ruleId'];
    path = json['path'];
    pathMatchType = PathMatchType.values[json['pathMatchType']];
    if (json['tags'] != null) {
      tags = List<String>.from(json['tags']);
    }
    priority = json['priority'] ?? 0;
    enabled = json['enabled'] ?? true;
    triggerCount = json['triggerCount'] ?? 0;
    lastTriggeredAt = json['lastTriggeredAt'] != null
        ? DateTime.parse(json['lastTriggeredAt'])
        : null;
    actionType = ActionType.values[json['actionType']];
    annotation = json['annotation'];
  }

  int? id;
  int? ruleId;
  late String path;
  late PathMatchType pathMatchType;
  List<String>? tags;
  late int priority;
  late bool enabled;
  late int triggerCount;
  DateTime? lastTriggeredAt;
  late ActionType actionType;
  late final String annotation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (ruleId != null) map['ruleId'] = ruleId;
    map['path'] = path;
    map['pathMatchType'] = pathMatchType.index;
    if (tags != null) {
      map['tags'] = tags;
    }
    map['priority'] = priority;
    map['enabled'] = enabled;
    map['triggerCount'] = triggerCount;
    if (lastTriggeredAt != null) {
      map['lastTriggeredAt'] = lastTriggeredAt!.toIso8601String();
    }
    map['actionType'] = actionType.index;
    map['annotation'] = annotation;
    return map;
  }

  RuleItem copyWith({
    int? id,
    int? ruleId,
    String? path,
    PathMatchType? pathMatchType,
    List<String>? tags,
    int? priority,
    bool? enabled,
    int? triggerCount,
    DateTime? lastTriggeredAt,
    ActionType? actionType,
    String? annotation,
  }) {
    return RuleItem(
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
    );
  }
}
