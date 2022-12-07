import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String msgKey = "MSGKEY";

  static Future<bool> saveMsg(String msg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(msgKey, msg);
  }

  static Future<String?> getMsg() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(msgKey);
  }
}
