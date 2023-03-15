import 'index.dart';

class Rule {
  static const String defaultRuleName = 'default';

  Rule({
    required this.name,
    required this.rules,
  });

  Rule.fromJson(dynamic json) {
    name = json['name'];
    if (json['rules'] != null) {
      rules = [];
      json['rules'].forEach((v) {
        rules.add(RuleItem.fromJson(v));
      });
    }
  }

  late String name;
  late List<RuleItem> rules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (rules != null) {
      map['rules'] = rules.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
