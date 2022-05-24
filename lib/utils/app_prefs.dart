import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_data.dart';

class AppPref {
  static clearSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear().catchError((err) {
      print(err.toString());
    });
  }

  static clearUserPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(USER_DATA);
  }

  static addString(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  static addInt(String key, int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, val);
  }

  static addBoolean(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key) ?? "";
    return stringValue;
  }

  static getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt(key) ?? 0;
    return intValue;
  }

  static getBoolean(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(key) ?? false;
    return intValue;
  }

  static const String USER_DATA = "userDtls";
  static const String INTRO_VIEWED = "introViewed";

  static setUserData(String val) {
    addString(USER_DATA, val);
  }

  static setIntroViewed(bool val) {
    addBoolean(INTRO_VIEWED, val);
  }

  //-----------------------//

  static Future<LoginData?> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(USER_DATA);
    if (data == null) {
      return null;
    } else {
      var jsonData = json.decode(data);
      final uData = LoginData.fromJson(jsonData);
      return uData;
    }
  }

  static Future<bool> isIntroViewed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getBool(INTRO_VIEWED);
    if (data == null) {
      return false;
    } else {
      return data;
    }
  }
}
