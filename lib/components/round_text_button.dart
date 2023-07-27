import 'package:flutter/material.dart';

class RoundTextButton extends StatelessWidget {
  final String text;
  final bool isEnable;
  final VoidCallback onPressed;

  const RoundTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnable ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(4),
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
        disabledBackgroundColor: Colors.pink[100],
        disabledForegroundColor: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
