import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoading(
  BuildContext context, {
  String text = '请稍等',
  double width = 200.0,
  double height = 160.0,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // 点击遮罩不关闭对话框
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        content: buildLoading(context, text: text, width: width, height: height),
      );
    },
  );
}

Widget buildLoading(
  BuildContext context, {
  String text = '正在加载~',
  double width = 200.0,
  double height = 160.0,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: SpinKitFadingCube(
            color: Theme.of(context).colorScheme.primary,
            size: 30.0,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        )
      ],
    ),
  );
}