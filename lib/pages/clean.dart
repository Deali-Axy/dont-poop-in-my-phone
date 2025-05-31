import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/services/auto_clean_service.dart';
import 'package:dont_poop_in_my_phone/services/clean_config_manager.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/utils/file_system.dart';
import 'package:dont_poop_in_my_phone/widgets/clean_settings_widget.dart';
import 'package:dont_poop_in_my_phone/widgets/clean_task_card.dart';
import 'package:dont_poop_in_my_phone/widgets/star_text_button.dart';

class CleanPage extends StatefulWidget {
  const CleanPage({Key? key}) : super(key: key);

  @override
  _CleanPageState createState() => _CleanPageState();
}

class _CleanPageState extends State<CleanPage> {
  final AutoCleanService _cleanService = AutoCleanService();
  CleanStatistics _statistics = CleanStatistics();
  List<CleanTask> _scanResults = [];
  bool _isScanning = false;
  bool _isCleaning = false;
  double _progress = 0.0;
  CleanConfig? _config;
  
  @override
  void initState() {
    super.initState();
    _loadConfig();
    _loadStatistics();
  }
  
  Future<void> _loadConfig() async {
    final config = await _cleanService.getConfig();
    setState(() {
      _config = config;
    });
  }
  
  Future<void> _loadStatistics() async {
    final totalFiles = await CleanConfigManager.getTotalCleanedFiles();
    final totalSpace = await CleanConfigManager.getTotalSavedSpace();
    final lastCleanTime = await CleanConfigManager.getLastCleanTime();
    
    setState(() {
      _statistics = CleanStatistics(
        completedTasks: totalFiles,
        totalSizeFreed: totalSpace,
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自动清理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showCleanSettings,
            tooltip: '清理设置',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatisticsCard(),
          const SizedBox(height: 16),
          _buildActionButtons(),
          const SizedBox(height: 16),
          Expanded(child: _buildResultsList()),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '清理统计',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '扫描文件',
                    '${_statistics.scannedFiles}',
                    Icons.search,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '可清理',
                    '${_statistics.cleanableFiles}',
                    Icons.cleaning_services,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '已清理',
                    '${_statistics.cleanedFiles}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '节省空间',
                    _statistics.savedSpaceText,
                    Icons.storage,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: _isScanning || _isCleaning ? null : _startScan,
            icon: _isScanning
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.search),
            label: Text(_isScanning ? '扫描中...' : '开始扫描'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.icon(
            onPressed: _scanResults.isEmpty || _isCleaning || _isScanning
                ? null
                : _startClean,
            icon: _isCleaning
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.cleaning_services),
            label: Text(_isCleaning ? '清理中...' : '开始清理'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsList() {
    if (_scanResults.isEmpty) {
      return Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cleaning_services_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  '点击"开始扫描"来查找可清理的文件',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '扫描结果',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '共 ${_scanResults.length} 项',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: CleanTaskList(
              tasks: _scanResults,
              showCheckbox: false,
              onTaskTap: (task) {
                // 可以在这里添加任务详情查看逻辑
              },
            ),
          ),
        ],
      ),
    );
  }



  Future<void> _startScan() async {
    if (_isScanning) return;
    
    setState(() {
      _isScanning = true;
      _scanResults.clear();
      _statistics = CleanStatistics();
      _progress = 0.0;
    });
    
    try {
      BotToast.showText(text: '开始扫描可清理文件...');
      
      final results = await _cleanService.scanForCleanablePaths();
      
      setState(() {
        _scanResults = results;
        _statistics = CleanStatistics(
          totalTasks: results.length,
          totalSizeFreed: results.fold(0, (sum, task) => sum + task.size),
        );
        _progress = 1.0;
      });
      
      if (results.isEmpty) {
        BotToast.showText(text: '未发现需要清理的文件');
      } else {
        final totalSize = results.fold(0, (sum, task) => sum + task.size);
        BotToast.showText(
          text: '扫描完成，发现 ${results.length} 个可清理项目，'
                '可节省 ${StarFileSystem.formatFileSize(totalSize)} 空间'
        );
      }
    } catch (e) {
      BotToast.showText(text: '扫描失败: $e');
      print('扫描错误: $e');
    } finally {
      setState(() {
        _isScanning = false;
        _progress = 0.0;
      });
    }
  }

  Future<void> _startClean() async {
    if (_isCleaning || _scanResults.isEmpty) return;
    
    final config = _config ?? await _cleanService.getConfig();
    
    // 如果配置要求确认，显示确认对话框
    if (config.confirmBeforeClean) {
      final confirmed = await _showCleanConfirmDialog();
      if (!confirmed) return;
    }
    
    setState(() {
      _isCleaning = true;
      _progress = 0.0;
    });
    
    try {
      BotToast.showText(text: '开始清理文件...');
      
      final statistics = await _cleanService.executeBatchClean(
        _scanResults,
        onProgress: (completed, total) {
          setState(() {
            _progress = completed / total;
          });
        },
        onTaskCompleted: (task) {
          // 可以在这里更新UI显示单个任务的完成状态
          setState(() {
            // 更新对应任务的状态
            final index = _scanResults.indexWhere((t) => t.path == task.path);
            if (index != -1) {
              _scanResults[index] = task;
            }
          });
        },
      );
      
      setState(() {
        _statistics = statistics;
      });
      
      // 重新加载统计信息
      await _loadStatistics();
      
      BotToast.showText(
        text: '清理完成！\n'
              '成功: ${statistics.completedTasks}\n'
              '失败: ${statistics.failedTasks}\n'
              '跳过: ${statistics.skippedTasks}\n'
              '节省空间: ${statistics.formattedSavedSpace}\n'
              '耗时: ${statistics.formattedDuration}'
      );
    } catch (e) {
      BotToast.showText(text: '清理失败: $e');
      print('清理错误: $e');
    } finally {
      setState(() {
        _isCleaning = false;
        _progress = 0.0;
      });
    }
  }
  
  Future<bool> _showCleanConfirmDialog() async {
    final totalSize = _scanResults.fold(0, (sum, task) => sum + task.size);
    
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认清理'),
        content: Text(
          '即将清理 ${_scanResults.length} 个文件/文件夹\n'
          '预计节省空间: ${StarFileSystem.formatFileSize(totalSize)}\n\n'
          '此操作不可撤销，确定要继续吗？'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确认清理'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showCleanSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => CleanSettingsWidget(
          config: _config,
          onConfigChanged: (newConfig) async {
            await _cleanService.updateConfig(newConfig);
            setState(() {
              _config = newConfig;
            });
          },
        ),
      ),
    );
  }
}
