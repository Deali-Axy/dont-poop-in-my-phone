import 'package:shared_preferences/shared_preferences.dart';

/// 清理配置管理器
class CleanConfigManager {
  static const String _keyAutoCleanEnabled = 'auto_clean_enabled';
  static const String _keyCleanOnStartup = 'clean_on_startup';
  static const String _keyMaxScanDepth = 'max_scan_depth';
  static const String _keyRespectAnnotations = 'respect_annotations';
  static const String _keyRespectWhitelist = 'respect_whitelist';
  static const String _keyConfirmBeforeClean = 'confirm_before_clean';
  static const String _keyShowCleanPreview = 'show_clean_preview';
  static const String _keyCleanLogLevel = 'clean_log_level';
  static const String _keyLastCleanTime = 'last_clean_time';
  static const String _keyTotalCleanedFiles = 'total_cleaned_files';
  static const String _keyTotalSavedSpace = 'total_saved_space';
  
  static SharedPreferences? _prefs;
  
  /// 初始化配置管理器
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  /// 确保已初始化
  static Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null) {
      await initialize();
    }
    return _prefs!;
  }
  
  // 基础清理设置
  
  /// 是否启用自动清理
  static Future<bool> isAutoCleanEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyAutoCleanEnabled) ?? false;
  }
  
  static Future<void> setAutoCleanEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyAutoCleanEnabled, enabled);
  }
  
  /// 是否在启动时清理
  static Future<bool> isCleanOnStartupEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyCleanOnStartup) ?? false;
  }
  
  static Future<void> setCleanOnStartupEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyCleanOnStartup, enabled);
  }
  
  /// 最大扫描深度
  static Future<int> getMaxScanDepth() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyMaxScanDepth) ?? 10;
  }
  
  static Future<void> setMaxScanDepth(int depth) async {
    final prefs = await _getPrefs();
    await prefs.setInt(_keyMaxScanDepth, depth);
  }
  
  // 安全设置
  
  /// 是否遵循路径标注
  static Future<bool> isRespectAnnotationsEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyRespectAnnotations) ?? true;
  }
  
  static Future<void> setRespectAnnotationsEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyRespectAnnotations, enabled);
  }
  
  /// 是否遵循白名单
  static Future<bool> isRespectWhitelistEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyRespectWhitelist) ?? true;
  }
  
  static Future<void> setRespectWhitelistEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyRespectWhitelist, enabled);
  }
  
  // 用户体验设置
  
  /// 是否在清理前确认
  static Future<bool> isConfirmBeforeCleanEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyConfirmBeforeClean) ?? true;
  }
  
  static Future<void> setConfirmBeforeCleanEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyConfirmBeforeClean, enabled);
  }
  
  /// 是否显示清理预览
  static Future<bool> isShowCleanPreviewEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyShowCleanPreview) ?? true;
  }
  
  static Future<void> setShowCleanPreviewEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyShowCleanPreview, enabled);
  }
  
  // 日志设置
  
  /// 清理日志级别
  static Future<CleanLogLevel> getCleanLogLevel() async {
    final prefs = await _getPrefs();
    final level = prefs.getInt(_keyCleanLogLevel) ?? CleanLogLevel.info.index;
    return CleanLogLevel.values[level];
  }
  
  static Future<void> setCleanLogLevel(CleanLogLevel level) async {
    final prefs = await _getPrefs();
    await prefs.setInt(_keyCleanLogLevel, level.index);
  }
  
  // 统计信息
  
  /// 最后清理时间
  static Future<DateTime?> getLastCleanTime() async {
    final prefs = await _getPrefs();
    final timestamp = prefs.getInt(_keyLastCleanTime);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }
  
  static Future<void> setLastCleanTime(DateTime time) async {
    final prefs = await _getPrefs();
    await prefs.setInt(_keyLastCleanTime, time.millisecondsSinceEpoch);
  }
  
  /// 总清理文件数
  static Future<int> getTotalCleanedFiles() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyTotalCleanedFiles) ?? 0;
  }
  
  static Future<void> addCleanedFiles(int count) async {
    final prefs = await _getPrefs();
    final current = await getTotalCleanedFiles();
    await prefs.setInt(_keyTotalCleanedFiles, current + count);
  }
  
  /// 总节省空间（字节）
  static Future<int> getTotalSavedSpace() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyTotalSavedSpace) ?? 0;
  }
  
  static Future<void> addSavedSpace(int bytes) async {
    final prefs = await _getPrefs();
    final current = await getTotalSavedSpace();
    await prefs.setInt(_keyTotalSavedSpace, current + bytes);
  }
  
  // 配置重置
  
  /// 重置所有配置为默认值
  static Future<void> resetToDefaults() async {
    final prefs = await _getPrefs();
    
    await prefs.setBool(_keyAutoCleanEnabled, false);
    await prefs.setBool(_keyCleanOnStartup, false);
    await prefs.setInt(_keyMaxScanDepth, 10);
    await prefs.setBool(_keyRespectAnnotations, true);
    await prefs.setBool(_keyRespectWhitelist, true);
    await prefs.setBool(_keyConfirmBeforeClean, true);
    await prefs.setBool(_keyShowCleanPreview, true);
    await prefs.setInt(_keyCleanLogLevel, CleanLogLevel.info.index);
  }
  
  /// 重置统计信息
  static Future<void> resetStatistics() async {
    final prefs = await _getPrefs();
    
    await prefs.remove(_keyLastCleanTime);
    await prefs.setInt(_keyTotalCleanedFiles, 0);
    await prefs.setInt(_keyTotalSavedSpace, 0);
  }
  
  // 配置导出/导入
  
  /// 导出配置
  static Future<Map<String, dynamic>> exportConfig() async {
    return {
      'autoCleanEnabled': await isAutoCleanEnabled(),
      'cleanOnStartup': await isCleanOnStartupEnabled(),
      'maxScanDepth': await getMaxScanDepth(),
      'respectAnnotations': await isRespectAnnotationsEnabled(),
      'respectWhitelist': await isRespectWhitelistEnabled(),
      'confirmBeforeClean': await isConfirmBeforeCleanEnabled(),
      'showCleanPreview': await isShowCleanPreviewEnabled(),
      'cleanLogLevel': (await getCleanLogLevel()).index,
    };
  }
  
  /// 导入配置
  static Future<void> importConfig(Map<String, dynamic> config) async {
    if (config.containsKey('autoCleanEnabled')) {
      await setAutoCleanEnabled(config['autoCleanEnabled'] as bool);
    }
    if (config.containsKey('cleanOnStartup')) {
      await setCleanOnStartupEnabled(config['cleanOnStartup'] as bool);
    }
    if (config.containsKey('maxScanDepth')) {
      await setMaxScanDepth(config['maxScanDepth'] as int);
    }
    if (config.containsKey('respectAnnotations')) {
      await setRespectAnnotationsEnabled(config['respectAnnotations'] as bool);
    }
    if (config.containsKey('respectWhitelist')) {
      await setRespectWhitelistEnabled(config['respectWhitelist'] as bool);
    }
    if (config.containsKey('confirmBeforeClean')) {
      await setConfirmBeforeCleanEnabled(config['confirmBeforeClean'] as bool);
    }
    if (config.containsKey('showCleanPreview')) {
      await setShowCleanPreviewEnabled(config['showCleanPreview'] as bool);
    }
    if (config.containsKey('cleanLogLevel')) {
      final level = CleanLogLevel.values[config['cleanLogLevel'] as int];
      await setCleanLogLevel(level);
    }
  }
}

