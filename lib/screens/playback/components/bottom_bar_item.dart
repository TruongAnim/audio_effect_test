import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback callback;
  final bool hasBorder;
  const BottomBarItem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.callback,
      required this.hasBorder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: hasBorder ? Colors.pink : Colors.black,
                    width: 2.0, // Set the border width here
                  ),
                ),
                child: CircleAvatar(
                    radius: 20, backgroundImage: AssetImage(imagePath))),
            Text(
              title,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
