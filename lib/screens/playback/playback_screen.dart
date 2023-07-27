import 'package:audio_effect_test/constants/colors.dart';
import 'package:audio_effect_test/screens/lyric/lyric_widget.dart';
import 'package:audio_effect_test/screens/playback/playback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'components/bottom_bar.dart';
import 'components/header.dart';
import 'components/player.dart';

class PlaybackScreen extends StatefulWidget {
  const PlaybackScreen({super.key});
  @override
  State<PlaybackScreen> createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen> {
  PlaybackController controller = Get.find();

  @override
  void initState() {
    super.initState();
    String path = Get.arguments;
    controller.setAudioPath(path);
    controller.loadData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        body: SafeArea(
          child: Column(children: [
            const Header(),
            controller.state.value != PlaybackState.loading
                ? AspectRatio(
                    aspectRatio: controller.videoPlayer.value.aspectRatio,
                    child: VideoPlayer(controller.videoPlayer),
                  )
                : SizedBox(
                    height: h * 0.2,
                    child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
            const Player(),
            Spacer(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                SizedBox(width: 15),
                Text(
                  'Sound effects',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ],
            ),
            BottomBar(),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