/// 清理日志级别
enum CleanLogLevel {
  debug,   // 调试信息
  info,    // 一般信息
  warning, // 警告信息
  error,   // 错误信息
}

/// 清理配置
class CleanConfig {
  final bool autoCleanEnabled;
  final bool cleanOnStartup;
  final int maxScanDepth;
  final bool respectAnnotations;
  final bool respectWhitelist;
  final bool confirmBeforeClean;
  final bool showCleanPreview;
  final CleanLogLevel cleanLogLevel;
  
  const CleanConfig({
    required this.autoCleanEnabled,
    required this.cleanOnStartup,
    required this.maxScanDepth,
    required this.respectAnnotations,
    required this.respectWhitelist,
    required this.confirmBeforeClean,
    required this.showCleanPreview,
    required this.cleanLogLevel,
  });
  
  /// 从配置管理器加载配置
  static Future<CleanConfig> load() async {
    return CleanConfig(
      autoCleanEnabled: await CleanConfigManager.isAutoCleanEnabled(),
      cleanOnStartup: await CleanConfigManager.isCleanOnStartupEnabled(),
      maxScanDepth: await CleanConfigManager.getMaxScanDepth(),
      respectAnnotations: await CleanConfigManager.isRespectAnnotationsEnabled(),
      respectWhitelist: await CleanConfigManager.isRespectWhitelistEnabled(),
      confirmBeforeClean: await CleanConfigManager.isConfirmBeforeCleanEnabled(),
      showCleanPreview: await CleanConfigManager.isShowCleanPreviewEnabled(),
      cleanLogLevel: await CleanConfigManager.getCleanLogLevel(),
    );
  }
  
  /// 保存配置到配置管理器
  Future<void> save() async {
    await CleanConfigManager.setAutoCleanEnabled(autoCleanEnabled);
    await CleanConfigManager.setCleanOnStartupEnabled(cleanOnStartup);
    await CleanConfigManager.setMaxScanDepth(maxScanDepth);
    await CleanConfigManager.setRespectAnnotationsEnabled(respectAnnotations);
    await CleanConfigManager.setRespectWhitelistEnabled(respectWhitelist);
    await CleanConfigManager.setConfirmBeforeCleanEnabled(confirmBeforeClean);
    await CleanConfigManager.setShowCleanPreviewEnabled(showCleanPreview);
    await CleanConfigManager.setCleanLogLevel(cleanLogLevel);
  }
  
  CleanConfig copyWith({
    bool? autoCleanEnabled,
    bool? cleanOnStartup,
    int? maxScanDepth,
    bool? respectAnnotations,
    bool? respectWhitelist,
    bool? confirmBeforeClean,
    bool? showCleanPreview,
    CleanLogLevel? cleanLogLevel,
  }) {
    return CleanConfig(
      autoCleanEnabled: autoCleanEnabled ?? this.autoCleanEnabled,
      cleanOnStartup: cleanOnStartup ?? this.cleanOnStartup,
      maxScanDepth: maxScanDepth ?? this.maxScanDepth,
      respectAnnotations: respectAnnotations ?? this.respectAnnotations,
      respectWhitelist: respectWhitelist ?? this.respectWhitelist,
      confirmBeforeClean: confirmBeforeClean ?? this.confirmBeforeClean,
      showCleanPreview: showCleanPreview ?? this.showCleanPreview,
      cleanLogLevel: cleanLogLevel ?? this.cleanLogLevel,
    );
  }
}