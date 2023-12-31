import 'package:audio_effect_test/screens/lyric/components/lyric_background.dart';
import 'package:audio_effect_test/screens/records/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'const.dart';

class LyricWidget extends StatefulWidget {
  const LyricWidget({super.key});

  @override
  State<LyricWidget> createState() => _LyricWidgetState();
}

class _LyricWidgetState extends State<LyricWidget> {
  RecordController recordController = Get.find();
  var lyricPadding = 40.0;
  AudioPlayer? audioPlayer;
  bool isTap = false;

  bool useEnhancedLrc = false;
  var lyricModel = LyricsModelBuilder.create()
      .bindLyricToMain(normalLyric)
      // .bindLyricToExt(transLyric)
      .getModel();
  var lyricUI = UINetease();

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
            height: mediaQueryData.size.height,
            width: mediaQueryData.size.width,
            child: const LyricBackground()),
        Obx(
          () => LyricsReader(
            padding: EdgeInsets.symmetric(horizontal: lyricPadding),
            model: lyricModel,
            position: recordController.position.value.inMilliseconds,
            lyricUi: lyricUI,
            playing: recordController.state.value == RecordState.playing,
            size: Size(double.infinity, MediaQuery.of(context).size.height / 2),
            emptyBuilder: () => Center(
              child: Text(
                "No lyrics",
                style: lyricUI.getOtherMainTextStyle(),
              ),
            ),
            selectLineBuilder: (progress, confirm) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // LyricsLog.logD("点击事件");
                        confirm.call();
                        setState(() {
                          // audioPlayer?.seek(Duration(milliseconds: progress));
                        });
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.green)),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.green),
                      height: 1,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    formatDuration(Duration(milliseconds: progress)),
                    style: const TextStyle(color: Colors.green),
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
