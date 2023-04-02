/// path : ""
/// annotation : ""

class Whitelist {
  Whitelist({required this.path, this.annotation = '', this.readOnly = false});

  Whitelist.fromJson(dynamic json) {
    path = json['path'];
    annotation = json['annotation'];
    readOnly = json['readOnly'];
  }

  late final String path;
  late final String annotation;
  late final bool readOnly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['annotation'] = annotation;
    map['readOnly'] = readOnly;
    return map;
  }
}
