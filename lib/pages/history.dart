import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm'); // Shorter format

  // Placeholder for filter options - to be implemented later
  // String _keywordFilter = '';
  // DateTimeRange? _dateFilter;
  // models.RuleItem? _ruleFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('清理历史记录'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_alt),
            tooltip: '筛选记录',
            onPressed: () {
              // Show filter dialog/panel - to be implemented
              BotToast.showText(text: '筛选功能待实现');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep_outlined),
            tooltip: '清空所有记录',
            onPressed: _clearAllHistory,
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<models.History>>(
      future: HistoryDao.getAll(), // Add filter parameters here later
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Empty(
            icon: Icons.error_outline_rounded,
            content: '加载历史记录失败: ${snapshot.error}',
            buttonText: '重试',
            onButtonPressed: () => setState(() {}),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            icon: Icons.history_edu_outlined,
            content: '暂无历史记录，开始一次清理吧！',
          );
        }

        final historyItems = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(10.0),
          itemCount: historyItems.length,
          itemBuilder: (context, index) {
            final item = historyItems[index];
            return Card(
              elevation: 2.5,
              margin: const EdgeInsets.symmetric(vertical: 7.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name, 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: _getStatusColor(item.status)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    _buildDetailIconRow(Icons.folder_open_outlined, '路径', item.path, item.status, maxLines:2),
                    _buildDetailIconRow(Icons.access_time_rounded, '时间', _dateFormat.format(item.time.toLocal()), item.status),
                    _buildDetailIconRow(_getActionIcon(item.actionType), '操作', item.actionType.toString().split('.').last, item.status),
                    _buildDetailIconRow(_getStatusIcon(item.status), '状态', item.status.toString().split('.').last, item.status, valueColor: _getStatusColor(item.status)),
                    if (item.spaceChange != null)
                      _buildDetailIconRow(Icons.sd_storage_outlined, '空间变化', '${_formatSpaceChange(item.spaceChange!)}', item.status),
                    if (item.ruleId != null)
                      _buildDetailIconRow(Icons.rule_folder_outlined, '关联规则ID', '${item.ruleId}', item.status), 
                    SizedBox(height: 6),
                    if (item.status == models.HistoryStatus.success || item.status == models.HistoryStatus.failed)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          icon: Icon(Icons.undo_rounded, size: 20),
                          label: Text('尝试还原'),
                           style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                            // Revert action - to be implemented
                            BotToast.showText(text: "还原操作 '${item.name}' 待实现");
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height:0), // Use card margin instead
        );
      },
    );
  }

  IconData _getActionIcon(models.ActionType actionType) {
    switch (actionType) {
      case models.ActionType.delete:
        return Icons.delete_outline_rounded;
      case models.ActionType.deleteAndReplace:
        return Icons.find_replace_outlined;
      default:
        return Icons.help_outline;
    }
  }

  IconData _getStatusIcon(models.HistoryStatus status) {
    switch (status) {
      case models.HistoryStatus.success:
        return Icons.check_circle_outline_rounded;
      case models.HistoryStatus.failed:
        return Icons.error_outline_rounded;
      case models.HistoryStatus.pending:
        return Icons.pending_outlined;
      case models.HistoryStatus.reverted:
        return Icons.history_rounded;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(models.HistoryStatus status) {
    switch (status) {
      case models.HistoryStatus.success:
        return Colors.green.shade600;
      case models.HistoryStatus.failed:
        return Colors.red.shade600;
      case models.HistoryStatus.pending:
        return Colors.orange.shade600;
      case models.HistoryStatus.reverted:
        return Colors.blueGrey.shade500;
      default:
        return Theme.of(context).textTheme.bodyMedium!.color!;
    }
  }

  String _formatSpaceChange(int bytes) {
    if (bytes == 0) return '0 B';
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = 0;
    double dBytes = bytes.toDouble();
    while (dBytes.abs() >= 1024 && i < suffixes.length - 1) {
      dBytes /= 1024;
      i++;
    }
    return '${dBytes > 0 ? '+' : ''}${dBytes.toStringAsFixed(1)} ${suffixes[i]}'; // Show +/- and 1 decimal
  }

  Widget _buildDetailIconRow(IconData icon, String label, String value, models.HistoryStatus historyStatus, {Color? valueColor, int maxLines = 1}) {
    final bool isDimmed = historyStatus == models.HistoryStatus.reverted;
    final Color defaultTextColor = Theme.of(context).textTheme.bodySmall!.color!;
    final Color currentTextColor = valueColor ?? defaultTextColor;
    final Color iconColor = isDimmed ? Colors.grey.shade500 : Theme.of(context).colorScheme.secondary;
    final Color labelColor = isDimmed ? Colors.grey.shade500 : (Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7) ?? Colors.grey);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: iconColor),
          SizedBox(width: 8),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.normal, color: labelColor, fontSize: 13)),
          Expanded(child: Text(value, style: TextStyle(color: isDimmed ? Colors.grey.shade600 : currentTextColor, fontSize: 13, fontWeight: FontWeight.w500), maxLines: maxLines, overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }

  void _clearAllHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Row(children: [Icon(Icons.delete_sweep_rounded, color: Colors.orange), SizedBox(width:10), Text('确认清空历史')]),
          content: Text('您确定要永久删除所有清理历史记录吗？\n此操作无法撤销。'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: Text('全部清空', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    if (confirm == true) {
      try {
        await HistoryDao.clearAllHistory();
        BotToast.showText(text: '所有历史记录已清空');
        setState(() {}); // Refresh list
      } catch (e) {
        BotToast.showText(text: '清空失败: $e');
      }
    }
  }
} 