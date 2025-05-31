import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:dont_poop_in_my_phone/dao/index.dart';

/// 导出数据类型
enum ExportType {
  whitelist,
  rules,
  pathAnnotations,
  all,
}

/// 导入模式
enum ImportMode {
  append,    // 增量导入，添加新数据
  replace,   // 覆盖导入，替换现有数据
  merge,     // 智能合并，根据关键字段合并
}

/// 导入导出服务
class ImportExportService {

  /// 导出白名单数据
  static Future<String> exportWhitelists() async {
    try {
      final whitelists = await WhitelistDao.getAll();
      final exportData = {
        'version': '1.0',
        'exportTime': DateTime.now().toIso8601String(),
        'type': 'whitelist',
        'data': {
          'whitelists': whitelists.map((item) => item.toJson()).toList(),
        }
      };
      
      return await _saveToFile(
        jsonEncode(exportData), 
        'whitelist_export_${DateTime.now().millisecondsSinceEpoch}.json'
      );
    } catch (e) {
      throw Exception('导出白名单失败: $e');
    }
  }

  /// 导入白名单数据
  static Future<int> importWhitelists(ImportMode mode) async {
    try {
      final fileContent = await _pickAndReadFile();
      if (fileContent == null) return 0;
      
      final data = jsonDecode(fileContent);
      _validateImportData(data, 'whitelist');
      
      final whitelistsData = data['data']['whitelists'] as List;
      final whitelists = whitelistsData
          .map((json) => models.Whitelist.fromJson(json))
          .toList();
      
      int importedCount = 0;
      
      if (mode == ImportMode.replace) {
        // 清空现有数据（保留只读数据）
        final existingWhitelists = await WhitelistDao.getAll();
        for (final item in existingWhitelists) {
          if (!item.readOnly) {
            await WhitelistDao.deleteByPath(item.path);
          }
        }
      }
      
      for (final whitelist in whitelists) {
        if (mode == ImportMode.merge) {
          // 检查是否已存在相同路径的白名单
          final exists = await WhitelistDao.containsPath(whitelist.path);
          if (exists) continue;
        }
        
        final newWhitelist = models.Whitelist(
          path: whitelist.path,
          type: whitelist.type,
          annotation: whitelist.annotation,
          readOnly: false, // 导入的数据默认不是只读
        );
        
        final result = await WhitelistDao.add(newWhitelist);
        if (result != null) importedCount++;
      }
      
      return importedCount;
    } catch (e) {
      throw Exception('导入白名单失败: $e');
    }
  }

  /// 导出清理规则数据
  static Future<String> exportRules() async {
    try {
      final ruleGroups = await RuleDao.getAllRuleGroups();
      final exportData = {
        'version': '1.0',
        'exportTime': DateTime.now().toIso8601String(),
        'type': 'rules',
        'data': {
          'rules': ruleGroups.map((group) => group.toJson()).toList(),
        }
      };
      
      return await _saveToFile(
        jsonEncode(exportData), 
        'rules_export_${DateTime.now().millisecondsSinceEpoch}.json'
      );
    } catch (e) {
      throw Exception('导出清理规则失败: $e');
    }
  }

  /// 导入清理规则数据
  static Future<int> importRules(ImportMode mode) async {
    try {
      final fileContent = await _pickAndReadFile();
      if (fileContent == null) return 0;
      
      final data = jsonDecode(fileContent);
      _validateImportData(data, 'rules');
      
      final rulesData = data['data']['rules'] as List;
      final rules = rulesData
          .map((json) => models.Rule.fromJson(json))
          .toList();
      
      int importedCount = 0;
      
      for (final rule in rules) {
        // 跳过系统规则
        if (rule.isSystemRule) continue;
        
        if (mode == ImportMode.replace) {
          // 删除同名的非系统规则组
          try {
            final existingRule = await RuleDao.getRuleGroupByName(rule.name);
            if (!existingRule.isSystemRule) {
              await RuleDao.deleteRuleGroup(existingRule.id!);
            }
          } catch (e) {
            // 规则组不存在，继续
          }
        } else if (mode == ImportMode.merge) {
          // 检查是否已存在同名规则组
          try {
            await RuleDao.getRuleGroupByName(rule.name);
            continue; // 已存在，跳过
          } catch (e) {
            // 不存在，继续导入
          }
        }
        
        // 创建新的规则组
        final newRuleGroup = await RuleDao.ensureRuleGroupExists(
          rule.name, 
          isSystemRule: false
        );
        
        // 添加规则项
        for (final ruleItem in rule.rules) {
          final newRuleItem = models.RuleItem(
            path: ruleItem.path,
            pathMatchType: ruleItem.pathMatchType,
            actionType: ruleItem.actionType,
            priority: ruleItem.priority,
            enabled: ruleItem.enabled,
            annotation: ruleItem.annotation,
            tags: ruleItem.tags,
          );
          
          await RuleDao.addRuleItemToGroup(newRuleGroup.name, newRuleItem);
          importedCount++;
        }
      }
      
      return importedCount;
    } catch (e) {
      throw Exception('导入清理规则失败: $e');
    }
  }

