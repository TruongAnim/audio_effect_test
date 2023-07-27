import 'package:audio_effect_test/components/round_text_button.dart';
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
              children: const [
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
