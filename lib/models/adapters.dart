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

/// 数据模型与数据库实体转换适配器
class TypeAdapters {
  static RuleItem convertToRuleItem(dynamic row) {
    return RuleItem(
      id: row.id,
      ruleId: row.ruleId,
      path: row.path,
      actionType: ActionTypeIntAdapter.fromInt(row.actionType),
      annotation: row.annotation,
    );
  }
  
  static History convertToHistory(dynamic row) {
    return History(
      name: row.name,
      path: row.path,
      time: row.time,
      actionType: ActionTypeIntAdapter.fromInt(row.actionType),
    );
  }
} 