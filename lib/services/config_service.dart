/// 配置管理服务
/// 负责管理应用的各种配置，包括默认配置的初始化和更新

import '../models/index.dart';
import '../dao/index.dart';
import '../common/default_configs.dart';
import '../utils/index.dart';

class ConfigService {
  static const String _configVersionKey = 'config_version';
  static const int _currentConfigVersion = 1;

  /// 检查并更新配置
  /// 当配置版本更新时，会重新初始化默认数据
  static Future<void> checkAndUpdateConfigs() async {
    // 这里可以添加版本检查逻辑
    // 如果需要更新配置，可以调用相应的更新方法
  }

  /// 重新初始化白名单配置
  static Future<void> reinitializeWhitelist() async {
    try {
      // 获取现有的扩展白名单
      final existingWhitelists = await WhitelistDao.getAll();
      final existingPaths = existingWhitelists.map((w) => w.path).toSet();
      
      // 添加新的扩展白名单项
      for (final whitelist in DefaultConfigs.getExtendedWhitelistItems()) {
        if (!existingPaths.contains(whitelist.path)) {
          await WhitelistDao.add(whitelist);
        }
      }
    } catch (e) {
      print('重新初始化白名单失败: $e');
    }
  }

  /// 重新初始化清理规则
  static Future<void> reinitializeCleanRules() async {
    try {
      final recommendRuleGroup = await RuleDao.getSystemRecommendRules();
      final existingRulePaths = recommendRuleGroup.rules.map((r) => r.path).toSet();
      
      // 添加新的清理规则
      for (final ruleItem in DefaultConfigs.getDefaultCleanRules()) {
        if (!existingRulePaths.contains(ruleItem.path)) {
          await RuleDao.addRuleItemToGroup(Rule.recommendRuleName, ruleItem);
        }
      }
    } catch (e) {
      print('重新初始化清理规则失败: $e');
    }
  }

  /// 重新初始化路径标注
  static Future<void> reinitializePathAnnotations() async {
    try {
      final existingAnnotations = await PathAnnotationDao.getAll();
      final existingPaths = existingAnnotations.map((a) => a.path).toSet();
      
      // 添加新的路径标注
      for (final annotation in DefaultConfigs.getDefaultPathAnnotations()) {
        if (!existingPaths.contains(annotation.path)) {
          await PathAnnotationDao.add(annotation);
        }
      }
    } catch (e) {
      print('重新初始化路径标注失败: $e');
    }
  }

  /// 获取配置统计信息
  static Future<Map<String, int>> getConfigStats() async {
    try {
      final whitelists = await WhitelistDao.getAll();
      final rules = await RuleDao.getSystemRecommendRules();
      final annotations = await PathAnnotationDao.getAll();
      
      return {
        'whitelist_count': whitelists.length,
        'rule_count': rules.rules.length,
        'annotation_count': annotations.length,
        'builtin_whitelist_count': whitelists.where((w) => w.readOnly).length,
        'builtin_annotation_count': annotations.where((a) => a.isBuiltIn).length,
      };
    } catch (e) {
      print('获取配置统计失败: $e');
      return {};
    }
  }

  /// 导出当前配置
  static Future<Map<String, dynamic>> exportConfigs() async {
    try {
      final whitelists = await WhitelistDao.getAll();
      final rules = await RuleDao.getAllRuleGroups();
      final annotations = await PathAnnotationDao.getAll();
      
      return {
        'version': _currentConfigVersion,
        'export_time': DateTime.now().toIso8601String(),
        'whitelists': whitelists.map((w) => w.toJson()).toList(),
        'rules': rules.map((r) => r.toJson()).toList(),
        'annotations': annotations.map((a) => a.toJson()).toList(),
      };
    } catch (e) {
      print('导出配置失败: $e');
      return {};
    }
  }

  /// 导入配置
  static Future<bool> importConfigs(Map<String, dynamic> configData) async {
    try {
      // 这里可以添加配置导入逻辑
      // 需要谨慎处理，避免覆盖用户的自定义配置
      
      // 示例：只导入用户自定义的规则和白名单
      if (configData.containsKey('whitelists')) {
        final whitelistsData = configData['whitelists'] as List;
        for (final data in whitelistsData) {
          final whitelist = Whitelist.fromJson(data);
          if (!whitelist.readOnly) { // 只导入非只读的白名单
            await WhitelistDao.add(whitelist);
          }
        }
      }
      
      return true;
    } catch (e) {
      print('导入配置失败: $e');
      return false;
    }
  }

  /// 重置为默认配置
  static Future<bool> resetToDefaults() async {
    try {
      // 注意：这个操作会清除所有用户自定义的配置
      // 在实际使用时需要提醒用户确认
      
      await reinitializeWhitelist();
      await reinitializeCleanRules();
      await reinitializePathAnnotations();
      
      return true;
    } catch (e) {
      print('重置配置失败: $e');
      return false;
    }
  }

  /// 获取推荐的清理路径
  static Future<List<String>> getRecommendedCleanPaths() async {
    try {
      final rules = await RuleDao.getSystemRecommendRules();
      return rules.rules
          .where((rule) => rule.enabled)
          .map((rule) => rule.path)
          .toList();
    } catch (e) {
      print('获取推荐清理路径失败: $e');
      return [];
    }
  }

  /// 获取受保护的路径
  static Future<List<String>> getProtectedPaths() async {
    try {
      final whitelists = await WhitelistDao.getAll();
      return whitelists.map((w) => w.path).toList();
    } catch (e) {
      print('获取受保护路径失败: $e');
      return [];
    }
  }
}