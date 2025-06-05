import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:dont_poop_in_my_phone/services/auto_clean_service.dart';
import 'package:dont_poop_in_my_phone/services/clean_config_manager.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/utils/file_system.dart';
import 'package:dont_poop_in_my_phone/widgets/clean_settings_widget.dart';
import 'package:dont_poop_in_my_phone/widgets/clean_task_card.dart';
import 'package:dont_poop_in_my_phone/widgets/star_text_button.dart';
import 'package:dont_poop_in_my_phone/widgets/animated_stat_card.dart';
import 'package:dont_poop_in_my_phone/widgets/cat_themed_app_bar.dart';
import 'package:dont_poop_in_my_phone/widgets/cat_empty_state.dart';
import 'package:dont_poop_in_my_phone/utils/theme.dart';
import 'package:dont_poop_in_my_phone/states/theme.dart';

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
      appBar: CatThemedAppBar(
         title: '自动清理',
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? null : CatTheme.catGradient,
        color: isDark ? Theme.of(context).colorScheme.surface : null,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 统计卡片
            AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: -50.0,
                child: FadeInAnimation(
                  child: _buildStatisticsCard(),
                ),
              ),
            ),
            // 操作按钮
            _buildActionButtons(),
            // 结果列表
            Container(
              height: MediaQuery.of(context).size.height * 0.8, // 给结果列表一个固定高度
              margin: EdgeInsets.symmetric(
                horizontal: CatTheme.getResponsivePadding(context),
              ),
              decoration: CatTheme.catCardDecoration(context).copyWith(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: _buildResultsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return AnimatedStatCard(
      statistics: _statistics,
      isLoading: _isScanning,
      animationIndex: 0,
      onTap: () {
        // 可以添加点击统计卡片的交互
        if (_statistics.cleanedFiles > 0) {
          BotToast.showText(text: '总共清理了 ${_statistics.cleanedFiles} 个文件，节省了 ${_statistics.savedSpaceText} 空间！');
        }
      },
    );
  }



  Widget _buildActionButtons() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: CatTheme.getResponsivePadding(context),
        vertical: 8, // 减小垂直间距
      ),
      child: Row(
        children: [
          // 扫描按钮卡片
          Expanded(
            child: AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 30.0,
                child: FadeInAnimation(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: CatTheme.catCardDecoration(context, isDark: isDark).copyWith(
                      gradient: isDark ? null : LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          CatTheme.getCatColor('softCream'),
                          CatTheme.getCatColor('softPeach'),
                        ],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _isScanning ? null : _startScan,
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _canClean() 
                                      ? (isDark 
                                          ? Theme.of(context).colorScheme.surface.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.9))
                                      : (isDark 
                                          ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                                          : Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _canClean() ? [
                                    BoxShadow(
                                      color: (isDark 
                                          ? Colors.black.withOpacity(0.3)
                                          : Colors.black.withOpacity(0.1)),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ] : null,
                                ),
                                child: _isScanning
                                    ? Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              CatTheme.getCatColor('catOrange'),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.search_rounded,
                                        color: CatTheme.getCatColor('catOrange'),
                                        size: 20,
                                      ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _isScanning ? '扫描中...' : '开始扫描',
                                style: CatTheme.catSubtitleStyle(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isDark ? Theme.of(context).colorScheme.onSurface : null,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _isScanning ? '寻找垃圾文件' : '扫描垃圾文件',
                                style: CatTheme.catBodyStyle(context).copyWith(
                                  fontSize: 11,
                                  color: isDark ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7) : CatTheme.getCatColor('catGray'),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                CatTheme.getCatEmoji(_isScanning ? 'scanning' : 'pending'),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 清理按钮卡片
          Expanded(
            child: AnimationConfiguration.staggeredList(
              position: 1,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 30.0,
                child: FadeInAnimation(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: CatTheme.catCardDecoration(context).copyWith(
                      gradient: _canClean()
                          ? (isDark 
                              ? LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Theme.of(context).colorScheme.surfaceContainer,
                                    Theme.of(context).colorScheme.surfaceContainerHighest,
                                  ],
                                )
                              : LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    CatTheme.getCatColor('softMint'),
                                    const Color(0xFF86E5CE),
                                  ],
                                ))
                          : (isDark 
                              ? LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                    Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                                  ],
                                )
                              : LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.grey[100]!,
                                    Colors.grey[200]!,
                                  ],
                                )),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _canClean() ? _startClean : null,
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _canClean() 
                                      ? (isDark 
                                          ? Theme.of(context).colorScheme.surface.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.9))
                                      : (isDark 
                                          ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5)
                                          : Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _canClean() ? [
                                    BoxShadow(
                                      color: (isDark 
                                          ? Colors.black.withOpacity(0.3)
                                          : Colors.black.withOpacity(0.1)),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ] : null,
                                ),
                                child: _isCleaning
                                    ? Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              CatTheme.getCatColor('eyeGreen'),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.cleaning_services_rounded,
                                        color: _canClean() 
                                            ? CatTheme.getCatColor('eyeGreen')
                                            : Colors.grey[500],
                                        size: 20,
                                      ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _isCleaning ? '清理中...' : '开始清理',
                                style: CatTheme.catSubtitleStyle(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: _canClean() 
                                      ? (isDark ? Theme.of(context).colorScheme.onSurface : CatTheme.getCatColor('catBrown'))
                                      : (isDark ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5) : Colors.grey[600]),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _isCleaning 
                                    ? '清理垃圾文件'
                                    : _canClean() 
                                        ? '清理垃圾文件'
                                        : '请先扫描',
                                style: CatTheme.catBodyStyle(context).copyWith(
                                  fontSize: 11,
                                  color: _canClean() 
                                      ? (isDark ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7) : CatTheme.getCatColor('catGray'))
                                      : (isDark ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5) : Colors.grey[500]),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                CatTheme.getCatEmoji(
                                  _isCleaning 
                                      ? 'running'
                                      : _canClean() 
                                          ? 'success'
                                          : 'waiting'
                                ),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    if (_scanResults.isEmpty) {
      return CatEmptyState(
        title: _isScanning ? '正在扫描中...' : '暂无扫描结果',
        subtitle: _isScanning 
            ? '小猫正在努力寻找可清理的文件' 
            : '点击扫描按钮开始查找可清理的文件',
        emptyType: _isScanning ? 'scan' : 'clean',
        actionText: _isScanning ? null : '开始扫描',
        onActionPressed: _isScanning ? null : _startScan,
        showAnimation: true,
      );
    }

    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(CatTheme.getResponsivePadding(context)),
        itemCount: _scanResults.length,
        itemBuilder: (context, index) {
          final task = _scanResults[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: CleanTaskCard(
                  task: task,
                  onToggle: () {
                    // CleanTask doesn't have enabled property
                    // This would need to be handled differently
                    // For now, just provide an empty callback
                  },
                ),
              ),
            ),
          );
        },
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
          totalSizeFreed: results.fold(0.0, (sum, task) => sum + task.size).toInt(),
        );
        _progress = 1.0;
      });
      
      if (results.isEmpty) {
        BotToast.showText(text: '未发现需要清理的文件');
      } else {
        final totalSize = results.fold(0.0, (sum, task) => sum + task.size).toInt();
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
    final totalSize = _scanResults.fold(0.0, (sum, task) => sum + task.size).toInt();
    
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

  bool _canClean() {
    return _scanResults.isNotEmpty && !_isScanning && !_isCleaning;
  }
}
