import 'index.dart';

class RuleItem {
  RuleItem({
    this.id,
    this.ruleId,
    required this.path,
    required this.actionType,
    this.annotation = ''
  });

  RuleItem.fromJson(dynamic json) {
    id = json['id'];
    ruleId = json['ruleId'];
    path = json['path'];
    actionType = ActionType.values[json['actionType']];
    annotation = json['annotation'];
  }

  int? id;
  int? ruleId;
  late String path;
  late ActionType actionType;
  late final String annotation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (ruleId != null) map['ruleId'] = ruleId;
    map['path'] = path;
    map['actionType'] = actionType.index;
    map['annotation'] = annotation;
    return map;
  }
}
