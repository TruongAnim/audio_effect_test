import 'package:audio_effect_test/screens/presentation/components/player_widget.dart';
import 'package:audio_effect_test/screens/presentation/presentation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  PresentationController controller = Get.find();
  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(height: h * 0.4, child: PlayerWidget()),
        ]),
      ),
    );
  }
}
