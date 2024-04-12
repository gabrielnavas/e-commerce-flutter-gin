import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> setJson(String key, String json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json);
  }

  static Future<String?> getJson(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static clear(String authKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
