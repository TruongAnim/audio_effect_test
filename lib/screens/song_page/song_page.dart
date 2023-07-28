import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/screens/song_page/song_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/song_item.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  SongPageController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        List<Song> songs = controller.songs;
        return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) => SongItem(song: songs[index]));
      }),
    );
  }
}
