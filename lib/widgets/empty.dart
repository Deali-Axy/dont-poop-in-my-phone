import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String content;
  final String? buttonText;
  final Function? onButtonPressed;
  final IconData? icon;

  const Empty({
    required this.content,
    this.buttonText,
    this.onButtonPressed,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? Icons.error_outline_outlined, size: 100, color: Colors.grey[400]),
          SizedBox(height: 20),
          Text(
            content, 
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          if (buttonText != null && onButtonPressed != null)
            ElevatedButton.icon(
              icon: Icon(Icons.add_circle_outline),
              label: Text(buttonText!),
              onPressed: () => onButtonPressed!.call(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16)
              ),
            )
          else if (buttonText != null)
             OutlinedButton(child: Text(buttonText!), onPressed: () => onButtonPressed?.call()),
        ],
      ),
    );
  }
}
