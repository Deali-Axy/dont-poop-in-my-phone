import 'package:flutter/material.dart';

class AddRulePage extends StatefulWidget {
  const AddRulePage({Key? key}) : super(key: key);

  @override
  _AddRulePageState createState() => _AddRulePageState();
}

class _AddRulePageState extends State<AddRulePage> {
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
    return Container();
  }
}
