import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/services/auto_clean_service.dart';
import 'package:dont_poop_in_my_phone/utils/file_system.dart';
import 'package:path/path.dart' as path;

/// 清理任务卡片组件
class CleanTaskCard extends StatelessWidget {
  final CleanTask task;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final bool showCheckbox;

  const CleanTaskCard({
    Key? key,
    required this.task,
    this.onTap,
    this.onToggle,
    this.showCheckbox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // 状态指示器
              _buildStatusIndicator(),
              const SizedBox(width: 12),

              // 文件信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 文件名
                    Text(
                      path.basename(task.path),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // 路径
                    Text(
                      task.path,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // 规则和大小信息
                    Row(
                      children: [
                        // 规则标签
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getRuleColor().withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _getRuleColor().withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              task.rule.path,
                              style: TextStyle(
                                color: _getRuleColor(),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // 文件大小
                        Flexible(
                          flex: 1,
                          child: Text(
                            StarFileSystem.formatFileSize(task.size.toInt()),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // 类型图标
                        Icon(
                          task.type == CleanTaskType.file ? Icons.description : Icons.folder,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),

                    // 错误信息（如果有）
                    if (task.error != null) const SizedBox(height: 4),
                    if (task.error != null)
                      Text(
                        task.error!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),

              // 复选框或操作按钮
              if (showCheckbox && onToggle != null)
                Checkbox(
                  value: task.status != CleanTaskStatus.skipped,
                  onChanged: (_) => onToggle?.call(),
                )
              else
                _buildActionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    Color color;
    IconData icon;

    switch (task.status) {
      case CleanTaskStatus.pending:
        color = Colors.orange;
        icon = Icons.schedule;
        break;
      case CleanTaskStatus.running:
        color = Colors.blue;
        icon = Icons.sync;
        break;
      case CleanTaskStatus.completed:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case CleanTaskStatus.failed:
        color = Colors.red;
        icon = Icons.error;
        break;
      case CleanTaskStatus.skipped:
        color = Colors.grey;
        icon = Icons.skip_next;
        break;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Icon(
        icon,
        size: 16,
        color: color,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    switch (task.status) {
      case CleanTaskStatus.pending:
        return IconButton(
          icon: const Icon(Icons.info_outline, size: 20),
          onPressed: () => _showTaskDetails(context),
          tooltip: '查看详情',
        );
      case CleanTaskStatus.running:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case CleanTaskStatus.completed:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      case CleanTaskStatus.failed:
        return IconButton(
          icon: const Icon(Icons.error_outline, size: 20, color: Colors.red),
          onPressed: () => _showTaskDetails(context),
          tooltip: '查看错误',
        );
      case CleanTaskStatus.skipped:
        return Icon(
          Icons.skip_next,
          color: Colors.grey,
          size: 20,
        );
    }
  }

  Color _getRuleColor() {
    // 根据规则类型返回不同颜色
    switch (task.rule.actionType.toString()) {
      case 'ActionType.delete':
        return Colors.red;
      case 'ActionType.deleteAndReplace':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(path.basename(task.path)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('路径', task.path),
              _buildDetailRow('类型', task.type == CleanTaskType.file ? '文件' : '文件夹'),
              _buildDetailRow('大小', StarFileSystem.formatFileSize(task.size.toInt())),
              _buildDetailRow('规则', task.rule.path),
              _buildDetailRow('操作', _getActionTypeText(task.rule.actionType)),
              _buildDetailRow('状态', _getStatusText(task.status)),
              if (task.error != null) _buildDetailRow('错误', task.error!, isError: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: isError ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getActionTypeText(dynamic actionType) {
    switch (actionType.toString()) {
      case 'ActionType.delete':
        return '删除';
      case 'ActionType.deleteAndReplace':
        return '删除并替换';
      default:
        return '未知';
    }
  }

  String _getStatusText(CleanTaskStatus status) {
    switch (status) {
      case CleanTaskStatus.pending:
        return '等待中';
      case CleanTaskStatus.running:
        return '执行中';
      case CleanTaskStatus.completed:
        return '已完成';
      case CleanTaskStatus.failed:
        return '失败';
      case CleanTaskStatus.skipped:
        return '已跳过';
    }
  }
}

/// 清理任务列表组件
class CleanTaskList extends StatelessWidget {
  final List<CleanTask> tasks;
  final bool showCheckbox;
  final Function(CleanTask)? onTaskToggle;
  final Function(CleanTask)? onTaskTap;

  const CleanTaskList({
    Key? key,
    required this.tasks,
    this.showCheckbox = false,
    this.onTaskToggle,
    this.onTaskTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cleaning_services_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '暂无清理任务',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return CleanTaskCard(
          task: task,
          showCheckbox: showCheckbox,
          onToggle: onTaskToggle != null ? () => onTaskToggle!(task) : null,
          onTap: onTaskTap != null ? () => onTaskTap!(task) : null,
        );
      },
    );
  }
}
