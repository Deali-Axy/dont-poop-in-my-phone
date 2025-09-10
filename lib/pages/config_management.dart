/// 配置管理页面
/// 允许用户查看和管理应用的默认配置

import 'package:flutter/material.dart';
import '../services/config_service.dart';
import '../widgets/index.dart';
import '../common/index.dart';

class ConfigManagementPage extends StatefulWidget {
  const ConfigManagementPage({Key? key}) : super(key: key);

  @override
  State<ConfigManagementPage> createState() => _ConfigManagementPageState();
}

class _ConfigManagementPageState extends State<ConfigManagementPage> {
  Map<String, int> _configStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConfigStats();
  }

  Future<void> _loadConfigStats() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final stats = await ConfigService.getConfigStats();
      setState(() {
        _configStats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载配置信息失败: $e')),
        );
      }
    }
  }

  Future<void> _reinitializeWhitelist() async {
    try {
      await ConfigService.reinitializeWhitelist();
      await _loadConfigStats();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('白名单配置已更新')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('更新白名单失败: $e')),
        );
      }
    }
  }

  Future<void> _reinitializeRules() async {
    try {
      await ConfigService.reinitializeCleanRules();
      await _loadConfigStats();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('清理规则已更新')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('更新清理规则失败: $e')),
        );
      }
    }
  }

  Future<void> _reinitializeAnnotations() async {
    try {
      await ConfigService.reinitializePathAnnotations();
      await _loadConfigStats();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('路径标注已更新')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('更新路径标注失败: $e')),
        );
      }
    }
  }

  Future<void> _resetToDefaults() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重置配置'),
        content: const Text('这将重置所有配置为默认值，您的自定义配置可能会丢失。确定要继续吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ConfigService.resetToDefaults();
        await _loadConfigStats();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('配置已重置为默认值')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('重置配置失败: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CatThemedAppBar(
        title: '配置管理',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadConfigStats,
            tooltip: '刷新',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 配置统计卡片
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.analytics_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '配置统计',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildStatRow('白名单总数', _configStats['whitelist_count'] ?? 0),
                          _buildStatRow('内置白名单', _configStats['builtin_whitelist_count'] ?? 0),
                          _buildStatRow('清理规则', _configStats['rule_count'] ?? 0),
                          _buildStatRow('路径标注总数', _configStats['annotation_count'] ?? 0),
                          _buildStatRow('内置标注', _configStats['builtin_annotation_count'] ?? 0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 配置管理操作
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.settings_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '配置管理',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          _buildActionTile(
                            icon: Icons.security,
                            title: '更新白名单配置',
                            subtitle: '添加最新的保护路径配置',
                            onTap: _reinitializeWhitelist,
                          ),
                          const Divider(),
                          
                          _buildActionTile(
                            icon: Icons.cleaning_services,
                            title: '更新清理规则',
                            subtitle: '添加最新的垃圾清理规则',
                            onTap: _reinitializeRules,
                          ),
                          const Divider(),
                          
                          _buildActionTile(
                            icon: Icons.label_outline,
                            title: '更新路径标注',
                            subtitle: '添加最新的路径说明标注',
                            onTap: _reinitializeAnnotations,
                          ),
                          const Divider(),
                          
                          _buildActionTile(
                            icon: Icons.restore,
                            title: '重置为默认配置',
                            subtitle: '恢复所有配置为出厂设置',
                            onTap: _resetToDefaults,
                            isDestructive: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 说明信息
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '配置说明',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '• 白名单配置：保护重要文件和目录不被误删\n'
                            '• 清理规则：定义哪些文件和目录可以安全清理\n'
                            '• 路径标注：为用户提供目录用途说明\n'
                            '• 配置更新：添加新的预设配置，不会删除现有配置\n'
                            '• 重置配置：将所有配置恢复为默认状态',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}