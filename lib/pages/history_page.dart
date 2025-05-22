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
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

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
            onPressed: () {
              // Show filter dialog/panel - to be implemented
              BotToast.showText(text: '筛选功能待实现');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep_outlined),
            onPressed: () {
              // Clear all history confirmation - to be implemented
              _clearAllHistory();
            },
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
            content: '加载历史记录失败: ${snapshot.error}',
            buttonText: '重试',
            onButtonPressed: () => setState(() {}),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Empty(
            content: '暂无历史记录',
            // Optionally, a button to trigger a cleanup or go to rules page
          );
        }

        final historyItems = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: historyItems.length,
          itemBuilder: (context, index) {
            final item = historyItems[index];
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name, // e.g., "删除目录: .cache"
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: _getStatusColor(item.status)),
                    ),
                    SizedBox(height: 8),
                    _buildDetailRow('路径:', item.path, item.status),
                    _buildDetailRow('时间:', _dateFormat.format(item.time.toLocal()), item.status),
                    _buildDetailRow('操作:', item.actionType.toString().split('.').last, item.status),
                    _buildDetailRow('状态:', item.status.toString().split('.').last, item.status, valueColor: _getStatusColor(item.status)),
                    if (item.spaceChange != null)
                      _buildDetailRow('空间变化:', '${_formatSpaceChange(item.spaceChange!)}', item.status),
                    if (item.ruleId != null)
                      _buildDetailRow('关联规则ID:', '${item.ruleId}', item.status), // Later, fetch rule name by ID
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (item.status == models.HistoryStatus.success || item.status == models.HistoryStatus.failed)
                          TextButton.icon(
                            icon: Icon(Icons.undo_outlined, size: 20, color: Theme.of(context).colorScheme.secondary),
                            label: Text('尝试还原', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                            onPressed: () {
                              // Revert action - to be implemented
                              BotToast.showText(text: "还原操作 '${item.name}' 待实现");
                            },
                          ),
                        // Add more actions if needed, e.g., view details
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(models.HistoryStatus status) {
    switch (status) {
      case models.HistoryStatus.success:
        return Colors.green.shade700;
      case models.HistoryStatus.failed:
        return Colors.red.shade700;
      case models.HistoryStatus.pending:
        return Colors.orange.shade700;
      case models.HistoryStatus.reverted:
        return Colors.blueGrey.shade700;
      default:
        return Theme.of(context).textTheme.bodyMedium!.color!;
    }
  }

  String _formatSpaceChange(int bytes) {
    if (bytes == 0) return '0 B';
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = 0;
    double dBytes = bytes.toDouble();
    while (dBytes >= 1024 && i < suffixes.length - 1) {
      dBytes /= 1024;
      i++;
    }
    return '${dBytes.toStringAsFixed(2)} ${suffixes[i]}';
  }

  Widget _buildDetailRow(String label, String value, models.HistoryStatus status, {Color? valueColor}) {
    final bool isDimmed = status == models.HistoryStatus.reverted; // Example: dim reverted items
    final Color defaultTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final Color currentTextColor = valueColor ?? defaultTextColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: TextStyle(fontWeight: FontWeight.w500, color: isDimmed ? Colors.grey : defaultTextColor)),
          Expanded(child: Text(value, style: TextStyle(color: isDimmed ? Colors.grey : currentTextColor))),
        ],
      ),
    );
  }

  void _clearAllHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认清空历史记录'),
          content: Text('所有历史记录都将被删除，此操作不可撤销。'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('全部清空', style: TextStyle(color: Colors.red.shade700)),
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