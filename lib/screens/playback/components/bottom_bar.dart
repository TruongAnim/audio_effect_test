import 'package:audio_effect_test/screens/playback/effect_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_bar_item.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  EffectController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomBarItem(
            imagePath: 'assets/images/nature.jpg',
            title: 'Nature',
            callback: controller.natureTap,
            hasBorder: controller.effect.value == Effect.nature,
          ),
          BottomBarItem(
            imagePath: 'assets/images/wave1.png',
            title: 'Studio',
            callback: controller.studioTap,
            hasBorder: controller.effect.value == Effect.studio,
          ),
          BottomBarItem(
            imagePath: 'assets/images/wave2.png',
            title: 'Karaoke',
            callback: controller.karaokeTap,
            hasBorder: controller.effect.value == Effect.karaoke,
          ),
          BottomBarItem(
            imagePath: 'assets/images/wave3.png',
            title: 'Borero',
            callback: controller.boreroTap,
            hasBorder: controller.effect.value == Effect.borero,
          ),
          BottomBarItem(
            imagePath: 'assets/images/equal.png',
            title: 'Custom',
            callback: controller.customTap,
            hasBorder: controller.effect.value == Effect.custom,
          )
        ],
      ),
    );
  }
}
