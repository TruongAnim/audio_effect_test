import 'package:audio_effect_test/components/timer_widget.dart';
import 'package:audio_effect_test/constants/colors.dart';
import 'package:audio_effect_test/models/song.dart';
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
  void initState() {
    super.initState();
    Song song = Get.arguments as Song;
    controller.initSong(song);
  }

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
                controller.state.value != RecordState.loading
                    ? AspectRatio(
                        aspectRatio: controller.videoPlayer.value.aspectRatio,
                        child: VideoPlayer(controller.videoPlayer),
                      )
                    : SizedBox(
                        height: h * 0.2,
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                const SizedBox(height: 15),
                SizedBox(
                  height: h * 0.4,
                  child: const LyricWidget(),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    TimerWidget(
                      duration: controller.position.value,
                      color: Colors.white.withOpacity(0.8),
                      isRecord: true,
                    )
                  ],
                ),
                BottomBar(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
