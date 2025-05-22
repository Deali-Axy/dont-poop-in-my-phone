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
    return FutureBuilder<Rule>(
      future: RuleDao.getDefault(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Empty(
            content: '加载规则失败',
            buttonText: '返回',
            onButtonPressed: () => Navigator.of(context).pop(),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.rules.isEmpty) {
          return Empty(
            content: '没有清理规则',
            buttonText: '返回',
            onButtonPressed: () => Navigator.of(context).pop(),
          );
        }
        
        final rule = snapshot.data!;
        return ListView(
          children: rule.rules.map((e) {
            return ListTile(
              title: Text(e.path),
              subtitle: Text('${e.actionType}\n${e.annotation}'),
            );
          }).toList(),
        );
      },
    );
  }
}
