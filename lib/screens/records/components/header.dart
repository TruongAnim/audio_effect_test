import 'package:audio_effect_test/components/round_text_button.dart';
import 'package:audio_effect_test/constants/colors.dart';
import 'package:audio_effect_test/models/song.dart';
import 'package:audio_effect_test/screens/records/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late RecordController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Obx(
      () {
        Song? song = controller.song.value;
        return Container(
          color: ColorPalette.headerBackgroundColor,
          height: h * 0.08,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song!.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Upload by @${song.auther}',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              RoundTextButton(
                  text: 'Done',
                  onPressed: controller.doneButtonTap,
                  isEnable: controller.state.value == RecordState.pause),
              const SizedBox(width: 15),
            ],
          ),
        );
      },
    );
  }
}
