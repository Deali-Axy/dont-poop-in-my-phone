import 'history.dart';

class AppConfig {
  AppConfig({
    this.history,
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

  List<History> history;
  List<String> whiteList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (history != null) {
      map['history'] = history.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
