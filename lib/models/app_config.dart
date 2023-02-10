import 'history.dart';

class AppConfig {
  AppConfig({
    required this.history,
  });

  AppConfig.fromJson(dynamic json) {
    if (json['history'] != null) {
      history = [];
      json['history'].forEach((v) {
        history.add(History.fromJson(v));
      });
    }
  }

  AppConfig.fromDefault() {
    history = [];
  }

  late List<History> history;
  late List<String> whiteList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'history': history.map((v) => v.toJson()).toList(),
    };

    return map;
  }
}
