import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController {
  late final SharedPreferences sharedPreferences;

  InstagramModel? getInstagramModel() {
    try {
      return JsonMapper.deserialize<InstagramModel>(
        readJson(AppConstants.instagramModel),
      );
    } catch (e) {
      Logger.e('getInstagramModel error: ', e);
      return null;
    }
  }

  Future<void> setInstagramModel(InstagramModel? instagramModel) async {
    if (instagramModel != null) {
      await saveJson(
        AppConstants.instagramModel,
        JsonMapper.serialize(instagramModel),
      );
      update();
      Logger.i('updated instagramModel');
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

  String? readJson(String key) {
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
