import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';

abstract class RuleDao {
  static Rule getByName(String name) {
    var rule = Rule(name: name, rules: []);
    for (var item in Global.appConfig.ruleList) {
      if (item.name == name) {
        rule = item;
        return rule;
      }
    }
    Global.appConfig.ruleList.add(rule);
    return rule;
  }

  static Rule getDefault() {
    return getByName(Rule.defaultRuleName);
  }

  static bool hasRule(String path) {
    return getDefault().rules.where((e) => e.path == path).length > 0;
  }

  static Rule add(String ruleName, RuleItem ruleItem) {
    var rule = getByName(ruleName);
    rule.rules.add(ruleItem);
    Global.saveAppConfig();

    return rule;
  }
}
