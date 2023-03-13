import 'package:flutter/material.dart';

enum RuleType { whileList, delete, deleteAndReplace }

class AddRulePage extends StatefulWidget {
  const AddRulePage({Key? key}) : super(key: key);

  @override
  _AddRulePageState createState() => _AddRulePageState();
}

class _AddRulePageState extends State<AddRulePage> {
  RuleType? _ruleType;
  final List<bool> _expandedStatusList = [true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加规则'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => {},
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
            return ListTile(title: Text('文件/目录信息'));
          },
          body: ListTile(
            title: Text('路径'),
          ),
        ),
        ExpansionPanel(
          isExpanded: _expandedStatusList[1],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: Text('规则类型'));
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
      children: [
        RadioListTile<RuleType>(
          title: const Text('白名单'),
          value: RuleType.whileList,
          groupValue: _ruleType,
          onChanged: (RuleType? value) {
            setState(() {
              _ruleType = value;
            });
          },
        ),
        RadioListTile<RuleType>(
          title: const Text('deleteAndReplace'),
          value: RuleType.deleteAndReplace,
          groupValue: _ruleType,
          onChanged: (RuleType? value) {
            setState(() {
              _ruleType = value;
            });
          },
        ),
        RadioListTile<RuleType>(
          title: const Text('delete'),
          value: RuleType.delete,
          groupValue: _ruleType,
          onChanged: (RuleType? value) {
            setState(() {
              _ruleType = value;
            });
          },
        ),
      ],
    );
  }
}