  /// 导出路径标注数据
  static Future<String> exportPathAnnotations() async {
    try {
      final annotations = await PathAnnotationDao.getAll();
      final exportData = {
        'version': '1.0',
        'exportTime': DateTime.now().toIso8601String(),
        'type': 'pathAnnotations',
        'data': {
          'pathAnnotations': annotations.map((item) => item.toJson()).toList(),
        }
      };
      
      return await _saveToFile(
        jsonEncode(exportData), 
        'path_annotations_export_${DateTime.now().millisecondsSinceEpoch}.json'
      );
    } catch (e) {
      throw Exception('导出路径标注失败: $e');
    }
  }

  /// 导入路径标注数据
  static Future<int> importPathAnnotations(ImportMode mode) async {
    try {
      final fileContent = await _pickAndReadFile();
      if (fileContent == null) return 0;
      
      final data = jsonDecode(fileContent);
      _validateImportData(data, 'pathAnnotations');
      
      final annotationsData = data['data']['pathAnnotations'] as List;
      final annotations = annotationsData
          .map((json) => models.PathAnnotation.fromJson(json))
          .toList();
      
      int importedCount = 0;
      
      for (final annotation in annotations) {
        // 跳过内置标注
        if (annotation.isBuiltIn) continue;
        
        if (mode == ImportMode.replace) {
          // 删除同路径的非内置标注
          final existing = await PathAnnotationDao.getByPath(annotation.path);
          if (existing != null && !existing.isBuiltIn) {
            await PathAnnotationDao.delete(existing.id!);
          }
        } else if (mode == ImportMode.merge) {
          // 检查是否已存在相同路径的标注
          final existing = await PathAnnotationDao.getByPath(annotation.path);
          if (existing != null) continue;
        }
        
        final newAnnotation = models.PathAnnotation(
          path: annotation.path,
          description: annotation.description,
          suggestDelete: annotation.suggestDelete,
          pathMatchType: annotation.pathMatchType,
          isBuiltIn: false, // 导入的数据默认不是内置
        );
        
        final result = await PathAnnotationDao.add(newAnnotation);
        if (result != null) importedCount++;
      }
      
      return importedCount;
    } catch (e) {
      throw Exception('导入路径标注失败: $e');
    }
  }

  /// 导出所有数据
  static Future<String> exportAll() async {
    try {
      final whitelists = await WhitelistDao.getAll();
      final ruleGroups = await RuleDao.getAllRuleGroups();
      final annotations = await PathAnnotationDao.getAll();
      
      final exportData = {
        'version': '1.0',
        'exportTime': DateTime.now().toIso8601String(),
        'type': 'all',
        'appVersion': '1.4.1', // TODO: 从package_info获取
        'data': {
          'whitelists': whitelists.map((item) => item.toJson()).toList(),
          'rules': ruleGroups.map((group) => group.toJson()).toList(),
          'pathAnnotations': annotations.map((item) => item.toJson()).toList(),
        }
      };
      
      return await _saveToFile(
        jsonEncode(exportData), 
        'full_backup_${DateTime.now().millisecondsSinceEpoch}.json'
      );
    } catch (e) {
      throw Exception('导出所有数据失败: $e');
    }
  }

