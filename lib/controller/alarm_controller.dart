import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:backgroud_fetch/helper/PrefsHelper.dart';
import 'package:backgroud_fetch/model/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/boxes.dart';

class AlarmController extends GetxController {
  List list = [];

  setAlarm({required int id, required String des}) async {
    bool isRinging = await Alarm.isRinging(id);
    print(isRinging);
    if (!isRinging) {
      print(DateTime.now());
      String time = DateTime.now().toString();
      print("=====================> time $time");

      final alarmSettings = AlarmSettings(
        id: id,
        dateTime: DateTime.now().add(const Duration(seconds: 10)),
        assetAudioPath: 'assets/alarm.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'Alarm ${id}',
        notificationBody: des,
        enableNotificationOnKill: true,
      );
      await Alarm.set(alarmSettings: alarmSettings);
    } else {
      await Alarm.stop(id);
    }
  }

  DateTime selectedDateTime = DateTime.now();

  Future<void> selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }

      final box = Boxes.getData();

      final data = AlarmModel(
          title: selectedDateTime.toIso8601String(),
          description: "this alarm set you",
          id: box.length);

      box.add(data);

      setAlarm(id: box.length, des: "this is alarm");
    }
  }
}
