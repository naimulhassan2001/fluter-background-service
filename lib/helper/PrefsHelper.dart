import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static String alarmList = "";

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }


  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    alarmList = preferences.getString("alarmList") ?? "";

    print(alarmList);
    //
  }
}
