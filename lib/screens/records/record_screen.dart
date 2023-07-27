import 'package:audio_effect_test/constants/colors.dart';
import 'package:audio_effect_test/screens/lyric/lyric_widget.dart';
import 'package:audio_effect_test/screens/records/components/bottom_bar.dart';
import 'package:audio_effect_test/screens/records/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'components/header.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  RecordController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Obx(
      () {
        return Scaffold(
          backgroundColor: ColorPalette.backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                const Header(),
                controller.state.value != VideoState.loading
                    ? AspectRatio(
                        aspectRatio:
                            controller.playerController.value.aspectRatio,
                        child: VideoPlayer(controller.playerController),
                      )
                    : SizedBox(
                        height: h * 0.2,
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                SizedBox(height: 15),
                Container(
                  height: h * 0.35,
                  child: LyricWidget(),
                ),
                Spacer(),
                BottomBar(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
