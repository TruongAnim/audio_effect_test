import 'package:audio_effect_test/components/round_text_button.dart';
import 'package:audio_effect_test/screens/playback/playback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresentationHeader extends StatefulWidget {
  const PresentationHeader({super.key});

  @override
  State<PresentationHeader> createState() => _PresentationHeaderState();
}

class _PresentationHeaderState extends State<PresentationHeader> {
  late PlaybackController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.08,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: controller.back,
            child: const Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Record editing",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          RoundTextButton(
              text: 'Save', onPressed: controller.save, isEnable: true),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
