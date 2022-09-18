enum ActionType { delete, deleteAndReplace }

class History {
  History({
    this.name,
    this.path,
    this.time,
    this.actionType,
  });

  History.fromJson(dynamic json) {
    name = json['name'];
    path = json['path'];
    if (json['time'] != null) {
      time = DateTime.fromMicrosecondsSinceEpoch(json['time']);
    }
    actionType = ActionType.values[json['actionType']];
  }

  String name;
  String path;
  DateTime time;
  ActionType actionType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['path'] = path;
    map['time'] = time.millisecondsSinceEpoch;
    map['actionType'] = actionType.index;
    return map;
  }
}
