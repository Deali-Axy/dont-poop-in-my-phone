import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/utils/file_system.dart';
import 'package:path/path.dart' as path;

/// 清理规则服务
class CleanRuleService {
  /// 创建推荐的系统清理规则
  static Future<void> createRecommendedRules() async {
    final recommendGroup = await RuleDao.ensureRuleGroupExists(
      models.Rule.recommendRuleName, 
      isSystemRule: true
    );
    
    // 检查是否已经有推荐规则
    if (recommendGroup.rules.isNotEmpty) {
      return;
    }
    
    // 创建推荐的清理规则
    final recommendedRules = [
      // 临时文件清理
      models.RuleItem(
        path: '/storage/emulated/0/android/data/*/cache',
        pathMatchType: models.PathMatchType.regex,
        actionType: models.ActionType.delete,
        priority: 10,
        annotation: '清理应用缓存文件',
      ),
      
      // 日志文件清理
      models.RuleItem(
        path: '.log',
        pathMatchType: models.PathMatchType.suffix,
        actionType: models.ActionType.delete,
        priority: 8,
        annotation: '清理日志文件',
      ),
      
      // 临时下载文件
      models.RuleItem(
        path: '/storage/emulated/0/download/.*\.tmp',
        pathMatchType: models.PathMatchType.regex,
        actionType: models.ActionType.delete,
        priority: 7,
        annotation: '清理临时下载文件',
      ),
      
      // 缩略图缓存
      models.RuleItem(
        path: '/storage/emulated/0/dcim/.thumbnails',
        pathMatchType: models.PathMatchType.exact,
        actionType: models.ActionType.delete,
        priority: 6,
        annotation: '清理缩略图缓存',
      ),
      
      // 空文件夹清理
      models.RuleItem(
        path: '/storage/emulated/0/.*empty.*',
        pathMatchType: models.PathMatchType.regex,
        actionType: models.ActionType.delete,
        priority: 5,
        annotation: '清理空文件夹',
      ),
    ];
    
    // 添加推荐规则
    for (final rule in recommendedRules) {
      await RuleDao.addRuleItemToGroup(models.Rule.recommendRuleName, rule);
    }
  }
  
  /// 验证规则的有效性
  static bool validateRule(models.RuleItem rule) {
    // 检查路径是否为空
    if (rule.path.trim().isEmpty) {
      return false;
    }
    
    // 检查正则表达式的有效性
    if (rule.pathMatchType == models.PathMatchType.regex) {
      try {
        RegExp(rule.path);
      } catch (e) {
        return false;
      }
    }
    
    // 检查路径是否在系统关键目录中
    final criticalPaths = [
      '/system',
      '/data/system',
      '/proc',
      '/dev',
      '/sys',
    ];
    
    for (final criticalPath in criticalPaths) {
      if (rule.path.toLowerCase().startsWith(criticalPath)) {
        return false;
      }
    }
    
    return true;
  }
  
  /// 获取规则的风险等级
  static RiskLevel getRuleRiskLevel(models.RuleItem rule) {
    // 高风险路径
    final highRiskPatterns = [
      '/storage/emulated/0/android/data',
      '/storage/emulated/0/android/obb',
      '/storage/emulated/0/pictures',
      '/storage/emulated/0/dcim',
      '/storage/emulated/0/music',
      '/storage/emulated/0/movies',
      '/storage/emulated/0/documents',
    ];
    
    // 中风险路径
    final mediumRiskPatterns = [
      '/storage/emulated/0/download',
      '/storage/emulated/0/tencent',
      'cache',
      'temp',
      'tmp',
    ];
    
    final rulePath = rule.path.toLowerCase();
    
    // 检查高风险
    for (final pattern in highRiskPatterns) {
      if (rulePath.contains(pattern)) {
        return RiskLevel.high;
      }
    }
    
    // 检查中风险
    for (final pattern in mediumRiskPatterns) {
      if (rulePath.contains(pattern)) {
        return RiskLevel.medium;
      }
    }
    
    return RiskLevel.low;
  }
  
