import 'package:backgroud_fetch/model/alarm_model.dart';
import 'package:hive/hive.dart';

class Boxes  {
  static Box<AlarmModel> getData()  => Hive.box('database') ;
}