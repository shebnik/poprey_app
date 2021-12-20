import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/utils/logger.dart';

class HomePageController extends GetxController {
  final MainController mainController = Get.find();

  late CupertinoTabController cupertinoTabController = CupertinoTabController();
  var selectedTab = RxInt(0);

  Future<bool> fetchPlans() async {
    Logger.i('[HomePage] Fetching plans..');
    if (await fetchInstaPlans() && await fetchSMPlans()) {
      Logger.i('[HomePage] Plans fetched');
      mainController.isLoading = false;
      return true;
    }
    return false;
  }

  Future<bool> fetchInstaPlans() async {
    final instaPlans = await PlansParser.getInstaPlans();
    Logger.i('[HomePage] Instagram Plans fetched');
    if (instaPlans != null) {
      final instagramModel = InstagramModel.fromJson(instaPlans);
      Logger.i('[HomePage] Instagram Model deserialized');
      await AppPreferences.setInstagramModel(instagramModel);
      Logger.i('[HomePage] Instagram Model set');
      return true;
    }
    return false;
  }

  Future<bool> fetchSMPlans() async {
    final additionalPlans = await PlansParser.getSMPlans();
    Logger.i('[HomePage] Additional Plans fetched');
    if (additionalPlans != null) {
      final additionalModel = SMPlansModel.fromJson(additionalPlans);
      Logger.i('[HomePage] Additional Model deserialized');
      await AppPreferences.setSMPlansModel(additionalModel);
      Logger.i('[HomePage] Additional Model set');
      return true;
    }
    return false;
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }
}
