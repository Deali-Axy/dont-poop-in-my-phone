import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

class RuleDao {
  static Future<models.Rule> getRuleGroupByName(String name) async {
    return await DatabaseManager.service.getRuleByName(name);
  }

  static Future<models.Rule> getSystemRecommendRules() async {
    return await DatabaseManager.service.getRuleByName(models.Rule.recommendRuleName);
  }

  static Future<models.Rule> getUserCustomRules() async {
    return await DatabaseManager.service.getRuleByName(models.Rule.customRuleName);
  }

  static Future<List<models.Rule>> getAllRuleGroups() async {
    return await DatabaseManager.service.getAllRuleGroups();
  }

  static Future<models.Rule> addRuleItemToGroup(String groupName, models.RuleItem ruleItem) async {
    return await DatabaseManager.service.addRuleItem(groupName, ruleItem);
  }

  static Future<void> updateRuleItem(models.RuleItem ruleItem) async {
    await DatabaseManager.service.updateRuleItem(ruleItem);
  }

  static Future<void> deleteRuleItem(int ruleItemId) async {
    await DatabaseManager.service.deleteRuleItem(ruleItemId);
  }

  static Future<void> deleteRuleGroup(int ruleGroupId) async {
    await DatabaseManager.service.deleteRuleGroup(ruleGroupId);
  }
  
  static Future<models.Rule> ensureRuleGroupExists(String name, {bool isSystemRule = false}) async {
    return await DatabaseManager.service.ensureRuleGroupExists(name, isSystemRule: isSystemRule );
  }

  static Future<void> updateRuleGroup(models.Rule ruleGroup) async {
    await DatabaseManager.service.updateRuleGroup(ruleGroup);
  }

  /// Checks if an exact path string is present in any enabled rule item across all groups.
  /// This might need to be more specific (e.g., check only in custom rules or based on rule type).
  static Future<bool> hasEnabledRuleForPath(String path) async {
    return await DatabaseManager.service.hasRule(path);
  }
}
