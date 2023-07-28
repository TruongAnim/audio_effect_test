import 'package:audio_effect_test/models/record.dart';
import 'package:audio_effect_test/screens/record_page/components/record_page_item.dart';
import 'package:audio_effect_test/screens/record_page/record_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  RecordListController controller = Get.find();
  @override
  void initState() {
    super.initState();
    controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        List<Record> records = controller.records;
        return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) =>
                RecordPageItem(record: records[index]));
      }),
    );
  }
}
