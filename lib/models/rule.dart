import 'index.dart';

class Rule {
  static const String defaultRuleName = 'default';
  static const String recommendRuleName = 'recommend';
  static const String customRuleName = 'custom';

  Rule({
    this.id,
    required this.name,
    required this.rules,
    this.isSystemRule = false,
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
    isSystemRule = json['isSystemRule'] ?? false;
  }

  int? id;
  late String name;
  late List<RuleItem> rules;
  late bool isSystemRule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['name'] = name;
    if (rules != null) {
      map['rules'] = rules.map((v) => v.toJson()).toList();
    }
    map['isSystemRule'] = isSystemRule;
    return map;
  }
}
