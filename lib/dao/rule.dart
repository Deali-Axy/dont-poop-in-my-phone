import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

abstract class RuleDao {
  static Future<Rule> getByName(String name) async {
    return await DatabaseManager.database.getRuleByName(name);
  }

  static Future<Rule> getDefault() async {
    return await getByName(Rule.defaultRuleName);
  }

  static Future<bool> hasRule(String path) async {
    return await DatabaseManager.database.hasRule(path);
  }

  static Future<Rule> add(String ruleName, RuleItem ruleItem) async {
    return await DatabaseManager.database.addRuleItem(ruleName, ruleItem);
  }
}
