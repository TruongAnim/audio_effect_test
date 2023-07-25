import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/screens/playback/effect_controller.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

enum VideoState { loading, ready, playing, pause, stop }

class PlaybackController extends GetxController {
  String? audioPath;
  late final AudioPlayer audioPlayer;
  Rx<VideoState> state = Rx<VideoState>(VideoState.loading);
  late VideoPlayerController playerController;
  Rx<Song?> song = Rx<Song?>(null);

  void loadData() {
    getSong();
    initPlayer();
    playerController = VideoPlayerController.asset(song.value!.url)
      ..initialize().then((_) {
        state.value = VideoState.ready;
        playerController.setVolume(0);
      });
  }

  Future<void> initPlayer() async {
    EffectController effectController = Get.find();
    audioPlayer = await effectController.init(audioPath!);
    final duration = await audioPlayer.duration;
    print(duration);

    audioPlayer.setPitch(1.1);
  }

  @override
  void onClose() {
    playerController.dispose();
    audioPlayer.dispose();
    super.onClose();
  }

  void getSong() {
    song.value = Song(
        name: 'Bản tình ca không hoàn thiện',
        auther: 'Tây nguyên sound',
        url: 'assets/videos/videoplayback.mp4');
  }

  void play() {
    playerController.play();
    audioPlayer.play();
    state.value = VideoState.playing;
  }

  void pause() {
    playerController.pause();
    audioPlayer.pause();
    state.value = VideoState.pause;
  }

  void done() {
    playerController.pause();
    state.value = VideoState.stop;
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

  void setAudioPath(String path) {
    audioPath = path;
  }

  void clearState() {
    print('clear state');
    state.value = VideoState.stop;
    audioPlayer.pause();
    playerController.pause();
    playerController.dispose();
    audioPlayer.dispose();
  }
}
