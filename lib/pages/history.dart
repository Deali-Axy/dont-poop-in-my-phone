import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('历史记录')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (Global.appConfig.history.length == 0) {
      return Empty(
        content: '没有历史记录',
        isShowButton: true,
        buttonText: '返回',
        onButtonPressed: () => Navigator.of(context).pop(),
      );
    }

    return ListView(
      children: Global.appConfig.history.map((item) {
        return Card(
          child: ListTile(
            title: Text(item.name),
            subtitle: Text(item.path),
            trailing: Text(item.time.toString()),
          ),
        );
      }).toList(),
    );
  }
}
