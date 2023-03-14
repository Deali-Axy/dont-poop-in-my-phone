import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:flutter/material.dart';

enum RuleType { whileList, delete, deleteAndReplace }

class RuleTypeItem {
  RuleType ruleType;
  String verboseName;

  RuleTypeItem(this.ruleType, this.verboseName);
}

class AddRulePage extends StatefulWidget {
  final String path;

  const AddRulePage({required this.path, Key? key}) : super(key: key);

  @override
  _AddRulePageState createState() => _AddRulePageState();
}

class _AddRulePageState extends State<AddRulePage> {
  RuleType? _ruleType;
  final List<bool> _expandedStatusList = [true, true];
  final List<RuleTypeItem> _rulelist = [
    RuleTypeItem(RuleType.whileList, '白名单'),
    RuleTypeItem(RuleType.deleteAndReplace, '删除和替换'),
    RuleTypeItem(RuleType.delete, '仅删除'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加规则'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              var rule = _getDefaultRule();

              if (_ruleType == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('请选择规则类型！'),
                  action: SnackBarAction(label: '知道啦', onPressed: () {}),
                ));
                return;
              }

              switch (_ruleType) {
                case RuleType.whileList:
                  Global.appConfig.whiteList.add(widget.path);
                  Global.saveAppConfig();
                  Navigator.of(context).pop('已经把 ${widget.path} 添加到白名单~');
                  break;
                case RuleType.delete:
                  rule.rules.add(RuleItem(path: widget.path, actionType: ActionType.delete));
                  Global.saveAppConfig();
                  Navigator.of(context).pop('已经为 ${widget.path} 添加自动删除规则~');
                  break;
                case RuleType.deleteAndReplace:
                  rule.rules.add(RuleItem(path: widget.path, actionType: ActionType.deleteAndReplace));
                  Global.saveAppConfig();
                  Navigator.of(context).pop('已经为 ${widget.path} 添加自动删除且替换规则~');
                  break;
                default:
                  break;
              }
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Rule _getDefaultRule() {
    var rule = Rule(name: Rule.defaultRuleName, rules: []);
    for (var item in Global.appConfig.ruleList) {
      if (item.name == Rule.defaultRuleName) {
        rule = item;
        return rule;
      }
    }
    Global.appConfig.ruleList.add(rule);
    return rule;
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
            return ListTile(title: Text('文件/目录信息', style: panelTitleStyle));
          },
          body: ListTile(
            title: Text(widget.path),
          ),
        ),
        ExpansionPanel(
          isExpanded: _expandedStatusList[1],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('规则类型', style: panelTitleStyle));
          },
          body: _buildRulePanel(),
        ),
      ],
    );
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(5),
        child: panels,
      ),
    );
  }

  Widget _buildRulePanel() {
    return Column(
      children: _rulelist
          .map((e) => RadioListTile<RuleType>(
                title: Text(e.verboseName),
                value: e.ruleType,
                groupValue: _ruleType,
                onChanged: (RuleType? value) {
                  setState(() {
                    _ruleType = value;
                  });
                },
              ))
          .toList(),
    );
  }
}
