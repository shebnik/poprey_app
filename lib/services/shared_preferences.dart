import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late final SharedPreferences sharedPreferences;

  static readString(String key) {
    return sharedPreferences.getString(key);
  }

  static saveString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  static readInt(String key) {
    return sharedPreferences.getInt(key);
  }

  static saveInt(String key, int value) {
    return sharedPreferences.setInt(key, value);
  }

  static readBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  static saveBoolean(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  static readJson(String key) {
    try {
      return json.decode(
        sharedPreferences.getString(key) ?? '',
        // reviver: Utils.jsonReviver,
      );
    } catch (e) {
      return null;
    }
  }

  static saveJson(String key, value) {
    sharedPreferences.setString(
      key,
      json.encode(
        value,
        // toEncodable: Utils.dateSerializer,
      ),
    );
  }

  static remove(String key) {
    sharedPreferences.remove(key);
  }

  static clear() {
    sharedPreferences.clear();
  }
}
