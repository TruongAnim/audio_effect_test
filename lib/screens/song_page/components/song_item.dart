import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/screens/song_page/song_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gradient_button.dart';

class SongItem extends StatelessWidget {
  final Song song;
  const SongItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
          height: 60,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  song.thumbnail,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      song.name,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    Text(
                      '12 records',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    )
                  ],
                ),
              ),
              GradientButton(
                colors: [Color(0xff78c1f3), Color(0xff068fff)],
                text: 'Sing',
                onPressed: () {
                  Get.find<SongPageController>().toRecordPage(song);
                },
              ),
            ],
          )
          // title: Text(song.name),
          // subtitle: Text(song.auther),
          // isThreeLine: true,

          ),
    );
  }
}
