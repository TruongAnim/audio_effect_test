import 'package:audio_effect_test/models/song.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:record/record.dart';

enum VideoState { loading, ready, playing, pause, stop }

class RecordController extends GetxController {
  Rx<VideoState> state = Rx<VideoState>(VideoState.loading);
  late VideoPlayerController playerController;
  Rx<Song?> song = Rx<Song?>(null);

  String _appDirectoryPath = "";
  Record record = Record();
  @override
  void onInit() {
    super.onInit();
    getSong();
    _getAppDirectoryPath();
    playerController = VideoPlayerController.asset(song.value!.url)
      ..initialize().then((_) {
        state.value = VideoState.ready;
      });
  }

  @override
  void onClose() {
    super.onClose();
    playerController.dispose();
    record.dispose();
  }

  void getSong() {
    song.value = Song(
        name: 'Bản tình ca không hoàn thiện',
        auther: 'Tây nguyên sound',
        url: 'assets/videos/videoplayback.mp4');
  }

  void play() {
    print('play');
    playerController.play();
    state.value = VideoState.playing;
    startRecording();
  }

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      if (!await record.isRecording()) {
        print('new record job');
        String name = DateTime.now().toString();
        await record.start(
          path: '$_appDirectoryPath/$name.m4a',
        );
      } else {
        print('continue');
        await record.resume();
      }
    }
  }

  void pause() {
    print('pause');
    playerController.pause();
    state.value = VideoState.pause;
    pauseRecording();
  }

  Future<void> pauseRecording() async {
    if (await record.isRecording()) {
      await record.pause();
    }
  }

  void done() {
    print('done');
    if (state.value == VideoState.pause) {
      state.value = VideoState.stop;
      stopRecording();
    }
  }

  Future<void> stopRecording() async {
    String? path = await record.stop();
    print(path);
    await Get.toNamed('playback_screen', arguments: path!);
    state.value = VideoState.ready;
    playerController.seekTo(Duration.zero);
    playerController.pause();
  }

  mainButtonTap() {
    if (state.value == VideoState.ready) {
      play();
    } else if (state.value == VideoState.playing) {
      pause();
    } else if (state.value == VideoState.pause) {
      play();
    }
  }

  doneButtonTap() {
    done();
  }

  Future<void> _getAppDirectoryPath() async {
    try {
      var appDirectory = await getApplicationDocumentsDirectory();
      _appDirectoryPath = appDirectory.path;
    } catch (e) {
      print("Error getting application directory path: $e");
    }
  }
}
