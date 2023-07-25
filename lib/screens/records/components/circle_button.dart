import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  CircularButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => onPressed(),
      elevation: 2.0,
      fillColor: Colors.pink,
      child: child,
      padding: EdgeInsets.all(25.0),
      shape: CircleBorder(),
    );
  }
}
