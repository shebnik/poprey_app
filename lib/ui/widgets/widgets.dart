import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/bottom_sheet.dart';

class Widgets {
  static Widget get loading => const Center(child: CircularProgressIndicator());

  static void showBottomSheet(String title) {
    Get.bottomSheet(
      AppBottomSheet(title: title),
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