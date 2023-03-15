import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/dao/index.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';

class WhitelistPage extends StatefulWidget {
  const WhitelistPage({Key? key}) : super(key: key);

  @override
  _WhitelistPageState createState() => _WhitelistPageState();
}

class _WhitelistPageState extends State<WhitelistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('白名单')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (WhitelistDao.getAll().isEmpty) {
      return Empty(
        content: '没有白名单',
        buttonText: '返回',
        onButtonPressed: () => Navigator.of(context).pop(),
      );
    }

    return ListView(
      children: WhitelistDao.getAll().map((e) {
        return ListTile(
          title: Text(e.path),
          subtitle: Text(e.annotation),
        );
      }).toList(),
    );
  }
}
