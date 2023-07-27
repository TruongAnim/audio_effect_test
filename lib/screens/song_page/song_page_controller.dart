import 'package:audio_effect_test/models/song.dart';
import 'package:get/get.dart';

class SongPageController extends GetxController {
  RxList<Song> songs = RxList<Song>([
    Song(
        id: '1',
        name: 'Bản tình ca không hoàn thiện',
        auther: 'Tây nguyên sound',
        url: 'assets/videos/videoplayback.mp4',
        thumbnail:
            'https://i.ytimg.com/vi/6ZZj5AO_z_s/hqdefault.jpg?sqp=-oaymwEcCOADEI4CSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCe3fAlbbklmYZpseP-Rft6fVSRtg'),
    Song(
        id: '2',
        name: 'Có chàng trai viết lên cây',
        auther: 'Phan Mạnh Quỳnh',
        url: 'assets/videos/videoplayback2.mp4',
        thumbnail:
            'https://i.ytimg.com/vi/0VC6euBtKkk/hq720.jpg?sqp=-oaymwEcCOgCEMoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDlJGWBKaNSORNX0phm70reUioPuQ'),
    Song(
        id: '3',
        name: 'Sao cha không',
        auther: 'Phan Mạnh Quỳnh',
        url: 'assets/videos/videoplayback3.mp4',
        thumbnail:
            'https://i.ytimg.com/vi/TD7sBUigDIU/hq720.jpg?sqp=-oaymwEcCOgCEMoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBfz52oSareoHqHyyYT1P3ilG7drw'),
  ]);

  void toRecordPage(Song song) {
    Get.toNamed('record_screen', arguments: song);
  }
}
