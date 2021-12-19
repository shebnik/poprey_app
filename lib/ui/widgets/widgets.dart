import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Widgets {
  static Widget get loading => const Center(child: CircularProgressIndicator());

  static void showBottomSheet(Widget widget) {
    Get.bottomSheet(
      widget,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}
