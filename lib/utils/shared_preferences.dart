import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = false;
    if (token != null) {
      res = await prefs.setString('token', token);
    }

    return res;
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
