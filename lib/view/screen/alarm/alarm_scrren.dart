import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:backgroud_fetch/controller/alarm_controller.dart';
import 'package:backgroud_fetch/model/alarm_model.dart';
import 'package:backgroud_fetch/view/screen/alarm/inner_widget/alarm_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/boxes.dart';

import 'package:hive_flutter/adapters.dart';

class AlarmScreen extends StatelessWidget {
  AlarmScreen({super.key});

  AlarmController controller = Get.put(AlarmController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlarmController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('BackgroundFetch Example',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.amberAccent,
            actions: [
              TextButton(
                  onPressed: () {
                    Alarm.stopAll();
                  },
                  child: const Text("stop all Alarm"))
            ],
          ),
          body: ValueListenableBuilder(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, child) {
                var data = box.values.toList().cast<AlarmModel>();
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    AlarmModel item = data[index];
                    return AlarmListItem(
                      index: index,
                      item: item,
                    );
                  },
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.selectDateTime,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
