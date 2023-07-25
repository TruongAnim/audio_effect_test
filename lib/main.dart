import 'package:audio_effect_test/screens/playback/effect_controller.dart';
import 'package:audio_effect_test/screens/playback/playback_controller.dart';
import 'package:audio_effect_test/screens/records/record_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/playback/playback_screen.dart';
import 'screens/records/record_controller.dart';

void main() {
  // runApp(const EditEffectsScreen());
  Get.put(RecordController());
  Get.put(PlaybackController());
  Get.put(EffectController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/record_screen',
      getPages: [
        GetPage(
          name: '/record_screen',
          page: () => RecordScreen(),
        ),
        GetPage(
          name: '/playback_screen',
          page: () => PlaybackScreen(),
        ),
      ],
    );
  }
}
