import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';

class RulePage extends StatefulWidget {
  const RulePage({Key? key}) : super(key: key);

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('清理规则')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('自动清理'),
        icon: const Icon(Icons.cleaning_services_rounded),
      ),
    );
  }

  Widget _buildBody() {
    var rule = RuleDao.getDefault();

    if (rule.rules.isEmpty) {
      return Empty(
        content: '没有清理规则',
        buttonText: '返回',
        onButtonPressed: () => Navigator.of(context).pop(),
      );
    }

    return ListView(
      children: rule.rules.map((e) {
        return ListTile(
          title: Text(e.path),
          subtitle: Text(e.actionType.toString()),
        );
      }).toList(),
    );
  }
}
