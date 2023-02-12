import 'package:flutter/material.dart';

Widget buildDeleteDialog(BuildContext context, {String title = '删除目录', String content = '删除后不能恢复'}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('取消', style: TextStyle(color: Colors.red)),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('确定'),
      ),
    ],
  );
}

Future<bool> showDeleteDialog(BuildContext context, {String title = '删除目录', String content = '删除后不能恢复'}) async {
  var result = await showDialog<bool>(
    context: context,
    builder: (context) => buildDeleteDialog(context, title: title, content: content),
  );

  return result ?? false;
}
