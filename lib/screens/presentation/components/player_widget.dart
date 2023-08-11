import 'package:audio_effect_test/screens/presentation/components/presentation_header.dart';
import 'package:audio_effect_test/screens/presentation/components/presentation_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../presentation_controller.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PresentationController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          children: [
            if (controller.state.value == PresentationState.loading)
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
            else if (controller.state.value == PresentationState.ready)
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
            Positioned(
              top: 0 ,
              left: 16,
              right: 16,
              child: Center(child: PresentationHeader()),
            ),
          ],
        ),
        const PresentationPlayer(),
        Spacer(),
      ],
    );
  }
}
