import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showLoading(BuildContext context, {String text = '请稍等', double width = 250.0, double height = 150.0}) {
  showDialog(
    context: context,
    barrierDismissible: false, //点击遮罩不关闭对话框
    builder: (context) {
      return AlertDialog(
        content: buildLoading(context, text: text, width: width, height: height),
      );
    },
  );
}

Widget buildLoading(BuildContext context, {String text = '正在加载~', double width = 250.0, double height = 150.0}) {
  return SizedBox(
    height: height,
    width: width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50.0,
          height: 50.0,
          child: SpinKitFadingCube(color: Theme.of(context).primaryColor, size: 25.0),
        ),
        Container(
          child: Text(text),
        )
      ],
    ),
  );
}