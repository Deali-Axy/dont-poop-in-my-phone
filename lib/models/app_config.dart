import 'index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';

class AppConfig {
  AppConfig({
    required this.history,
  });

  AppConfig.fromJson(dynamic json) {
    ruleList = json['history']?.map((e) => History.fromJson(e))?.toList() ?? [];
    ruleList = json['whiteList']?.map((e) => WhiteList.fromJson(e))?.toList() ?? [];
    ruleList = json['ruleList']?.map((e) => Rule.fromJson(e))?.toList() ?? [];
  }

  AppConfig.fromDefault() {
    history = [];
    whiteList = StarFileSystem.PATH_WHITE_LIST.map((e) {
      return WhiteList(path: e, annotation: '[内置规则]系统/重要文件目录', readOnly: true);
    }).toList();
    ruleList = [];
  }

  late List<History> history;
  late List<WhiteList> whiteList;
  late List<Rule> ruleList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'history': history.map((e) => e.toJson()).toList(),
      'whiteList': whiteList.map((e) => e.toJson()).toList(),
      'ruleList': ruleList.map((e) => e.toJson()).toList(),
    };

    return map;
  }
}
