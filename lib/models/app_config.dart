import 'package:dont_poop_in_my_phone/models/rule.dart';

import 'history.dart';

class AppConfig {
  AppConfig({
    required this.history,
  });

  AppConfig.fromJson(dynamic json) {
    if (json['history'] != null) {
      history = [];
      json['history'].forEach((v) => history.add(History.fromJson(v)));
    }
    if (json['whiteList'] != null) {
      whiteList = [];
      json['whiteList'].forEach((v) => whiteList.add(v.toString()));
    }
    if (json['ruleList'] != null) {
      ruleList = [];
      json['ruleList'].forEach((v) => ruleList.add(Rule.fromJson(v)));
    }
  }

  AppConfig.fromDefault() {
    history = [];
    whiteList = [];
    ruleList = [];
  }

  late List<History> history;
  late List<String> whiteList;
  late List<Rule> ruleList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'history': history.map((v) => v.toJson()).toList(),
      'whiteList': whiteList,
      'ruleList': ruleList.map((e) => e.toJson()).toList(),
    };

    return map;
  }
}
