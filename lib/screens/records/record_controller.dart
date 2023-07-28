import 'package:audio_effect_test/models/song.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:record/record.dart';

enum RecordState { loading, ready, playing, pause, stop }

class RecordController extends GetxController {
  late VideoPlayerController videoPlayer;
  Rx<RecordState> state = Rx<RecordState>(RecordState.loading);
  Rx<Song?> song = Rx<Song?>(null);
  Rx<Duration> position = Rx<Duration>(Duration.zero);
  Rx<Duration> duration = Rx<Duration>(Duration.zero);

  String _appDirectoryPath = "";
  Record record = Record();

  void initSong(Song newSong) {
    state.value = RecordState.loading;
    song.value = newSong;
    _getAppDirectoryPath();
    videoPlayer = VideoPlayerController.asset(song.value!.url)
      ..initialize().then((_) {
        state.value = RecordState.ready;
      });
    videoPlayer.addListener(() async {
      position.value = (await videoPlayer.position)!;
    });
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayer.dispose();
    record.dispose();
  }

  void getSong() {
    song.value = Song(
        id: '1',
        name: 'Bản tình ca không hoàn thiện',
        auther: 'Tây nguyên sound',
        url: 'assets/videos/videoplayback.mp4',
        thumbnail: '');
  }

  void play() {
    print('play');
    videoPlayer.play();
    state.value = RecordState.playing;
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
    videoPlayer.pause();
    state.value = RecordState.pause;
    pauseRecording();
  }

  Future<void> pauseRecording() async {
    if (await record.isRecording()) {
      await record.pause();
    }
  }

  void done() {
    print('done');
    if (state.value == RecordState.pause) {
      state.value = RecordState.stop;
      stopRecording(true);
    }
  }

  Future<void> stopRecording(bool isDone) async {
    String? path = await record.stop();
    state.value = RecordState.ready;
    videoPlayer.pause();
    videoPlayer.seekTo(Duration.zero);
    if (isDone) {
      toPlaybackScreen(path!);
    }
  }

  void toPlaybackScreen(String path) async {
    await Get.toNamed('playback_screen',
        arguments: {'audio': path, 'song': song.value});
  }

  void mainButtonTap() {
    if (state.value == RecordState.ready) {
      play();
    } else if (state.value == RecordState.playing) {
      pause();
    } else if (state.value == RecordState.pause) {
      play();
    }
  }

  void doneButtonTap() {
    done();
  }

  void resetButtonTap() {
    stopRecording(false);
  }

  Future<void> _getAppDirectoryPath() async {
    try {
      var appDirectory = await getApplicationDocumentsDirectory();
      _appDirectoryPath = appDirectory.path;
    } catch (e) {
      print("Error getting application directory path: $e");
    }
  }

  void back() {
    Get.back();
  }
}
