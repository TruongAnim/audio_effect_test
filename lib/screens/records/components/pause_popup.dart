import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PausePopup extends StatelessWidget {
  PausePopup();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Result'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
