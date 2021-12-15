import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/utils/logger.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find();
  final SharedPreferencesController sharedPreferencesController = Get.find();

  late CupertinoTabController cupertinoTabController = CupertinoTabController();
  var selectedTab = RxInt(0);

  @override
  void onReady() {
    super.onReady();
    fetchPlans();
  }

  void fetchPlans() async {
    Logger.i('Fetching plans..');

    final instaPlans = await PlansParser.getInstaPlans();
    Logger.i('Instagram Plans fetched');
    if (instaPlans != null) {
      final instagramModel = InstagramModel.fromJson(instaPlans);
      Logger.i('Instagram Model deserialized');
      await sharedPreferencesController.setInstagramModel(instagramModel);
      Logger.i('Instagram Model set');
    }

    final additionalPlans = await PlansParser.getAdditionalPlans();
    Logger.i('Additional Plans fetched');
    if (additionalPlans != null) {
      final additionalModel = SMPlansModel.fromJson(additionalPlans);
      Logger.i('Additional Model deserialized');
      await sharedPreferencesController
          .setSMPlansModel(additionalModel);
      Logger.i('Additional Model set');
    }
    mainController.isLoading = false;
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }
}
