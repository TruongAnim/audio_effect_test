import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/repository/song_repo.dart';
import 'package:get/get.dart';

class SongPageController extends GetxController {
  RxList<Song> songs = RxList<Song>();

  void initData() {
    songs.value = SongRepo.instance.getAllSongs();
  }

  void toRecordPage(Song song) {
    Get.toNamed('record_screen', arguments: song);
  }
}
