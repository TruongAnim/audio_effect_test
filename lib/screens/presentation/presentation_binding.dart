import 'package:get/get.dart';

import 'presentation_controller.dart';

class PresentationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PresentationController());
  }
}