import 'package:flutter/material.dart';

class StarTextButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback? onPressed;

  const StarTextButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: icon,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: icon.color ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
