import 'dart:convert';

import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_profile.dart';
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

  SMPlansModel? getSMPlansModel() {
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

  Future<void> setSMPlansModel(SMPlansModel additionalModel) async {
    await saveJson(
      AppConstants.ADDITIONAL_PLANS_MODEL,
      additionalModel.toJson(),
    );
    Logger.i('set AdditionalPlansModel');
    update();
  }

  static List<InstagramProfile>? getInstagramProfiles() {
    try {
      final json = readJson(AppConstants.INSTAGRAM_PROFILES) as List<dynamic>?;
      if (json != null) {
        return json.map((e) => InstagramProfile.fromJson(e)).toList();
      }
    } catch (e) {
      Logger.e('getInstagramProfiles error: ', e);
      return null;
    }
  }

  static Future<void> setInstagramProfiles(
      List<InstagramProfile> instagramProfiles) async {
    await saveJson(
      AppConstants.INSTAGRAM_PROFILES,
      instagramProfiles.map((e) => e.toJson()).toList(),
    );
    Logger.i('setInstagramProfiles');
  }

  static String? readString(String key) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> saveString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  static int? readInt(String key) {
    return sharedPreferences.getInt(key);
  }

  static Future<bool> saveInt(String key, int value) {
    return sharedPreferences.setInt(key, value);
  }

  static bool? readBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> saveBoolean(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  static dynamic readJson(String key) {
    try {
      var json = jsonDecode(
        sharedPreferences.getString(key) ?? '',
        // reviver: Utils.jsonReviver,
      );
      Logger.i('[SharedPreferences] [READ] $key - $json');
      return json;
    } catch (e) {
      Logger.i('[SharedPreferences] [READ] $key - null');
      return null;
    }
  }

  static Future<bool> saveJson(String key, value) {
    Logger.i('[SharedPreferences] [SAVE] $key - $value');
    return sharedPreferences.setString(
      key,
      jsonEncode(
        value,
        // toEncodable: Utils.dateSerializer,
      ),
    );
  }

  static Future<bool> remove(String key) {
    return sharedPreferences.remove(key);
  }

  static Future<bool> clear() {
    return sharedPreferences.clear();
  }
}
