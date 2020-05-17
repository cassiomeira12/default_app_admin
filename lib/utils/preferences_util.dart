import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static String _THEME = "theme";
  static String _NOTIFICATION_TOKEN = "notification_token";
  static String _LAST_CHECK_UPDATE = "last_check_update";
  static String _INTRO_DONE = "intro_done";

  static Future<SharedPreferences> getInstance() {
    return SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> setTheme(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_THEME, value);
  }

  static Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_THEME);
  }

  static void setNotificationToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_NOTIFICATION_TOKEN, value);
  }

  static Future<String> getNotificationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_NOTIFICATION_TOKEN);
  }

  static void setLastCheckUpdate(DateTime value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_LAST_CHECK_UPDATE, value.millisecondsSinceEpoch);
  }

  static Future<DateTime> getLastCheckUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var milisSeconds = prefs.getInt(_LAST_CHECK_UPDATE);
    if (milisSeconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(milisSeconds);
  }

  static void setIntroDone(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_INTRO_DONE, value);
  }

  static Future<bool> getIntroDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_INTRO_DONE);
  }

}