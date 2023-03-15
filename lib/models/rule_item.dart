import 'index.dart';

class RuleItem {
  RuleItem({required this.path, required this.actionType, this.annotation = ''});

  RuleItem.fromJson(dynamic json) {
    path = json['path'];
    actionType = ActionType.values[json['actionType']];
  }

  late String path;
  late ActionType actionType;
  late final String annotation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['actionType'] = actionType.index;
    return map;
  }
}
