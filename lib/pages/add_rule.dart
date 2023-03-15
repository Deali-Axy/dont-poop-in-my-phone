import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
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
  late TextEditingController _controller;
  RuleType? _ruleType;
  final List<bool> _expandedStatusList = [true, true, true];
  final List<RuleTypeItem> _rulelist = [
    RuleTypeItem(RuleType.whileList, '白名单'),
    RuleTypeItem(RuleType.deleteAndReplace, '删除和替换'),
    RuleTypeItem(RuleType.delete, '仅删除'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加规则'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              var rule = RuleDao.getDefault();

              if (_ruleType == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('请选择规则类型！'),
                  action: SnackBarAction(label: '知道啦', onPressed: () {}),
                ));
                return;
              }

              switch (_ruleType) {
                case RuleType.whileList:
                  WhitelistDao.addPath(widget.path);
                  Navigator.of(context).pop('已经把 ${widget.path} 添加到白名单~');
                  break;
                case RuleType.delete:
                  RuleDao.add(Rule.defaultRuleName, RuleItem(path: widget.path, actionType: ActionType.delete));
                  Navigator.of(context).pop('已经为 ${widget.path} 添加自动删除规则~');
                  break;
                case RuleType.deleteAndReplace:
                  RuleDao.add(Rule.defaultRuleName, RuleItem(path: widget.path, actionType: ActionType.deleteAndReplace));
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
        ExpansionPanel(
          isExpanded: _expandedStatusList[2],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('标注', style: panelTitleStyle));
          },
          body: _buildAnnotationPanel(),
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
      children: _rulelist.map((e) {
        return RadioListTile<RuleType>(
          title: Text(e.verboseName),
          value: e.ruleType,
          groupValue: _ruleType,
          onChanged: (RuleType? value) {
            setState(() {
              _ruleType = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildAnnotationPanel() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: '请输入标注',
        ),
        onSubmitted: (String value) async {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Thanks!'),
                content: Text('You typed "$value", which has length ${value.characters.length}.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