  /// 导入所有数据
  static Future<Map<String, int>> importAll(ImportMode mode) async {
    try {
      final fileContent = await _pickAndReadFile();
      if (fileContent == null) return {};
      
      final data = jsonDecode(fileContent);
      _validateImportData(data, 'all');
      
      final results = <String, int>{};
      
      // 导入白名单
      if (data['data']['whitelists'] != null) {
        final whitelistsData = data['data']['whitelists'] as List;
        final whitelists = whitelistsData
            .map((json) => models.Whitelist.fromJson(json))
            .toList();
        
        int count = 0;
        for (final whitelist in whitelists) {
          if (mode == ImportMode.merge) {
            final exists = await WhitelistDao.containsPath(whitelist.path);
            if (exists) continue;
          }
          
          final newWhitelist = models.Whitelist(
            path: whitelist.path,
            type: whitelist.type,
            annotation: whitelist.annotation,
            readOnly: false,
          );
          
          final result = await WhitelistDao.add(newWhitelist);
          if (result != null) count++;
        }
        results['whitelists'] = count;
      }
      
      // 导入规则
      if (data['data']['rules'] != null) {
        final rulesData = data['data']['rules'] as List;
        final rules = rulesData
            .map((json) => models.Rule.fromJson(json))
            .toList();
        
        int count = 0;
        for (final rule in rules) {
          if (rule.isSystemRule) continue;
          
          if (mode == ImportMode.merge) {
            try {
              await RuleDao.getRuleGroupByName(rule.name);
              continue;
            } catch (e) {
              // 不存在，继续导入
            }
          }
          
          final newRuleGroup = await RuleDao.ensureRuleGroupExists(
            rule.name, 
            isSystemRule: false
          );
          
          for (final ruleItem in rule.rules) {
            final newRuleItem = models.RuleItem(
              path: ruleItem.path,
              pathMatchType: ruleItem.pathMatchType,
              actionType: ruleItem.actionType,
              priority: ruleItem.priority,
              enabled: ruleItem.enabled,
              annotation: ruleItem.annotation,
              tags: ruleItem.tags,
            );
            
            await RuleDao.addRuleItemToGroup(newRuleGroup.name, newRuleItem);
            count++;
          }
        }
        results['rules'] = count;
      }
      
      // 导入路径标注
      if (data['data']['pathAnnotations'] != null) {
        final annotationsData = data['data']['pathAnnotations'] as List;
        final annotations = annotationsData
            .map((json) => models.PathAnnotation.fromJson(json))
            .toList();
        
        int count = 0;
        for (final annotation in annotations) {
          if (annotation.isBuiltIn) continue;
          
          if (mode == ImportMode.merge) {
            final existing = await PathAnnotationDao.getByPath(annotation.path);
            if (existing != null) continue;
          }
          
          final newAnnotation = models.PathAnnotation(
            path: annotation.path,
            description: annotation.description,
            suggestDelete: annotation.suggestDelete,
            pathMatchType: annotation.pathMatchType,
            isBuiltIn: false,
          );
          
          final result = await PathAnnotationDao.add(newAnnotation);
          if (result != null) count++;
        }
        results['pathAnnotations'] = count;
      }
      
      return results;
    } catch (e) {
      throw Exception('导入所有数据失败: $e');
    }
  }

  /// 保存内容到文件
  static Future<String> _saveToFile(String content, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(path.join(directory.path, fileName));
      await file.writeAsString(content);
      return file.path;
    } catch (e) {
      throw Exception('保存文件失败: $e');
    }
  }

  /// 选择并读取文件
  static Future<String?> _pickAndReadFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      
      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        return await file.readAsString();
      }
      
      return null;
    } catch (e) {
      throw Exception('读取文件失败: $e');
    }
  }

  /// 验证导入数据格式
  static void _validateImportData(Map<String, dynamic> data, String expectedType) {
    if (data['version'] == null) {
      throw Exception('无效的文件格式：缺少版本信息');
    }
    
    if (data['type'] == null) {
      throw Exception('无效的文件格式：缺少类型信息');
    }
    
    if (expectedType != 'all' && data['type'] != expectedType) {
      throw Exception('文件类型不匹配：期望 $expectedType，实际 ${data['type']}');
    }
    
    if (data['data'] == null) {
      throw Exception('无效的文件格式：缺少数据内容');
    }
  }
}