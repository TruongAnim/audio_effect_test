import 'package:audio_effect_test/models/record.dart';
import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/screens/record_page/record_list_controller.dart';
import 'package:audio_effect_test/screens/song_page/components/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordPageItem extends StatefulWidget {
  final Record record;
  const RecordPageItem({super.key, required this.record});

  @override
  State<RecordPageItem> createState() => _RecordPageItemState();
}

class _RecordPageItemState extends State<RecordPageItem> {
  RecordListController controller = Get.find();
  late Song song;
  @override
  void initState() {
    super.initState();
    song = controller.getSongFromId(widget.record.idSong);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.record.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                ],
              ),
            ),
            GradientButton(
              colors: const [Color(0xff78c1f3), Color(0xff068fff)],
              text: 'Play',
              onPressed: () {
                controller.toPresentation(song, widget.record);
              },
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const Divider(
          thickness: 1.0,
          color: Colors.black26,
        ),
        Padding(
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.name,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          song.auther,
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const Text(
                          '12 records',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
              // title: Text(song.name),
              // subtitle: Text(song.auther),
              // isThreeLine: true,

              ),
        ),
      ]),
    );
  }
}
