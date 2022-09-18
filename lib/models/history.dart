class History {
  History({
    this.name,
    this.path,
    this.time,
  });

  History.fromJson(dynamic json) {
    name = json['name'];
    path = json['path'];
    if (json['time'] != null) {
      time = DateTime.fromMicrosecondsSinceEpoch(int.parse(json['time']));
    }
  }

  String name;
  String path;
  DateTime time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['path'] = path;
    map['time'] = time.millisecondsSinceEpoch;
    return map;
  }
}
