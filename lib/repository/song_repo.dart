import 'dart:io';

import 'package:audio_effect_test/models/record.dart';
import 'package:audio_effect_test/models/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SongRepo {
  static final SongRepo _instance = SongRepo._();
  static SongRepo get instance => _instance;
  SongRepo._();

  final List<Song> _data = [
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
  ];

  List<Song> getAllSongs() {
    return _data;
  }

  Song getSongFromid(String id) {
    return _data.firstWhere((element) {
      print(element);
      print(id);
      return element.id == id;
    });
  }
}
