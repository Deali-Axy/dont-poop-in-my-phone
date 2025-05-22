import 'dart:convert'; // 新增导入 for json
import 'index.dart';

/// 提供ActionType与int之间的类型转换
extension ActionTypeIntAdapter on ActionType {
  int toInt() {
    return index;
  }
  
  static ActionType fromInt(int value) {
    return ActionType.values[value];
  }
}

/// 新增 PathMatchType 与 int 之间的类型转换
extension PathMatchTypeIntAdapter on PathMatchType {
  int toInt() {
    return index;
  }

  static PathMatchType fromInt(int value) {
    return PathMatchType.values[value];
  }
}

/// 数据模型与数据库实体转换适配器
class TypeAdapters {
  static RuleItem convertToRuleItem(dynamic row) {
    List<String>? tags;
    if (row.tags != null && (row.tags as String).isNotEmpty) {
      try {
        tags = List<String>.from(jsonDecode(row.tags));
      } catch (e) {
        // Log error or handle corrupted data
        print('Error decoding tags: $e');
        tags = null;
      }
    }

    return RuleItem(
      id: row.id,
      ruleId: row.ruleId,
      path: row.path,
      pathMatchType: PathMatchTypeIntAdapter.fromInt(row.pathMatchType),
      tags: tags,
      priority: row.priority,
      enabled: row.enabled,
      triggerCount: row.triggerCount,
      lastTriggeredAt: row.lastTriggeredAt,
      actionType: ActionTypeIntAdapter.fromInt(row.actionType),
      annotation: row.annotation,
    );
  }
  
  static History convertToHistory(dynamic row) {
    return History(
      id: row.id,
      name: row.name,
      path: row.path,
      time: row.time,
      actionType: ActionTypeIntAdapter.fromInt(row.actionType),
      spaceChange: row.spaceChange,
      ruleId: row.ruleId,
      status: HistoryStatus.values[row.status],
    );
  }
} 