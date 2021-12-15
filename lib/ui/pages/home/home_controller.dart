import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/utils/hex_color.dart';
import 'package:poprey_app/utils/logger.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find();
  final SharedPreferencesController sharedPreferencesController = Get.find();

  late CupertinoTabController cupertinoTabController = CupertinoTabController();
  var selectedTab = RxInt(0);

  final BuildContext context;

  HomeController(this.context);

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
      await sharedPreferencesController.setSMPlansModel(additionalModel);
      Logger.i('Additional Model set');
    }
    mainController.isLoading = false;
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }

  void showModalSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        var sheetHeight = MediaQuery.of(context).size.height / 2.6;
        var sheetWidth = MediaQuery.of(context).size.width;
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: sheetHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: sheetHeight / 5,
                  width: double.infinity,
                  color: HexColor.fromHex('#F7F8FB'),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 7,
                        child: Container(
                          width: sheetWidth / 10,
                          height: 4,
                          color: HexColor.fromHex('#E1E4E8'),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: InkWell(
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: HexColor.fromHex('#C9CFD6'),
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
