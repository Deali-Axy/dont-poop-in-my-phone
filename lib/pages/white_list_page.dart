import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:flutter/material.dart';

class WhiteListPage extends StatefulWidget {
  const WhiteListPage({Key? key}) : super(key: key);

  @override
  _WhiteListPageState createState() => _WhiteListPageState();
}

class _WhiteListPageState extends State<WhiteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('白名单')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: Global.appConfig.whiteList.map((e) {
        return ListTile(
          title: Text(e),
        );
      }).toList(),
    );
  }
}
