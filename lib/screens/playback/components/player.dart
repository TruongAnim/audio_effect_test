import 'dart:math';

import 'package:audio_effect_test/screens/playback/playback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  PlaybackController controller = Get.find();

  iconPlay() {
    return GestureDetector(
      onTap: controller.play,
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  iconPause() {
    return GestureDetector(
      onTap: controller.pause,
      child: const Icon(
        Icons.pause,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  iconReload() {
    return GestureDetector(
      onTap: controller.replay,
      child: const Icon(
        Icons.refresh,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Obx(
      () {
        double sliderMaxValue =
            controller.duration.value.inMilliseconds.toDouble();
        double sliderValue = min(
            controller.position.value.inMilliseconds.toDouble(),
            sliderMaxValue);

        return Container(
          height: h * 0.07,
          child: Row(children: [
            const SizedBox(
              width: 5,
            ),
            controller.state.value == VideoState.ready ||
                    controller.state.value == VideoState.pause
                ? iconPlay()
                : controller.state.value == VideoState.stop
                    ? iconReload()
                    : iconPause(),
            const SizedBox(
              width: 10,
            ),
            Text(
              '00:00',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
            ),
            Expanded(
              child: Slider(
                value: sliderValue,
                max: sliderMaxValue,
                min: 0,
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                onChanged: (double value) {},
              ),
            ),
            Text(
              '00:00',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
            ),
            const SizedBox(
              width: 10,
            ),
          ]),
        );
      },
    );
  }
}
