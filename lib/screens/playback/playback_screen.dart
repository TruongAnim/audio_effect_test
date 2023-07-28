import 'package:audio_effect_test/constants/colors.dart';
import 'package:audio_effect_test/screens/playback/playback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'components/bottom_bar.dart';
import 'components/header.dart';
import 'components/playback_player.dart';

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
            if (controller.state.value == PlaybackState.loading)
              Stack(children: [
                Image.network(
                  controller.song.value!.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: h * 0.3,
                  width: double.infinity,
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ])
            else if (controller.state.value == PlaybackState.ready)
              Stack(children: [
                Image.network(
                  controller.song.value!.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ])
            else
              AspectRatio(
                aspectRatio: controller.videoPlayer.value.aspectRatio,
                child: VideoPlayer(controller.videoPlayer),
              ),
            const PlaybackPlayer(),
            const Spacer(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
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
