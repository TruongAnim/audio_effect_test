import 'package:audio_effect_test/models/record.dart';
import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/repository/record_repo.dart';
import 'package:audio_effect_test/screens/playback/effect_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

enum PlaybackState { loading, ready, playing, pause, stop }

class PlaybackController extends GetxController {
  String? audioPath;
  Rx<PlaybackState> state = Rx<PlaybackState>(PlaybackState.loading);
  Rx<Song?> song = Rx<Song?>(null);
  Rx<Duration> position = Rx<Duration>(Duration.zero);
  Rx<Duration> duration = Rx<Duration>(Duration.zero);

  bool isPlayAudio = true;
  bool isPlayVideo = true;

  late AudioPlayer audioPlayer;
  late VideoPlayerController videoPlayer;

  void loadData() {
    song.value = Get.arguments['song'];
    audioPath = Get.arguments['audio'];
    state.value = PlaybackState.loading;
    initPlayer();
    videoPlayer = VideoPlayerController.asset(song.value!.url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        state.value = PlaybackState.ready;
      });
  }

  Future<void> initPlayer() async {
    EffectController effectController = Get.find();
    audioPlayer = await effectController.init(audioPath!);
    duration.value = audioPlayer.duration!;
    // audioPlayer.setPitch(1.1);

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        done();
      }
    });
    audioPlayer.positionStream.listen((event) {
      position.value = event;
    });
  }

  @override
  void onClose() {
    videoPlayer.dispose();
    audioPlayer.dispose();
    super.onClose();
  }

  void play() {
    if (isPlayVideo) {
      videoPlayer.play();
    }
    if (isPlayAudio) {
      audioPlayer.play();
    }
    state.value = PlaybackState.playing;
  }

  void pause() {
    if (isPlayVideo) {
      videoPlayer.pause();
    }
    if (isPlayAudio) {
      audioPlayer.pause();
    }
    state.value = PlaybackState.pause;
  }

  void done() {
    if (isPlayVideo) {
      videoPlayer.pause();
    }
    state.value = PlaybackState.stop;
  }

  mainButtonTap() {
    if (state.value == PlaybackState.ready) {
      play();
    } else if (state.value == PlaybackState.playing) {
      pause();
    } else if (state.value == PlaybackState.pause) {
      play();
    }
  }

  replay() {
    state.value = PlaybackState.playing;
    if (isPlayAudio) {
      audioPlayer.seek(Duration.zero);
    }
    if (isPlayVideo) {
      videoPlayer.seekTo(Duration.zero);
      videoPlayer.play();
    }
  }

  void clearState() {
    state.value = PlaybackState.stop;
    videoPlayer.pause();
    videoPlayer.dispose();
    audioPlayer.pause();
    audioPlayer.dispose();
  }

  void back() {
    Get.back();
  }

  // Future<String> applyEffect() async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final outputPath = path.join( appDocDir.path,DateTime.now().millisecondsSinceEpoch.toString()+'.mp3');
  //   print(outputPath);

  //   await audioPlayer.(
  //       path: outputPath, format: PlayerDataFormat.asset);
  // }

  void save() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    Record record = Record(
        id: '',
        idSong: song.value!.id,
        name: 'Record ${formatted}',
        audio: audioPath!,
        volumeSong: 1,
        volumeRecord: 1);
    RecordRepo.instance.uploadRecord(record);
    Get.offAllNamed('/home_screen');
  }
}
