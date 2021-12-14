import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/utils/logger.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find();
  // final SharedPreferencesController sharedPreferencesController = Get.find();

  late CupertinoTabController cupertinoTabController = CupertinoTabController();
  var selectedTab = RxInt(0);

  @override
  Future<void> onReady() async {
    super.onReady();
    Logger.i('Fetching plans..');
    final instaPlans = await PlansParser.getInstaPlans();
    Logger.i('Plans fetched');

    final instagramModel = JsonMapper.deserialize<InstagramModel>(instaPlans);
    Logger.i('Model deserialized');
    // await sharedPreferencesController.setInstagramModel(instagramModel);
    mainController.isLoading = false;
    // Logger.i('Model set');
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }
}
