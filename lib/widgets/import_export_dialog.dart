import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/services/import_export_service.dart';
import 'package:open_filex/open_filex.dart';

/// 导入导出对话框
class ImportExportDialog extends StatefulWidget {
  final ExportType exportType;
  final String title;
  final String exportButtonText;
  final String importButtonText;
  final VoidCallback? onImportSuccess;

  const ImportExportDialog({
    Key? key,
    required this.exportType,
    required this.title,
    this.exportButtonText = '导出',
    this.importButtonText = '导入',
    this.onImportSuccess,
  }) : super(key: key);

  @override
  State<ImportExportDialog> createState() => _ImportExportDialogState();
}

class _ImportExportDialogState extends State<ImportExportDialog> {
  bool _isLoading = false;
  ImportMode _importMode = ImportMode.merge;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '选择操作：',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 16),
          
          // 导出按钮
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _handleExport,
              icon: const Icon(Icons.upload),
              label: Text(widget.exportButtonText),
            ),
          ),
          
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          
          // 导入模式选择
          Text(
            '导入模式：',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          
          Column(
            children: [
              RadioListTile<ImportMode>(
                title: const Text('智能合并'),
                subtitle: const Text('跳过已存在的数据，只添加新数据'),
                value: ImportMode.merge,
                groupValue: _importMode,
                onChanged: _isLoading ? null : (value) {
                  setState(() {
                    _importMode = value!;
                  });
                },
                dense: true,
              ),
              RadioListTile<ImportMode>(
                title: const Text('增量导入'),
                subtitle: const Text('直接添加所有数据，可能产生重复'),
                value: ImportMode.append,
                groupValue: _importMode,
                onChanged: _isLoading ? null : (value) {
                  setState(() {
                    _importMode = value!;
                  });
                },
                dense: true,
              ),
              if (widget.exportType != ExportType.all)
                RadioListTile<ImportMode>(
                  title: const Text('覆盖导入'),
                  subtitle: const Text('清空现有数据后导入（保留系统数据）'),
                  value: ImportMode.replace,
                  groupValue: _importMode,
                  onChanged: _isLoading ? null : (value) {
                    setState(() {
                      _importMode = value!;
                    });
                  },
                  dense: true,
                ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 导入按钮
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _handleImport,
              icon: const Icon(Icons.download),
              label: Text(widget.importButtonText),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
      ],
    );
  }

  Future<void> _handleExport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      late String filePath;
      
      switch (widget.exportType) {
        case ExportType.whitelist:
          filePath = await ImportExportService.exportWhitelists();
          break;
        case ExportType.rules:
          filePath = await ImportExportService.exportRules();
          break;
        case ExportType.pathAnnotations:
          filePath = await ImportExportService.exportPathAnnotations();
          break;
        case ExportType.all:
          filePath = await ImportExportService.exportAll();
          break;
      }
      
      if (mounted) {
        Navigator.of(context).pop();
        
        // 显示成功对话框
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('导出成功'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('文件已保存到：'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SelectableText(
                    filePath,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('确定'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  OpenFilex.open(filePath);
                },
                child: const Text('打开文件'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('导出失败: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleImport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      dynamic result;
      
      switch (widget.exportType) {
        case ExportType.whitelist:
          result = await ImportExportService.importWhitelists(_importMode);
          break;
        case ExportType.rules:
          result = await ImportExportService.importRules(_importMode);
          break;
        case ExportType.pathAnnotations:
          result = await ImportExportService.importPathAnnotations(_importMode);
          break;
        case ExportType.all:
          result = await ImportExportService.importAll(_importMode);
          break;
      }
      
      if (mounted) {
        Navigator.of(context).pop();
        
        // 调用成功回调
        widget.onImportSuccess?.call();
        
        // 显示成功消息
        String message;
        if (result is Map<String, int>) {
          // 全量导入结果
          final parts = <String>[];
          if (result['whitelists'] != null && result['whitelists']! > 0) {
            parts.add('白名单 ${result['whitelists']} 条');
          }
          if (result['rules'] != null && result['rules']! > 0) {
            parts.add('规则 ${result['rules']} 条');
          }
          if (result['pathAnnotations'] != null && result['pathAnnotations']! > 0) {
            parts.add('路径标注 ${result['pathAnnotations']} 条');
          }
          
          if (parts.isEmpty) {
            message = '没有导入新数据';
          } else {
            message = '成功导入：${parts.join('、')}';
          }
        } else {
          // 单项导入结果
          final count = result as int;
          if (count > 0) {
            message = '成功导入 $count 条数据';
          } else {
            message = '没有导入新数据';
          }
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('导入失败: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

/// 显示导入导出对话框的便捷方法
class ImportExportDialogHelper {
  /// 显示白名单导入导出对话框
  static Future<void> showWhitelistDialog(
    BuildContext context, {
    VoidCallback? onImportSuccess,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ImportExportDialog(
        exportType: ExportType.whitelist,
        title: '白名单导入导出',
        exportButtonText: '导出白名单',
        importButtonText: '导入白名单',
        onImportSuccess: onImportSuccess,
      ),
    );
  }

  /// 显示清理规则导入导出对话框
  static Future<void> showRulesDialog(
    BuildContext context, {
    VoidCallback? onImportSuccess,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ImportExportDialog(
        exportType: ExportType.rules,
        title: '清理规则导入导出',
        exportButtonText: '导出规则',
        importButtonText: '导入规则',
        onImportSuccess: onImportSuccess,
      ),
    );
  }

  /// 显示路径标注导入导出对话框
  static Future<void> showPathAnnotationsDialog(
    BuildContext context, {
    VoidCallback? onImportSuccess,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ImportExportDialog(
        exportType: ExportType.pathAnnotations,
        title: '路径标注导入导出',
        exportButtonText: '导出路径标注',
        importButtonText: '导入路径标注',
        onImportSuccess: onImportSuccess,
      ),
    );
  }

  /// 显示全量数据导入导出对话框
  static Future<void> showAllDataDialog(
    BuildContext context, {
    VoidCallback? onImportSuccess,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ImportExportDialog(
        exportType: ExportType.all,
        title: '数据备份与恢复',
        exportButtonText: '导出备份',
        importButtonText: '导入备份',
        onImportSuccess: onImportSuccess,
      ),
    );
  }
}