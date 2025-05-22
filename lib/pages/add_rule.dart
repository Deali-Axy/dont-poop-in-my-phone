import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart' as models;
import 'package:flutter/material.dart';

// This enum needs to align with models.ActionType and models.PathMatchType for UI logic
// Or better, derive UI choices directly from those models if possible.
// For now, keeping it simple, but this is a point for future refactoring.
enum AppRuleType { whileList, delete, deleteAndReplace }

class AppRuleTypeItem {
  AppRuleType ruleType;
  String verboseName;
  IconData icon;
  models.ActionType? actionType; // For mapping to actual ActionType

  AppRuleTypeItem(this.ruleType, this.verboseName, this.icon, {this.actionType});
}

class AddRulePage extends StatefulWidget {
  final String initialPath; // Renamed for clarity
  final models.RuleItem? ruleItemToEdit; // Added for editing

  const AddRulePage({required this.initialPath, this.ruleItemToEdit, Key? key}) : super(key: key);

  @override
  _AddRulePageState createState() => _AddRulePageState();
}

class _AddRulePageState extends State<AddRulePage> {
  late TextEditingController _pathController; // For path input
  late TextEditingController _annotationController;
  
  // UI state for selecting rule properties
  AppRuleType? _selectedAppRuleType; // For the RadioListTile
  models.PathMatchType _selectedPathMatchType = models.PathMatchType.exact; // Default
  int _priority = 0;
  // enabled state will be part of ruleItemToEdit or default to true for new items

  final List<bool> _expandedStatusList = [true, true, true, true]; // Added one for PathMatchType & Priority
  
  // UI representation of rule types. This mapping needs care.
  final List<AppRuleTypeItem> _appRuleTypeList = [
    AppRuleTypeItem(AppRuleType.whileList, '白名单', Icons.shield_outlined), // Whitelist is handled separately now usually
    AppRuleTypeItem(AppRuleType.deleteAndReplace, '删除并替换为空文件', Icons.find_replace_rounded, actionType: models.ActionType.deleteAndReplace),
    AppRuleTypeItem(AppRuleType.delete, '仅删除目录/文件', Icons.delete_outline_rounded, actionType: models.ActionType.delete),
    // Consider adding deleteFolder, deleteFile specific options if AppRuleType is to be fine-grained
  ];

  final List<Map<String, dynamic>> _pathMatchTypeList = [
    {'type': models.PathMatchType.exact, 'name': '精确路径', 'icon': Icons.folder_outlined, 'description': '完全匹配指定路径'},
    {'type': models.PathMatchType.fuzzy, 'name': '模糊匹配', 'icon': Icons.folder_special_outlined, 'description': '匹配相似的路径'},
    {'type': models.PathMatchType.regex, 'name': '正则表达式', 'icon': Icons.code_rounded, 'description': '使用正则表达式匹配路径'},
  ];

  bool get _isEditMode => widget.ruleItemToEdit != null;

  @override
  void initState() {
    super.initState();
    _pathController = TextEditingController(text: widget.initialPath);
    _annotationController = TextEditingController();

    if (_isEditMode) {
      final item = widget.ruleItemToEdit!;
      _pathController.text = item.path;
      _annotationController.text = item.annotation;
      _selectedPathMatchType = item.pathMatchType;
      _priority = item.priority;
      // Map back from item.actionType to _selectedAppRuleType
      // This logic depends on how AppRuleType maps to ActionType
      _selectedAppRuleType = _appRuleTypeList.firstWhere(
          (art) => art.actionType == item.actionType, 
          orElse: () => _appRuleTypeList.first // Fallback, should not happen if mapping is correct
      ).ruleType;
      // Note: Whitelist case is not handled by this page anymore if it's a separate flow.
      // If AddRulePage is *only* for RuleItems, then AppRuleType.whileList should be removed.
    } else {
        // Default for new rule if applicable (e.g. preselect delete type)
        // _selectedAppRuleType = AppRuleType.delete;
    }
  }

