import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/screens/playback/effect_controller.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

enum VideoState { loading, ready, playing, pause, stop }

class PlaybackController extends GetxController {
  String? audioPath;
  Rx<VideoState> state = Rx<VideoState>(VideoState.loading);
  Rx<Song?> song = Rx<Song?>(null);

  bool isPlayAudio = true;
  bool isPlayVideo = true;

  late AudioPlayer audioPlayer;
  late VideoPlayerController videoPlayer;

  void loadData() {
    getSong();
    initPlayer();
    videoPlayer = VideoPlayerController.asset(song.value!.url)
      ..initialize().then((_) {
        state.value = VideoState.ready;
        videoPlayer.setVolume(0);
      });
  }

  Future<void> initPlayer() async {
    EffectController effectController = Get.find();
    audioPlayer = await effectController.init(audioPath!);
    final duration = await audioPlayer.duration;
    print(duration);
    audioPlayer.setPitch(1.1);

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        done();
      }
    });
  }

  @override
  void onClose() {
    videoPlayer.dispose();
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
    if (isPlayVideo) {
      videoPlayer.play();
    }

    audioPlayer.play();
    state.value = VideoState.playing;
  }

  void pause() {
    if (isPlayVideo) {
      videoPlayer.pause();
    }
    audioPlayer.pause();
    state.value = VideoState.pause;
  }

  void done() {
    print('done');
    if (isPlayVideo) {
      videoPlayer.pause();
    }
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

  replay() {
    state.value = VideoState.playing;
    audioPlayer.seek(Duration.zero);
    videoPlayer.seekTo(Duration.zero);
  }

  void setAudioPath(String path) {
    audioPath = path;
  }

  void clearState() {
    print('clear state');
    state.value = VideoState.stop;
    videoPlayer.pause();
    videoPlayer.dispose();
    audioPlayer.pause();
    audioPlayer.dispose();
  }
}
