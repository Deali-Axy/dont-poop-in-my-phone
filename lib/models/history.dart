import 'action_type.dart';
import 'history_status.dart';

class History {
  History({
    this.id,
    required this.name,
    required this.path,
    required this.time,
    required this.actionType,
    this.spaceChange,
    this.ruleId,
    this.status = HistoryStatus.success,
  });

  History.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    if (json['time'] != null) {
      time = DateTime.fromMillisecondsSinceEpoch(json['time']);
    }
    actionType = ActionType.values[json['actionType']];
    spaceChange = json['spaceChange'];
    ruleId = json['ruleId'];
    status = HistoryStatus.values[json['status'] ?? HistoryStatus.success.index];
  }

  int? id;
  late String name;
  late String path;
  late DateTime time;
  late ActionType actionType;
  int? spaceChange;
  int? ruleId;
  late HistoryStatus status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['time'] = time.millisecondsSinceEpoch;
    map['actionType'] = actionType.index;
    if (spaceChange != null) map['spaceChange'] = spaceChange;
    if (ruleId != null) map['ruleId'] = ruleId;
    map['status'] = status.index;
    return map;
  }
}