 @override
  void dispose() {
    _pathController.dispose();
    _annotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '编辑规则' : '添加规则'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle_rounded),
            onPressed: _saveRule, // Changed to a method
            tooltip: '保存规则',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Future<void> _saveRule() async {
    final String path = _pathController.text.trim();
    final String annotation = _annotationController.text.trim();

    if (path.isEmpty) {
      BotToast.showText(text: '路径不能为空！');
      return;
    }

    if (_selectedAppRuleType == null) {
      BotToast.showText(text: '请选择规则类型！');
      return;
    }

    // Whitelist Handling (if this page still manages it)
    if (_selectedAppRuleType == AppRuleType.whileList) {
      if (_isEditMode) {
        // Whitelist edit logic would go here - needs WhitelistDao.update
        BotToast.showText(text: '白名单编辑功能暂未实现');
        return;
      }
      final newWhitelist = await WhitelistDao.addPath(path, annotation: annotation, type: models.WhitelistType.path);
      if (newWhitelist != null) {
        BotToast.showText(text: '已添加到白名单');
        Navigator.of(context).pop(true); // Indicate success
      } else {
        BotToast.showText(text: '添加到白名单失败（可能已存在）');
      }
      return;
    }

    // RuleItem Handling
    final selectedAppRuleTypeItem = _appRuleTypeList.firstWhere((art) => art.ruleType == _selectedAppRuleType);
    if (selectedAppRuleTypeItem.actionType == null) {
      BotToast.showText(text: '选择的规则类型无效');
      return;
    }

    final ruleItem = models.RuleItem(
      id: _isEditMode ? widget.ruleItemToEdit!.id : null,
      ruleId: _isEditMode ? widget.ruleItemToEdit!.ruleId : null, // ruleId needs to be set for new items if not default group
      path: path,
      pathMatchType: _selectedPathMatchType,
      actionType: selectedAppRuleTypeItem.actionType!,
      annotation: annotation,
      priority: _priority,
      enabled: _isEditMode ? widget.ruleItemToEdit!.enabled : true, // Default to enabled for new rules
      triggerCount: _isEditMode ? widget.ruleItemToEdit!.triggerCount : 0,
      // lastTriggeredAt is not usually set here
    );

    try {
      if (_isEditMode) {
        await RuleDao.updateRuleItem(ruleItem);
        BotToast.showText(text: '规则已更新');
      } else {
        // Assume adding to custom rule group for now
        await RuleDao.addRuleItemToGroup(models.Rule.customRuleName, ruleItem);
        BotToast.showText(text: '规则已添加');
      }
      Navigator.of(context).pop(true); // Indicate success
    } catch (e) {
      BotToast.showText(text: '操作失败: $e');
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPathSection(),
          SizedBox(height: 16),
          _buildRuleTypeSection(),
          SizedBox(height: 16),
          _buildMatchingAndPrioritySection(),
          SizedBox(height: 16),
          _buildAnnotationSection(),
          SizedBox(height: 32),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildPathSection() {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(Icons.folder_open_rounded, '目标路径'),
            SizedBox(height: 16),
            TextField(
              controller: _pathController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: '输入目标路径',
                prefixIcon: Icon(Icons.folder_outlined),
                hintText: '例如：/data/app/...',
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              maxLines: 2,
              minLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleTypeSection() {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(Icons.settings_applications_outlined, '规则类型（操作）'),
            SizedBox(height: 8),
            ..._appRuleTypeList.map((e) {
              return RadioListTile<AppRuleType>(
                title: Row(
                  children: [
                    Icon(e.icon, size: 22, color: Theme.of(context).colorScheme.secondary),
                    SizedBox(width: 12),
                    Text(e.verboseName),
                  ],
                ),
                value: e.ruleType,
                groupValue: _selectedAppRuleType,
                onChanged: (AppRuleType? value) {
                  setState(() {
                    _selectedAppRuleType = value;
                  });
                },
                activeColor: Theme.of(context).colorScheme.primary,
                selected: _selectedAppRuleType == e.ruleType,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchingAndPrioritySection() {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(Icons.compare_arrows_outlined, '路径匹配方式与优先级'),
            SizedBox(height: 16),
            Text('路径匹配方式:', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            _buildPathMatchTypeSelector(),
            SizedBox(height: 20),
            Text('优先级 (数字越大越高):', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            _buildPriorityInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildPathMatchTypeSelector() {
    return Column(
      children: _pathMatchTypeList.map((option) {
        return RadioListTile<models.PathMatchType>(
          title: Row(
            children: [
              Icon(option['icon'], size: 22, color: Theme.of(context).colorScheme.secondary),
              SizedBox(width: 12),
              Text(option['name']),
            ],
          ),
          subtitle: Text(
            option['description'],
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          value: option['type'],
          groupValue: _selectedPathMatchType,
          onChanged: (models.PathMatchType? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedPathMatchType = newValue;
              });
            }
          },
          activeColor: Theme.of(context).colorScheme.primary,
          selected: _selectedPathMatchType == option['type'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        );
      }).toList(),
    );
  }

  Widget _buildPriorityInput() {
    return Row(
      children: [
        Icon(Icons.priority_high_rounded, size: 22, color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            initialValue: _priority.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: '输入数字，默认为0',
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            onChanged: (value) {
              setState(() {
                _priority = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnnotationSection() {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(Icons.comment_outlined, '标注（可选）'),
            SizedBox(height: 16),
            TextField(
              controller: _annotationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: '输入标注信息',
                hintText: '为此规则添加注解说明...',
                prefixIcon: Icon(Icons.short_text_rounded),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.save_rounded),
        label: Text(_isEditMode ? '保存修改' : '创建规则'),
        onPressed: _saveRule,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