  /// 获取规则的描述信息
  static String getRuleDescription(models.RuleItem rule) {
    final actionText = rule.actionType == models.ActionType.deleteAndReplace 
        ? '删除并替换为空文件' 
        : '完全删除';
    
    final matchTypeText = _getMatchTypeDescription(rule.pathMatchType);
    
    return '$matchTypeText "${rule.path}" 的文件/目录，执行$actionText操作';
  }
  
  static String _getMatchTypeDescription(models.PathMatchType matchType) {
    switch (matchType) {
      case models.PathMatchType.exact:
        return '精确匹配';
      case models.PathMatchType.prefix:
        return '前缀匹配';
      case models.PathMatchType.suffix:
        return '后缀匹配';
      case models.PathMatchType.fuzzy:
        return '模糊匹配';
      case models.PathMatchType.regex:
        return '正则匹配';
    }
  }
  
  /// 检查规则冲突
  static Future<List<RuleConflict>> checkRuleConflicts(models.RuleItem newRule) async {
    final conflicts = <RuleConflict>[];
    
    // 获取所有现有规则
    final allGroups = await RuleDao.getAllRuleGroups();
    final existingRules = <models.RuleItem>[];
    
    for (final group in allGroups) {
      existingRules.addAll(group.rules);
    }
    
    // 检查路径冲突
    for (final existingRule in existingRules) {
      if (existingRule.id == newRule.id) continue; // 跳过自己
      
      final conflictType = _checkPathConflict(newRule, existingRule);
      if (conflictType != ConflictType.none) {
        conflicts.add(RuleConflict(
          conflictingRule: existingRule,
          conflictType: conflictType,
          description: _getConflictDescription(conflictType, newRule, existingRule),
        ));
      }
    }
    
    return conflicts;
  }
  
  static ConflictType _checkPathConflict(models.RuleItem rule1, models.RuleItem rule2) {
    final path1 = rule1.path.toLowerCase();
    final path2 = rule2.path.toLowerCase();
    
    // 完全相同的路径
    if (path1 == path2) {
      return ConflictType.duplicate;
    }
    
    // 检查包含关系
    if (path1.contains(path2) || path2.contains(path1)) {
      return ConflictType.overlap;
    }
    
    // 检查正则表达式冲突
    if (rule1.pathMatchType == models.PathMatchType.regex || 
        rule2.pathMatchType == models.PathMatchType.regex) {
      // 简化的正则冲突检查
      try {
        if (rule1.pathMatchType == models.PathMatchType.regex) {
          final regex1 = RegExp(path1);
          if (regex1.hasMatch(path2)) {
            return ConflictType.regexOverlap;
          }
        }
        if (rule2.pathMatchType == models.PathMatchType.regex) {
          final regex2 = RegExp(path2);
          if (regex2.hasMatch(path1)) {
            return ConflictType.regexOverlap;
          }
        }
      } catch (e) {
        // 忽略正则表达式错误
      }
    }
    
    return ConflictType.none;
  }
  
  static String _getConflictDescription(ConflictType type, models.RuleItem rule1, models.RuleItem rule2) {
    switch (type) {
      case ConflictType.duplicate:
        return '与现有规则路径完全相同';
      case ConflictType.overlap:
        return '与现有规则路径存在包含关系';
      case ConflictType.regexOverlap:
        return '正则表达式可能匹配相同的路径';
      case ConflictType.none:
        return '';
    }
  }
}

/// 风险等级
enum RiskLevel {
  low,    // 低风险
  medium, // 中风险
  high,   // 高风险
}

/// 冲突类型
enum ConflictType {
  none,         // 无冲突
  duplicate,    // 重复规则
  overlap,      // 路径重叠
  regexOverlap, // 正则重叠
}

/// 规则冲突信息
class RuleConflict {
  final models.RuleItem conflictingRule;
  final ConflictType conflictType;
  final String description;
  
  RuleConflict({
    required this.conflictingRule,
    required this.conflictType,
    required this.description,
  });
}