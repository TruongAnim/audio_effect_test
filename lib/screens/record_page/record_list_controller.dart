import 'package:audio_effect_test/models/record.dart';
import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/repository/record_repo.dart';
import 'package:audio_effect_test/repository/song_repo.dart';
import 'package:get/get.dart';

class RecordListController extends GetxController {
  RxList<Record> records = RxList<Record>([]);

  void initData() {
    records.bindStream(RecordRepo.instance.getAllRecords());
  }

  Song getSongFromId(String id) {
    return SongRepo.instance.getSongFromid(id);
  }
}
