import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:flutter/material.dart';

class RulePage extends StatelessWidget {
  const RulePage({Key? key}) : super(key: key);

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
    var rule = Rule(name: Rule.defaultRuleName, rules: []);
    for (var item in Global.appConfig.ruleList) {
      if (item.name == Rule.defaultRuleName) {
        rule = item;
      }
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
