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
        title: Text('清理规则管理'),
        actions: [
          // IconButton for batch operations can be added here later if needed
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
                builder: (context) => AddRulePage(initialPath: '')),
          )
              .then((value) {
            if (value == true) {
              setState(() {});
            }
          });
        },
        label: const Text('添加新规则'),
        icon: const Icon(Icons.add_circle_outline_rounded),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<models.Rule>>(
      future: RuleDao.getAllRuleGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Empty(
            icon: Icons.error_outline,
            content: '加载规则失败: ${snapshot.error}',
            buttonText: '重试',
            onButtonPressed: () => setState(() {}),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            icon: Icons.playlist_add_check_circle_outlined,
            content: '尚无任何规则组',
            buttonText: '去添加规则',
            onButtonPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => AddRulePage(initialPath: '')))
                  .then((value) {
                if (value == true) setState(() {});
              });
            },
          );
        }

        final ruleGroups = snapshot.data!;

        bool allEmpty = ruleGroups.every((group) => group.rules.isEmpty);
        if (allEmpty) {
          return Empty(
            icon: Icons.rule_folder_outlined,
            content: '所有规则组均为空，请添加一些规则吧！',
            buttonText: '立即添加规则',
            onButtonPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => AddRulePage(initialPath: '')))
                  .then((value) {
                if (value == true) setState(() {});
              });
            },
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 96),
          itemCount: ruleGroups.length,
          itemBuilder: (context, groupIndex) {
            final group = ruleGroups[groupIndex];
            if (group.rules.isEmpty && !group.isSystemRule) {
              return SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Text(
                    '${group.name.toUpperCase()} ${group.isSystemRule ? "(系统推荐)" : "(用户自定义)"}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                if (group.rules.isEmpty)
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('此规则组中还没有任何规则项',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700])),
                  ))
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: group.rules.length,
                    itemBuilder: (context, itemIndex) {
                      final item = group.rules[itemIndex];
                      return Card(
                        elevation: 3.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 6.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                item.enabled
                                    ? Icons.play_circle_fill_rounded
                                    : Icons.pause_circle_filled_rounded,
                                color: item.enabled
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                                size: 36,
                              ),
                              title: Text(
                                item.path,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: item.enabled
                                        ? null
                                        : Colors.grey.shade600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  _buildDetailIconRow(
                                      Icons.settings_applications_outlined,
                                      '类型',
                                      item.actionType
                                          .toString()
                                          .split('.')
                                          .last,
                                      item.enabled),
                                  _buildDetailIconRow(
                                      Icons.compare_arrows_outlined,
                                      '匹配',
                                      item.pathMatchType
                                          .toString()
                                          .split('.')
                                          .last,
                                      item.enabled),
                                ],
                              ),
                              trailing: Switch(
                                value: item.enabled,
                                onChanged: (bool value) {
                                  _toggleRuleItemEnabled(
                                      item.copyWith(enabled: value));
                                },
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 12, 12, 8),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(children: [
                                  _buildDetailIconRow(
                                      Icons.priority_high_rounded,
                                      '优先级',
                                      '${item.priority}',
                                      item.enabled),
                                  if (item.annotation.isNotEmpty)
                                    _buildDetailIconRow(Icons.comment_outlined,
                                        '标注', item.annotation, item.enabled,
                                        maxLines: 2),
                                  _buildDetailIconRow(
                                      Icons.update_outlined,
                                      '触发',
                                      '${item.triggerCount} 次',
                                      item.enabled),
                                  _buildDetailIconRow(
                                      Icons.history_toggle_off_outlined,
                                      '上次',
                                      item.lastTriggeredAt
                                              ?.toLocal()
                                              ?.toString()
                                              .substring(0, 16) ??
                                          '-',
                                      item.enabled),
                                ])),
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                    icon:
                                        Icon(Icons.edit_note_rounded, size: 20),
                                    label: Text('编辑'),
                                    onPressed: () => _editRuleItem(item),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant)),
                                TextButton.icon(
                                  icon: Icon(Icons.delete_forever_rounded,
                                      size: 20,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  label: Text('删除',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error)),
                                  onPressed: () => _deleteRuleItem(item),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          },
          separatorBuilder: (context, index) =>
              Divider(height: 25, thickness: 1, indent: 10, endIndent: 10),
        );
      },
    );
  }

  Widget _buildDetailIconRow(
      IconData icon, String label, String value, bool enabled,
      {Color? valueColor, int maxLines = 1}) {
    final Color effectiveColor = enabled
        ? (valueColor ?? Theme.of(context).textTheme.bodySmall!.color!)
        : Colors.grey.shade600;
    final Color iconColor = enabled
        ? Theme.of(context).colorScheme.secondary
        : Colors.grey.shade500;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment:
            maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: iconColor),
          SizedBox(width: 8),
          Text('$label: ',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: enabled
                      ? Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color
                          ?.withOpacity(0.7)
                      : Colors.grey.shade500,
                  fontSize: 13)),
          Expanded(
              child: Text(
            value,
            style: TextStyle(
                color: effectiveColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          )),
        ],
      ),
    );
  }

  void _toggleRuleItemEnabled(models.RuleItem item) async {
    final updatedItem = item;
    try {
      await RuleDao.updateRuleItem(updatedItem);
      BotToast.showText(
          text:
              '规则 "${updatedItem.path}" 已${updatedItem.enabled ? "启用" : "禁用"}');
      setState(() {});
    } catch (e) {
      BotToast.showText(text: '状态更新失败: $e');
      setState(() {});
    }
  }

  void _editRuleItem(models.RuleItem item) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
          builder: (context) =>
              AddRulePage(initialPath: item.path, ruleItemToEdit: item)),
    )
        .then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }

  void _deleteRuleItem(models.RuleItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Row(children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 10),
            Text('确认删除')
          ]),
          content: Text('您确定要永久删除规则 \"${item.path}\"?\n此操作无法撤销。'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('删除', style: TextStyle(color: Colors.white)),
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
