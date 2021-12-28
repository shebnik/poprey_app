import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class ChooseAccountController extends GetxController {
  late ScrollController accountsListScrollController;
  RxBool isAccountsShadowShown = false.obs;

  void accountsListHandleScrolling() {
    isAccountsShadowShown.value =
        accountsListScrollController.position.extentAfter > 16 ? true : false;
  }
}
