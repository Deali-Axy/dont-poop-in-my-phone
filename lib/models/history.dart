enum ActionType { delete, deleteAndReplace }

class History {
  History({
    required this.name,
    required this.path,
    required this.time,
    required this.actionType,
  });

  History.fromJson(dynamic json) {
    name = json['name'];
    path = json['path'];
    if (json['time'] != null) {
      time = DateTime.fromMicrosecondsSinceEpoch(json['time']);
    }
    actionType = ActionType.values[json['actionType']];
  }

  late String name;
  late String path;
  late DateTime time;
  late ActionType actionType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['path'] = path;
    map['time'] = time.millisecondsSinceEpoch;
    map['actionType'] = actionType.index;
    return map;
  }
}
