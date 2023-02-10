import 'package:flutter/material.dart';

class StarTextButton extends StatelessWidget {
  final Icon icon;
  final String text;

  StarTextButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [icon, VerticalDivider(width: 10), Text(text)],
      ),
    );
  }
}
