import 'package:audio_effect_test/screens/playback/components/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

enum Effect { nature, studio, karaoke, borero, custom }

class EffectController extends GetxController {
  Rx<Effect> effect = Rx<Effect>(Effect.nature);
  Rx<double> loudness = Rx<double>(1);
  final _equalizer = AndroidEqualizer();
  final _loudnessEnhancer = AndroidLoudnessEnhancer();
  late final AudioPlayer _player = AudioPlayer(
    audioPipeline: AudioPipeline(
      androidAudioEffects: [
        _loudnessEnhancer,
        _equalizer,
      ],
    ),
  );

  Future<AudioPlayer> init(String path) async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _loudnessEnhancer.setEnabled(true);
    _equalizer.setEnabled(true);
    try {
      await _player.setAudioSource(AudioSource.file(path));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    return _player;
  }

  void natureTap() {
    if (effect.value != Effect.nature) {
      effect.value = Effect.nature;
      _loudnessEnhancer.setTargetGain(1.0);
      setEqualizer([0, 0, 0, 0, 0]);
    }
  }

  void studioTap() {
    if (effect.value != Effect.studio) {
      effect.value = Effect.studio;
      _loudnessEnhancer.setTargetGain(0.5);
      setEqualizer([1, -1, 0, -0.5, 0.5]);
    }
  }

  void karaokeTap() {
    print('karaokeTap');
    if (effect.value != Effect.karaoke) {
      effect.value = Effect.karaoke;
      _loudnessEnhancer.setTargetGain(-0.2);
      setEqualizer([-1, 1, 0, 0.5, -0.5]);
    }
  }

  void boreroTap() {
    if (effect.value != Effect.borero) {
      effect.value = Effect.borero;
      _loudnessEnhancer.setTargetGain(0.3);
    }
  }

  void customTap() {
    if (effect.value != Effect.custom) {
      effect.value = Effect.custom;
    } else {
      Get.bottomSheet(BotttomSheetWidget(
        loudness: _loudnessEnhancer,
        equalizer: _equalizer,
      ));
    }
  }

  void setEqualizer(List<double> bans) async {
    final parameter = await _equalizer.parameters;
    print('${parameter.minDecibels} ${parameter.maxDecibels}');
    for (int i = 0; i < bans.length; i++) {
      parameter.bands[i].setGain(bans[i]);
    }
  }
}
