import 'dart:math';

import 'package:audio_effect_test/components/timer_widget.dart';
import 'package:audio_effect_test/screens/records/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordPlayer extends StatefulWidget {
  const RecordPlayer({super.key});

  @override
  State<RecordPlayer> createState() => _RecordPlayerState();
}

class _RecordPlayerState extends State<RecordPlayer> {
  RecordController controller = Get.find();

  iconPlay() {
    return GestureDetector(
      // onTap: controller.play,
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  iconPause() {
    return GestureDetector(
      // onTap: controller.pause,
      child: const Icon(
        Icons.pause,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  iconReload() {
    return GestureDetector(
      // onTap: controller.replay,
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
            controller.state.value == RecordState.ready ||
                    controller.state.value == RecordState.pause
                ? iconPlay()
                : controller.state.value == RecordState.stop
                    ? iconReload()
                    : iconPause(),
            const SizedBox(
              width: 10,
            ),
            TimerWidget(
              duration: controller.position.value,
              color: Colors.white.withOpacity(0.8),
              isRecord: false,
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
            TimerWidget(
              duration: controller.duration.value,
              color: Colors.white.withOpacity(0.8),
              isRecord: false,
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
