import 'package:alarm/alarm.dart';
import 'package:backgroud_fetch/controller/alarm_controller.dart';
import 'package:backgroud_fetch/model/alarm_model.dart';
import 'package:backgroud_fetch/view/common_widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmListItem extends StatelessWidget {
  AlarmListItem({
    super.key,
    required this.index,
    required this.item,
  });

  int index;
  AlarmModel item;
  AlarmController alarmController = Get.put(AlarmController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          CircleAvatar(
            child: ClipOval(child: Text(index.toString())),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: item.title,
                    maxLines: 1,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: item.description,
                    maxLines: 1,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          Switch(
            value: item.isOn,
            onChanged: (value) async {
              item.isOn = value;
              item.save();
              print(item.id);
              await Alarm.stop(item.id);
            },
          )
        ],
      ),
    );
  }
}
