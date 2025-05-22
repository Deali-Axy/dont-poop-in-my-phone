import 'index.dart';

class Rule {
  static const String defaultRuleName = 'default';

  Rule({
    this.id,
    required this.name,
    required this.rules,
  });

  Rule.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['rules'] != null) {
      rules = [];
      json['rules'].forEach((v) {
        rules.add(RuleItem.fromJson(v));
      });
    }
  }

  int? id;
  late String name;
  late List<RuleItem> rules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['name'] = name;
    if (rules != null) {
      map['rules'] = rules.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
