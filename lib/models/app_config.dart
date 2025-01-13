import 'index.dart';
import 'package:dont_poop_in_my_phone/utils/index.dart';

class AppConfig {
  AppConfig({
    required this.history,
  });

  AppConfig.fromJson(dynamic json) {
    history = json['history']?.map<History>((e) => History.fromJson(e))?.toList() ?? <History>[];
    whiteList = json['whiteList']?.map<Whitelist>((e) => Whitelist.fromJson(e))?.toList() ?? <Whitelist>[];
    ruleList = json['ruleList']?.map<Rule>((e) => Rule.fromJson(e))?.toList() ?? <Rule>[];
    darkMode = json['darkMode'] ?? false;
    material3 = json['material3'] ?? false;
  }

  AppConfig.fromDefault() {
    history = [];
    whiteList = StarFileSystem.PATH_WHITE_LIST.map((e) {
      return Whitelist(path: e, annotation: '[内置规则]系统/重要文件目录', readOnly: true);
    }).toList();
    ruleList = [];
  }

  late List<History> history;
  late List<Whitelist> whiteList;
  late List<Rule> ruleList;
  bool darkMode = false;
  bool material3 = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'history': history.map((e) => e.toJson()).toList(),
      'whiteList': whiteList.map((e) => e.toJson()).toList(),
      'ruleList': ruleList.map((e) => e.toJson()).toList(),
      'darkMode': darkMode,
      'material3': material3,
    };

    return map;
  }
}
