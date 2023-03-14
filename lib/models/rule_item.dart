import 'action_type.dart';

class RuleItem {
  RuleItem({
    required this.path,
    required this.actionType,
  });

  RuleItem.fromJson(dynamic json) {
    path = json['path'];
    actionType = ActionType.values[json['actionType']];
  }

  late String path;
  late ActionType actionType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['actionType'] = actionType.index;
    return map;
  }
}
