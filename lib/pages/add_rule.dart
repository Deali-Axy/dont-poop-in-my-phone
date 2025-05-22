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
  models.ActionType? actionType; // For mapping to actual ActionType

  AppRuleTypeItem(this.ruleType, this.verboseName, {this.actionType});
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
    AppRuleTypeItem(AppRuleType.whileList, '白名单'), // Whitelist is handled separately now usually
    AppRuleTypeItem(AppRuleType.deleteAndReplace, '删除并替换为空文件', actionType: models.ActionType.deleteAndReplace),
    AppRuleTypeItem(AppRuleType.delete, '仅删除目录/文件', actionType: models.ActionType.delete),
    // Consider adding deleteFolder, deleteFile specific options if AppRuleType is to be fine-grained
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
            icon: Icon(Icons.check),
            onPressed: _saveRule, // Changed to a method
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
    var panelTitleStyle = TextStyle(fontWeight: FontWeight.bold);
    var panels = ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedStatusList[index] = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _expandedStatusList[0],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('路径', style: panelTitleStyle));
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _pathController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '输入目标路径',
              ),
            ),
          ),
        ),
        ExpansionPanel(
          isExpanded: _expandedStatusList[1],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('规则类型 (操作)', style: panelTitleStyle));
          },
          body: _buildRuleTypePanel(), // Renamed
        ),
        ExpansionPanel(
          isExpanded: _expandedStatusList[2],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('路径匹配方式与优先级', style: panelTitleStyle));
          },
          body: _buildMatchingAndPriorityPanel(), // New Panel
        ),
        ExpansionPanel(
          isExpanded: _expandedStatusList[3],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('标注 (可选)', style: panelTitleStyle));
          },
          body: _buildAnnotationPanel(),
        ),
      ],
    );
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: panels,
      ),
    );
  }

  Widget _buildRuleTypePanel() { // Renamed and modified
    return Column(
      children: _appRuleTypeList.map((e) {
        // If this page no longer handles whitelist, filter it out.
        // For now, assuming it might, or for user clarity.
        // if (e.ruleType == AppRuleType.whileList && _isEditMode && widget.ruleItemToEdit != null) return SizedBox.shrink(); 

        return RadioListTile<AppRuleType>(
          title: Text(e.verboseName),
          value: e.ruleType,
          groupValue: _selectedAppRuleType,
          onChanged: (AppRuleType? value) {
            setState(() {
              _selectedAppRuleType = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildMatchingAndPriorityPanel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('路径匹配方式:', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<models.PathMatchType>(
            value: _selectedPathMatchType,
            isExpanded: true,
            items: models.PathMatchType.values.map((models.PathMatchType value) {
              return DropdownMenuItem<models.PathMatchType>(
                value: value,
                child: Text(value.toString().split('.').last), // Simple display name
              );
            }).toList(),
            onChanged: (models.PathMatchType? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedPathMatchType = newValue;
                });
              }
            },
          ),
          SizedBox(height: 20),
          Text('优先级 (数字越大越高):', style: TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            initialValue: _priority.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _priority = int.tryParse(value) ?? 0;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnnotationPanel() {
    return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _annotationController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: '输入标注信息',
        ),
        // onEditingComplete is handled by _saveRule now for controllers
      ),
    );
  }
}
