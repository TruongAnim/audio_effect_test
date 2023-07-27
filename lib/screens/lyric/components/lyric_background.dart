import 'dart:ui';

import 'package:flutter/material.dart';

class LyricBackground extends StatelessWidget {
  const LyricBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Positioned.fill(
      //   child: Image.asset(
      //     "assets/bg.jpeg",
      //     fit: BoxFit.cover,
      //   ),
      // ),
      // Positioned.fill(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //     child: Container(
      //       color: Colors.black.withOpacity(0.3),
      //     ),
      //   ),
      // )
    ]);
  }
}
