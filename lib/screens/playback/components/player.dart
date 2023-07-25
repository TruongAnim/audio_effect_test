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
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 25,
      ),
      onTap: controller.play,
    );
  }

  iconPause() {
    return GestureDetector(
      child: const Icon(
        Icons.pause,
        color: Colors.white,
        size: 25,
      ),
      onTap: controller.pause,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Obx(
      () {
        print(controller.state.value);
        return Container(
          height: h * 0.07,
          child: Row(children: [
            const SizedBox(
              width: 5,
            ),
            controller.state.value == VideoState.ready ||
                    controller.state.value == VideoState.pause
                ? iconPlay()
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
                value: 0,
                max: 100,
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
