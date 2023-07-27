import 'package:audio_effect_test/screens/records/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_bar_item.dart';
import 'circle_button.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  RecordController controller = Get.find();

  Widget getButton() {
    if (controller.state.value == RecordState.ready) {
      return const Text(
        'Start',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else if (controller.state.value == RecordState.playing) {
      return const Icon(
        Icons.pause,
        color: Colors.white,
        size: 40,
      );
    } else {
      return const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BottomBarItem(
          icon: Icons.refresh,
          title: 'Reset',
          callback: controller.resetButtonTap,
        ),
        BottomBarItem(
          icon: Icons.volume_up,
          title: 'Volume',
          callback: () {},
        ),
        CircularButton(
          onPressed: controller.mainButtonTap,
          child: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: getButton()),
        ),
        BottomBarItem(
          icon: Icons.mic,
          title: 'Mic',
          callback: () {},
        ),
        BottomBarItem(
          icon: Icons.equalizer,
          title: 'Effect',
          callback: () {},
        )
      ],
    );
  }
}
