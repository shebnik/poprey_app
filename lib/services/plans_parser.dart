import 'dart:convert';
import 'package:http/http.dart';

import 'package:poprey_app/utils/logger.dart';

class PlansParser {
  String instaPlansUrl = "https://core.poprey.com/api/get_plans.php";
  String additionalServicesUrl =
        "https://core.poprey.com/api/additional_services.php";

  Future<Map?> parsePlanURL(String url) async {
    Client _client = Client();
    Response _response;
    try {
      _response = await _client.get(Uri.parse(url));
      Map plans = jsonDecode(_response.body);
      if (plans["result"] == "Ok") return plans;
      return null;
    } catch (e) {
      Logger.e("[PlansParser] parseURL", e);
      return null;
    }
  }

  Future<Map?> getInstaPlans() async {
    Map? plans = await parsePlanURL(instaPlansUrl);
    if (plans != null) {
      Logger.i("[PlansParser] getInstaPlans - Ok");
      return plans["data"]["Instagram"];
    } else {
      Logger.e("[PlansParser] getInstaPlans - Error");
      return null;
    }
  }

  Future<Map?> getAdditionalPlans() async {
    Map? plans = await parsePlanURL(additionalServicesUrl);
    if (plans != null) {
      Logger.i("[PlansParser] getAdditionalPlans - Ok");
      return plans;
    } else {
      Logger.e("[PlansParser] getAdditionalPlans - Error");
      return null;
    }
  }
}
