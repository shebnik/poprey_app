import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:poprey_app/utils/app_constants.dart';

import 'package:poprey_app/utils/logger.dart';
import 'package:connectivity/connectivity.dart';

class PlansParser {

  static Future<Map?> parsePlanURL(String url) async {
    Client _client = Client();
    Response _response;
    try {
      _response = await _client.get(Uri.parse(url));
      Map plans = jsonDecode(_response.body);
      if (plans['result'] == 'Ok') return plans;
      return null;
    } on SocketException {
      while (
          await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        //Logger.i("[PlansParser] parseURL - No internet");
        await Future.delayed(const Duration(seconds: 3));
      }
      return parsePlanURL(url);
    } catch (e) {
      Logger.e('[PlansParser] parseURL', e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getInstaPlans() async {
    Map? plans = await parsePlanURL(AppConstants.InstagramPlansAPI);
    if (plans != null) {
      Logger.i('[PlansParser] getInstaPlans - Ok');
      return plans['data']['Instagram'];
    } else {
      Logger.e('[PlansParser] getInstaPlans - Error');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getSMPlans() async {
    Map? plans = await parsePlanURL(AppConstants.AdditionalServicesAPI);
    if (plans != null) {
      Logger.i('[PlansParser] getSMPlans - Ok');
      return plans['data'];
    } else {
      Logger.e('[PlansParser] getSMPlans - Error');
      return null;
    }
  }
}
