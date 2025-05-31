import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/services/clean_config_manager.dart';

/// 清理设置组件
class CleanSettingsWidget extends StatefulWidget {
  final CleanConfig? config;
  final Function(CleanConfig) onConfigChanged;
  
  const CleanSettingsWidget({
    Key? key,
    this.config,
    required this.onConfigChanged,
  }) : super(key: key);
  
  @override
  State<CleanSettingsWidget> createState() => _CleanSettingsWidgetState();
}

class _CleanSettingsWidgetState extends State<CleanSettingsWidget> {
  late CleanConfig _config;
  
  @override
  void initState() {
    super.initState();
    _config = widget.config ?? const CleanConfig(
      autoCleanEnabled: false,
      cleanOnStartup: false,
      maxScanDepth: 10,
      respectAnnotations: true,
      respectWhitelist: true,
      confirmBeforeClean: true,
      showCleanPreview: true,
      cleanLogLevel: CleanLogLevel.info,
    );
  }
  
  void _updateConfig(CleanConfig newConfig) {
    setState(() {
      _config = newConfig;
    });
    widget.onConfigChanged(newConfig);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Row(
            children: [
              const Icon(Icons.settings, color: Colors.blue),
              const SizedBox(width: 8),
              const Text(
                '清理设置',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // 设置内容
          Expanded(
            child: ListView(
              children: [
                // 基础设置
                _buildSettingCard(
                  '基础设置',
                  Icons.tune,
                  [
                    _buildSwitchTile(
                      '启用自动清理',
                      '定期自动执行清理任务',
                      _config.autoCleanEnabled,
                      (value) => _updateConfig(_config.copyWith(autoCleanEnabled: value)),
                    ),
                    _buildSwitchTile(
                      '启动时清理',
                      '应用启动时自动执行清理',
                      _config.cleanOnStartup,
                      (value) => _updateConfig(_config.copyWith(cleanOnStartup: value)),
                    ),
                    _buildSliderTile(
                      '最大扫描深度',
                      '限制目录扫描的最大深度',
                      _config.maxScanDepth.toDouble(),
                      1,
                      20,
                      (value) => _updateConfig(_config.copyWith(maxScanDepth: value.round())),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // 安全设置
                _buildSettingCard(
                  '安全设置',
                  Icons.security,
                  [
                    _buildSwitchTile(
                      '遵循白名单',
                      '跳过白名单中的路径',
                      _config.respectWhitelist,
                      (value) => _updateConfig(_config.copyWith(respectWhitelist: value)),
                    ),
                    _buildSwitchTile(
                      '遵循路径标注',
                      '根据路径标注决定是否清理',
                      _config.respectAnnotations,
                      (value) => _updateConfig(_config.copyWith(respectAnnotations: value)),
                    ),
                    _buildSwitchTile(
                      '清理前确认',
                      '执行清理前显示确认对话框',
                      _config.confirmBeforeClean,
                      (value) => _updateConfig(_config.copyWith(confirmBeforeClean: value)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // 用户体验设置
                _buildSettingCard(
                  '用户体验',
                  Icons.visibility,
                  [
                    _buildSwitchTile(
                      '显示清理预览',
                      '清理前显示将要删除的文件列表',
                      _config.showCleanPreview,
                      (value) => _updateConfig(_config.copyWith(showCleanPreview: value)),
                    ),
                    _buildDropdownTile(
                      '日志级别',
                      '控制清理过程中的日志输出详细程度',
                      _config.cleanLogLevel,
                      CleanLogLevel.values,
                      (value) => _updateConfig(_config.copyWith(cleanLogLevel: value)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // 操作按钮
                _buildActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
  
  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
  
  Widget _buildSliderTile(
    String title,
    String subtitle,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          trailing: Text(
            value.round().toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  Widget _buildDropdownTile<T>(
    String title,
    String subtitle,
    T value,
    List<T> items,
    Function(T) onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: DropdownButton<T>(
        value: value,
        items: items.map((item) {
          String displayText;
          if (item is CleanLogLevel) {
            switch (item) {
              case CleanLogLevel.debug:
                displayText = '调试';
                break;
              case CleanLogLevel.info:
                displayText = '信息';
                break;
              case CleanLogLevel.warning:
                displayText = '警告';
                break;
              case CleanLogLevel.error:
                displayText = '错误';
                break;
            }
          } else {
            displayText = item.toString();
          }
          
          return DropdownMenuItem<T>(
            value: item,
            child: Text(displayText),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.build, size: 20, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  '操作',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetToDefaults,
                    icon: const Icon(Icons.restore),
                    label: const Text('恢复默认'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetStatistics,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('清除统计'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _exportConfig,
                icon: const Icon(Icons.download),
                label: const Text('导出配置'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _resetToDefaults() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('恢复默认设置'),
        content: const Text('确定要将所有设置恢复为默认值吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await CleanConfigManager.resetToDefaults();
      final defaultConfig = await CleanConfig.load();
      _updateConfig(defaultConfig);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已恢复默认设置')),
        );
      }
    }
  }
  
  Future<void> _resetStatistics() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清除统计信息'),
        content: const Text('确定要清除所有清理统计信息吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await CleanConfigManager.resetStatistics();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已清除统计信息')),
        );
      }
    }
  }
  
  Future<void> _exportConfig() async {
    try {
      final config = await CleanConfigManager.exportConfig();
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('配置导出'),
            content: SingleChildScrollView(
              child: SelectableText(
                'autoCleanEnabled: ${config['autoCleanEnabled']}\n'
                'cleanOnStartup: ${config['cleanOnStartup']}\n'
                'maxScanDepth: ${config['maxScanDepth']}\n'
                'respectAnnotations: ${config['respectAnnotations']}\n'
                'respectWhitelist: ${config['respectWhitelist']}\n'
                'confirmBeforeClean: ${config['confirmBeforeClean']}\n'
                'showCleanPreview: ${config['showCleanPreview']}\n'
                'cleanLogLevel: ${config['cleanLogLevel']}',
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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e')),
        );
      }
    }
  }
}