import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String content;
  final bool isShowButton;
  final String buttonText;
  final Function onButtonPressed;

  const Empty({
    @required this.content,
    @required this.isShowButton,
    this.buttonText,
    this.onButtonPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_outlined, size: 120),
          SizedBox(height: 15),
          Text(content, style: TextStyle(fontSize: 20)),
          SizedBox(height: 15),
          if (isShowButton) OutlinedButton(child: Text(buttonText), onPressed: onButtonPressed),
        ],
      ),
    );
  }
}
