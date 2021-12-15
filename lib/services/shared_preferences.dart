import 'dart:convert';

import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController {
  static late final SharedPreferences sharedPreferences;

  InstagramModel? getInstagramModel() {
    try {
      final json = readJson(AppConstants.INSTAGRAM_MODEL);
      if (json != null) {
        return InstagramModel.fromJson(json);
      }
    } catch (e) {
      Logger.e('getInstagramModel error: ', e);
      return null;
    }
  }

  Future<void> setInstagramModel(InstagramModel? _instagramModel) async {
    if (_instagramModel != null) {
      await saveJson(
        AppConstants.INSTAGRAM_MODEL,
        _instagramModel.toJson(),
      );
      // await Future.delayed(Duration(seconds: 3));
      Logger.i('setInstagramModel done');
      update();
    }
  }

  String? readString(String key) {
    return sharedPreferences.getString(key);
  }

  Future<bool> saveString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  int? readInt(String key) {
    return sharedPreferences.getInt(key);
  }

  Future<bool> saveInt(String key, int value) {
    return sharedPreferences.setInt(key, value);
  }

  bool? readBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  Future<bool> saveBoolean(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  dynamic readJson(String key) {
    try {
      return json.decode(
        sharedPreferences.getString(key) ?? '',
        // reviver: Utils.jsonReviver,
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveJson(String key, value) {
    return sharedPreferences.setString(
      key,
      json.encode(
        value,
        // toEncodable: Utils.dateSerializer,
      ),
    );
  }

  Future<bool> remove(String key) {
    return sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return sharedPreferences.clear();
  }
}
