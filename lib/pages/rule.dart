import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/pages/add_rule.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';

class RulePage extends StatefulWidget {
  const RulePage({Key? key}) : super(key: key);

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  // For batch operations - to be implemented later
  // Set<int> _selectedRuleItemIds = {};
  // bool _isSelectionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('清理规则'),
        // Actions for batch operations can be added here later
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddRulePage(initialPath: '')), // Changed path to initialPath
          ).then((value) {
            if (value == true || value is String) { // Assuming AddRulePage might return true or a message on success
                setState(() {});
            }
          });
        },
        label: const Text('添加规则'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<models.Rule>>( // Changed to List<models.Rule>
      future: RuleDao.getAllRuleGroups(), // Changed to getAllRuleGroups
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.error); // For debugging
          return Empty(
            content: '加载规则失败: ${snapshot.error}',
            buttonText: '重试',
            onButtonPressed: () => setState(() {}), // Basic retry
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            content: '没有规则组',
            buttonText: '添加新规则', // Changed button text
            onButtonPressed: () {
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddRulePage(initialPath: '')), // Changed path to initialPath
              ).then((value) {
                if (value == true || value is String) setState(() {});
              });
            },
          );
        }

        final ruleGroups = snapshot.data!;
        
        bool allEmpty = ruleGroups.every((group) => group.rules.isEmpty);
        if (allEmpty) {
             return Empty(
                content: '所有规则组均为空',
                buttonText: '添加新规则',
                onButtonPressed: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddRulePage(initialPath: '')), // Changed path to initialPath
                  ).then((value) {
                    if (value == true || value is String) setState(() {});
                  });
                },
            );
        }

        return ListView.builder(
          itemCount: ruleGroups.length,
          itemBuilder: (context, groupIndex) {
            final group = ruleGroups[groupIndex];
            if (group.rules.isEmpty && !group.isSystemRule) { // Don't show empty custom groups unless they are system (which might be a placeholder)
                 // Or show a message like "Custom group is empty"
                 return SizedBox.shrink(); 
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0), // Adjusted padding
                  child: Text(
                    '${group.name.toUpperCase()} ${group.isSystemRule ? "(系统)" : "(自定义)"}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                if (group.rules.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Center(child: Text('此规则组中没有规则项', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]))),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true, // Important for nested ListViews
                    physics: NeverScrollableScrollPhysics(), // Important for nested ListViews
                    itemCount: group.rules.length,
                    itemBuilder: (context, itemIndex) {
                      final item = group.rules[itemIndex];
                      return Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.path,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: item.enabled ? null : Colors.grey),
                              ),
                              SizedBox(height: 8),
                              _buildDetailRow('类型:', item.actionType.toString().split('.').last, item.enabled),
                              _buildDetailRow('匹配:', item.pathMatchType.toString().split('.').last, item.enabled),
                              _buildDetailRow('优先级:', '${item.priority}', item.enabled),
                              _buildDetailRow('状态:', item.enabled ? '已启用' : '已禁用', item.enabled, valueColor: item.enabled ? Colors.green : Colors.orange),
                              if (item.annotation.isNotEmpty)
                                _buildDetailRow('标注:', item.annotation, item.enabled),
                              _buildDetailRow('触发:', '${item.triggerCount} 次', item.enabled),
                              _buildDetailRow('上次:', item.lastTriggeredAt?.toLocal()?.toString().substring(0, 16) ?? '-', item.enabled),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                                    icon: Icon(item.enabled ? Icons.toggle_off_outlined : Icons.toggle_on_outlined, size: 20, color: item.enabled ? Colors.orangeAccent : Colors.greenAccent),
                                    label: Text(item.enabled ? '禁用' : '启用', style: TextStyle(color: item.enabled ? Colors.orangeAccent : Colors.greenAccent)),
                                    onPressed: () => _toggleRuleItemEnabled(item),
                                  ),
                                  SizedBox(width: 8),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                                    icon: Icon(Icons.edit_outlined, size: 20),
                                    label: Text('编辑'),
                                    onPressed: () => _editRuleItem(item),
                                  ),
                                  SizedBox(width: 8),
                                  TextButton.icon(
                                     style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                                    icon: Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                                    label: Text('删除', style: TextStyle(color: Colors.redAccent)),
                                    onPressed: () => _deleteRuleItem(item),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (groupIndex < ruleGroups.length -1 && !(group.rules.isEmpty && !group.isSystemRule) ) // Add divider if not the last group and not an empty custom group
                    Divider(height: 20, thickness: 1, indent: 16, endIndent: 16),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, bool enabled, {Color? valueColor}) {
    final Color textColor = enabled ? (valueColor ?? Theme.of(context).textTheme.bodyMedium!.color!) : Colors.grey;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: TextStyle(fontWeight: FontWeight.w500, color: enabled ? null : Colors.grey)),
          Expanded(child: Text(value, style: TextStyle(color: textColor))),
        ],
      ),
    );
  }

  void _toggleRuleItemEnabled(models.RuleItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认操作'),
          content: Text('确定要${item.enabled ? "禁用" : "启用"}规则 \"${item.path}\" 吗?'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      final updatedItem = item.copyWith(enabled: !item.enabled); // Use copyWith
      await RuleDao.updateRuleItem(updatedItem);
      BotToast.showText(text: '规则状态已更新为: ${updatedItem.enabled ? "启用" : "禁用"}');
      setState(() {});
    }
  }

  void _editRuleItem(models.RuleItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddRulePage(initialPath: item.path, ruleItemToEdit: item)), // Pass item for editing
    ).then((value) {
       if (value == true) { // Check if AddRulePage indicated success (saved)
           setState(() {}); 
       }
    });
  }

  void _deleteRuleItem(models.RuleItem item) async {
     final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认删除'),
          content: Text('确定要删除规则 \"${item.path}\"?\n此操作不可撤销。'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('删除', style: TextStyle(color: Colors.red.shade700)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true && item.id != null) {
      try {
        await RuleDao.deleteRuleItem(item.id!);
        BotToast.showText(text: '规则 "${item.path}" 已删除');
        setState(() {}); 
      } catch (e) {
        BotToast.showText(text: '删除失败: $e');
      }
    } else if (confirm == true && item.id == null) {
        BotToast.showText(text: '无法删除：规则项ID为空');
    }
  }

}
