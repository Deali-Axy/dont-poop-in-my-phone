import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:dont_poop_in_my_phone/common/time.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
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
        var time = DateTimeBeautifier(item.time);

        const double iconSize = 40;
        Widget icon;
        switch (item.actionType) {
          case ActionType.delete:
            icon = Icon(Icons.delete_outline, size: iconSize);
            break;
          case ActionType.deleteAndReplace:
            icon = Icon(Icons.do_not_disturb, size: iconSize);
            break;
          default:
            icon = Icon(Icons.question_mark, size: iconSize);
            break;
        }

        return Card(
          child: ListTile(
            leading: icon,
            title: Text(item.name),
            subtitle: Text(item.path),
            trailing: Text(time.shortDateTime),
          ),
        );
      }).toList(),
    );
  }
}
