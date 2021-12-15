import 'dart:convert';

import 'package:get/get.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
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

  Future<void> setInstagramModel(InstagramModel instagramModel) async {
    await saveJson(
      AppConstants.INSTAGRAM_MODEL,
      instagramModel.toJson(),
    );
    Logger.i('set InstagramModel');
    update();
  }  

  SMPlansModel? getAdditionalPlansModel() {
    try {
      final json = readJson(AppConstants.ADDITIONAL_PLANS_MODEL);
      if (json != null) {
        return SMPlansModel.fromJson(json);
      }
    } catch (e) {
      Logger.e('getAdditionalPlansModel error: ', e);
      return null;
    }
  }

  Future<void> setAdditionalPlansModel(SMPlansModel additionalModel) async {
    await saveJson(
      AppConstants.ADDITIONAL_PLANS_MODEL,
      additionalModel.toJson(),
    );
    Logger.i('set AdditionalPlansModel');
    update();
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
