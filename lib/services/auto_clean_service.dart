import 'dart:io';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/utils/file_system.dart';
import 'package:dont_poop_in_my_phone/viewmodels/file_item.dart';
import 'package:dont_poop_in_my_phone/viewmodels/folder_item.dart';
import 'package:dont_poop_in_my_phone/services/clean_config_manager.dart';
import 'package:path/path.dart' as path;

/// 清理任务状态
enum CleanTaskStatus {
  pending,    // 待清理
  completed,  // 已完成
  failed,     // 失败
  skipped,    // 跳过
}

/// 清理任务
class CleanTask {
  final String path;
  final String ruleName;
  final models.ActionType actionType;
  final CleanTaskStatus status;
  final String? error;
  final int savedSpace;
  final DateTime createdAt;

  CleanTask({
    required this.path,
    required this.ruleName,
    required this.actionType,
    this.status = CleanTaskStatus.pending,
    this.error,
    this.savedSpace = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  CleanTask copyWith({
    String? path,
    String? ruleName,
    models.ActionType? actionType,
    CleanTaskStatus? status,
    String? error,
    int? savedSpace,
    DateTime? createdAt,
  }) {
    return CleanTask(
      path: path ?? this.path,
      ruleName: ruleName ?? this.ruleName,
      actionType: actionType ?? this.actionType,
      status: status ?? this.status,
      error: error ?? this.error,
      savedSpace: savedSpace ?? this.savedSpace,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// 清理统计信息
class CleanStatistics {
  int totalTasks = 0;
  int completedTasks = 0;
  int failedTasks = 0;
  int skippedTasks = 0;
  int totalSizeFreed = 0; // 字节
  Duration duration = Duration.zero;
  
  // 兼容旧属性
  int get scannedFiles => totalTasks;
  set scannedFiles(int value) => totalTasks = value;
  
  int get cleanableFiles => totalTasks;
  set cleanableFiles(int value) => totalTasks = value;
  
  int get cleanedFiles => completedTasks;
  set cleanedFiles(int value) => completedTasks = value;
  
  int get savedSpace => totalSizeFreed;
  set savedSpace(int value) => totalSizeFreed = value;
  
  CleanStatistics({
    this.totalTasks = 0,
    this.completedTasks = 0,
    this.failedTasks = 0,
    this.skippedTasks = 0,
    this.totalSizeFreed = 0,
    this.duration = Duration.zero,
  });
  
  String get savedSpaceText {
    return StarFileSystem.formatFileSize(totalSizeFreed);
  }
  
  String get formattedSavedSpace => StarFileSystem.formatFileSize(totalSizeFreed);
  
  double get successRate => totalTasks > 0 ? completedTasks / totalTasks : 0.0;
  
  String get formattedDuration {
    if (duration.inHours > 0) {
      return '${duration.inHours}小时${duration.inMinutes % 60}分钟';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}分钟${duration.inSeconds % 60}秒';
    } else {
      return '${duration.inSeconds}秒';
    }
  }
}

/// 自动清理服务
class AutoCleanService {
  static final AutoCleanService _instance = AutoCleanService._internal();
  factory AutoCleanService() => _instance;
  AutoCleanService._internal();
  
  final RuleDao _ruleDao = RuleDao();
  final RuleItemDao _ruleItemDao = RuleItemDao();
  final PathAnnotationDao _pathAnnotationDao = PathAnnotationDao();
  final HistoryDao _historyDao = HistoryDao();
  
  CleanConfig? _config;
  
  /// 获取当前配置
  Future<CleanConfig> getConfig() async {
    _config ??= await CleanConfig.load();
    return _config!;
  }
  
  /// 更新配置
  Future<void> updateConfig(CleanConfig config) async {
    _config = config;
    await config.save();
  }
  /// 扫描可清理的路径
  Future<List<CleanTask>> scanForCleanablePaths() async {
    final List<CleanTask> tasks = [];
    final config = await getConfig();
    
    // 获取所有启用的规则
    final allRuleGroups = await RuleDao.getAllRuleGroups();
    final List<models.RuleItem> enabledRules = [];
    
    for (final group in allRuleGroups) {
      enabledRules.addAll(group.rules.where((rule) => rule.enabled));
    }
    
    if (enabledRules.isEmpty) {
      return tasks;
    }
    
    // 按优先级排序规则（优先级高的先执行）
    enabledRules.sort((a, b) => b.priority.compareTo(a.priority));
    
    // 从根目录开始递归扫描
    await _scanDirectory(
      StarFileSystem.SDCARD_ROOT, 
      enabledRules, 
      tasks,
      maxDepth: config.maxScanDepth
    );
    
    return tasks;
  }
  
  /// 递归扫描目录
  Future<void> _scanDirectory(
    String dirPath, 
    List<models.RuleItem> rules, 
    List<CleanTask> tasks,
    {int maxDepth = 10, int currentDepth = 0}
  ) async {
    if (currentDepth >= maxDepth) return;
    
    try {
      final dir = Directory(dirPath);
      if (!dir.existsSync()) return;
      
      final config = await getConfig();
      
      // 检查当前目录是否在白名单中（如果配置要求遵循白名单）
      if (config.respectWhitelist && await WhitelistDao.containsPath(dirPath)) {
        return; // 跳过白名单目录
      }
      
      // 检查路径标注（如果配置要求遵循标注）
      if (config.respectAnnotations) {
        final annotations = await _pathAnnotationDao.getByPath(dirPath);
        if (annotations.isNotEmpty) {
          // 如果有保护标注，跳过此路径
          final hasProtection = annotations.any((annotation) => 
            annotation.annotation.toLowerCase().contains('保护') ||
            annotation.annotation.toLowerCase().contains('protect') ||
            annotation.annotation.toLowerCase().contains('重要') ||
            annotation.annotation.toLowerCase().contains('important')
          );
          if (hasProtection) {
            return;
          }
        }
      }
      
      // 获取目录内容
      final entities = dir.listSync();
      
      for (final entity in entities) {
        try {
          // 检查是否匹配任何规则
          final matchedRule = await _findMatchingRule(entity.path, rules);
          if (matchedRule != null) {
            // 再次检查白名单（针对具体文件/目录）
            if (config.respectWhitelist && await WhitelistDao.containsPath(entity.path)) {
              continue;
            }
            
            // 检查路径标注建议
            if (config.respectAnnotations) {
              final annotation = await PathAnnotationDao.getByPath(entity.path);
              if (annotation != null && !annotation.suggestDelete) {
                continue; // 跳过不建议删除的路径
              }
            }
            
            tasks.add(CleanTask(
              path: entity.path,
              ruleName: await _getRuleGroupName(matchedRule),
              actionType: matchedRule.actionType,
            ));
          }
          
          // 如果是目录，递归扫描
          if (entity is Directory) {
            await _scanDirectory(
              entity.path, 
              rules, 
              tasks, 
              maxDepth: maxDepth,
              currentDepth: currentDepth + 1,
            );
          }
        } catch (e) {
          // 忽略单个文件/目录的错误，继续扫描其他项目
          continue;
        }
      }
    } catch (e) {
      // 忽略目录访问错误
      return;
    }
  }
  
  /// 查找匹配的规则
  Future<models.RuleItem?> _findMatchingRule(
    String targetPath, 
    List<models.RuleItem> rules
  ) async {
    for (final rule in rules) {
      if (await _isPathMatching(targetPath, rule)) {
        return rule;
      }
    }
    return null;
  }
  
  /// 检查路径是否匹配规则
  Future<bool> _isPathMatching(String targetPath, models.RuleItem rule) async {
    final rulePath = rule.path.toLowerCase();
    final target = targetPath.toLowerCase();
    
    switch (rule.pathMatchType) {
      case models.PathMatchType.exact:
        return target == rulePath;
        
      case models.PathMatchType.prefix:
        return target.startsWith(rulePath);
        
      case models.PathMatchType.suffix:
        return target.endsWith(rulePath);
        
      case models.PathMatchType.fuzzy:
        // 模糊匹配：检查路径中是否包含规则路径的关键部分
        final ruleBasename = path.basename(rulePath);
        final targetBasename = path.basename(target);
        return targetBasename.contains(ruleBasename) || 
               target.contains(rulePath);
        
      case models.PathMatchType.regex:
        try {
          final regex = RegExp(rulePath);
          return regex.hasMatch(target);
        } catch (e) {
          return false; // 正则表达式无效
        }
    }
  }
  
  /// 获取规则组名称
  Future<String> _getRuleGroupName(models.RuleItem ruleItem) async {
    try {
      final allGroups = await RuleDao.getAllRuleGroups();
      for (final group in allGroups) {
        if (group.rules.any((r) => r.id == ruleItem.id)) {
          return group.name;
        }
      }
      return '未知规则组';
    } catch (e) {
      return '未知规则组';
    }
  }
  
  /// 执行清理任务
  Future<CleanTask> executeCleanTask(CleanTask task) async {
    final config = await getConfig();
    
    try {
      final entity = FileSystemEntity.isFileSync(task.path) 
          ? File(task.path) 
          : Directory(task.path);
      
      if (!entity.existsSync()) {
        _logCleanAction(config, 'ERROR', '文件不存在: ${task.path}');
        return task.copyWith(
          status: CleanTaskStatus.skipped,
          error: '文件或目录不存在',
        );
      }
      
      // 最后一次安全检查
      if (config.respectWhitelist && await WhitelistDao.containsPath(task.path)) {
        _logCleanAction(config, 'WARNING', '路径在白名单中，跳过清理: ${task.path}');
        return task.copyWith(
          status: CleanTaskStatus.skipped,
          error: '路径在白名单中',
        );
      }
      
      if (config.respectAnnotations) {
        final annotations = await _pathAnnotationDao.getByPath(task.path);
        final hasProtection = annotations.any((annotation) => 
          annotation.annotation.toLowerCase().contains('保护') ||
          annotation.annotation.toLowerCase().contains('protect') ||
          annotation.annotation.toLowerCase().contains('重要') ||
          annotation.annotation.toLowerCase().contains('important')
        );
        if (hasProtection) {
          _logCleanAction(config, 'WARNING', '路径有保护标注，跳过清理: ${task.path}');
          return task.copyWith(
            status: CleanTaskStatus.skipped,
            error: '路径有保护标注',
          );
        }
      }
      
      // 计算文件大小（用于统计节省的空间）
      int fileSize = 0;
      try {
        if (entity is File) {
          fileSize = entity.lengthSync();
        } else if (entity is Directory) {
          fileSize = await _calculateDirectorySize(entity);
        }
      } catch (e) {
        // 无法计算大小，继续执行删除
      }
      
      _logCleanAction(config, 'INFO', '开始清理: ${task.path} (${StarFileSystem.formatFileSize(fileSize)})');
      
      // 执行删除操作
      await entity.delete(recursive: true);
      
      // 如果是删除并替换，创建空文件
      if (task.actionType == models.ActionType.deleteAndReplace) {
        if (entity is File) {
          await File(task.path).create();
        } else {
          await Directory(task.path).create();
        }
      }
      
      // 记录历史
      final history = models.History(
        name: '${task.actionType == models.ActionType.deleteAndReplace ? "替换" : "删除"}: ${path.basename(task.path)}',
        path: task.path,
        time: DateTime.now(),
        actionType: task.actionType,
        spaceChange: fileSize,
        status: models.HistoryStatus.success,
      );
      await HistoryDao.add(history);
      
      // 更新统计信息
      await CleanConfigManager.addCleanedFiles(1);
      await CleanConfigManager.addSavedSpace(fileSize);
      await CleanConfigManager.setLastCleanTime(DateTime.now());
      
      _logCleanAction(config, 'INFO', '清理完成: ${task.path}');
      
      return task.copyWith(
        status: CleanTaskStatus.completed,
        savedSpace: fileSize,
      );
      
    } catch (e) {
      _logCleanAction(config, 'ERROR', '清理失败: ${task.path}, 错误: $e');
      
      // 记录失败历史
      final history = models.History(
        name: '删除失败: ${path.basename(task.path)}',
        path: task.path,
        time: DateTime.now(),
        actionType: task.actionType,
        spaceChange: 0,
        status: models.HistoryStatus.failed,
      );
      await HistoryDao.add(history);
      
      return task.copyWith(
        status: CleanTaskStatus.failed,
        error: e.toString(),
      );
    }
  }
  
  /// 记录清理操作日志
  void _logCleanAction(CleanConfig config, String level, String message) {
    final logLevel = config.cleanLogLevel;
    
    switch (level) {
      case 'DEBUG':
        if (logLevel == CleanLogLevel.debug) {
          print('[CLEAN DEBUG] $message');
        }
        break;
      case 'INFO':
        if (logLevel.index <= CleanLogLevel.info.index) {
          print('[CLEAN INFO] $message');
        }
        break;
      case 'WARNING':
        if (logLevel.index <= CleanLogLevel.warning.index) {
          print('[CLEAN WARNING] $message');
        }
        break;
      case 'ERROR':
        if (logLevel.index <= CleanLogLevel.error.index) {
          print('[CLEAN ERROR] $message');
        }
        break;
    }
  }
  
  /// 计算目录大小
  Future<int> _calculateDirectorySize(Directory dir) async {
    int totalSize = 0;
    try {
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) {
          try {
            totalSize += entity.lengthSync();
          } catch (e) {
            // 忽略无法访问的文件
          }
        }
      }
    } catch (e) {
      // 忽略目录访问错误
    }
    return totalSize;
  }
  
  /// 批量执行清理任务
  Future<CleanStatistics> executeBatchClean(
    List<CleanTask> tasks, {
    Function(int completed, int total)? onProgress,
    Function(CleanTask task)? onTaskCompleted,
  }) async {
    final config = await getConfig();
    final startTime = DateTime.now();
    
    int completed = 0;
    int failed = 0;
    int skipped = 0;
    int totalSize = 0;
    
    _logCleanAction(config, 'INFO', '开始批量清理，共 ${tasks.length} 个任务');
    
    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      
      // 如果配置要求确认，可以在这里添加确认逻辑
      if (config.confirmBeforeClean && task.savedSpace > 100 * 1024 * 1024) { // 大于100MB的文件需要确认
        _logCleanAction(config, 'INFO', '大文件需要确认: ${task.path} (${StarFileSystem.formatFileSize(task.savedSpace)})');
        // 这里可以触发确认回调
      }
      
      final result = await executeCleanTask(task);
      
      switch (result.status) {
        case CleanTaskStatus.completed:
          completed++;
          totalSize += result.savedSpace;
          break;
        case CleanTaskStatus.failed:
          failed++;
          break;
        case CleanTaskStatus.skipped:
          skipped++;
          break;
        default:
          break;
      }
      
      onTaskCompleted?.call(result);
      onProgress?.call(i + 1, tasks.length);
    }
    
    final duration = DateTime.now().difference(startTime);
    
    _logCleanAction(config, 'INFO', 
      '批量清理完成: 成功 $completed, 失败 $failed, 跳过 $skipped, '
      '节省空间 ${StarFileSystem.formatFileSize(totalSize)}, '
      '耗时 ${duration.inSeconds} 秒'
    );
    
    final statistics = CleanStatistics();
    statistics.scannedFiles = tasks.length;
    statistics.cleanedFiles = completed;
    statistics.savedSpace = totalSize;
    
    return statistics;
  }
  
  /// 预览清理操作（不实际执行）
  Future<CleanStatistics> previewClean(List<CleanTask> tasks) async {
    final statistics = CleanStatistics();
    
    for (final task in tasks) {
      if (task.status == CleanTaskStatus.pending) {
        try {
          final entity = FileSystemEntity.isFileSync(task.path) 
              ? File(task.path) 
              : Directory(task.path);
          
          if (entity.existsSync()) {
            int fileSize = 0;
            if (entity is File) {
              fileSize = entity.lengthSync();
            } else if (entity is Directory) {
              fileSize = await _calculateDirectorySize(entity);
            }
            statistics.savedSpace += fileSize;
            statistics.cleanableFiles++;
          }
        } catch (e) {
          // 忽略错误，继续统计其他文件
        }
      }
    }
    
    statistics.scannedFiles = tasks.length;
    
    return statistics;
  }
}