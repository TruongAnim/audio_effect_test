import 'package:audio_effect_test/models/record.dart';
import 'package:audio_effect_test/models/song.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

enum PresentationState { loading, ready, playing, pause, stop }

class PresentationController extends GetxController {
  Rx<PresentationState> state =
      Rx<PresentationState>(PresentationState.loading);
  Rx<Song?> song = Rx<Song?>(null);
  Rx<Record?> record = Rx<Record?>(null);
  Rx<Duration> position = Rx<Duration>(Duration.zero);
  Rx<Duration> duration = Rx<Duration>(Duration.zero);

  bool isPlayAudio = true;
  bool isPlayVideo = true;

  late AudioPlayer audioPlayer;
  late VideoPlayerController videoPlayer;

  @override
  void onInit() {
    super.onInit();
  }

  void loadData() {
    song.value = Get.arguments['song'];
    record.value = Get.arguments['record'];

    state.value = PresentationState.loading;
    initPlayer();
    videoPlayer = VideoPlayerController.asset(song.value!.url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        state.value = PresentationState.ready;
      });
  }

  Future<void> initPlayer() async {
    audioPlayer = AudioPlayer();
    await audioPlayer
        .setAudioSource(AudioSource.uri(Uri.https(record.value!.audio)));
    duration.value = audioPlayer.duration!;

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // done();
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
    state.value = PresentationState.playing;
  }

  void pause() {
    if (isPlayVideo) {
      videoPlayer.pause();
    }
    if (isPlayAudio) {
      audioPlayer.pause();
    }
    state.value = PresentationState.pause;
  }

  void done() {
    if (isPlayVideo) {
      videoPlayer.pause();
    }
    state.value = PresentationState.stop;
  }

  mainButtonTap() {
    if (state.value == PresentationState.ready) {
      play();
    } else if (state.value == PresentationState.playing) {
      pause();
    } else if (state.value == PresentationState.pause) {
      play();
    }
  }

  replay() {
    state.value = PresentationState.playing;
    if (isPlayAudio) {
      audioPlayer.seek(Duration.zero);
    }
    if (isPlayVideo) {
      videoPlayer.seekTo(Duration.zero);
      videoPlayer.play();
    }
  }

  void clearState() {
    state.value = PresentationState.stop;
    videoPlayer.pause();
    videoPlayer.dispose();
    audioPlayer.pause();
    audioPlayer.dispose();
  }
}
