import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/utils/app_theme.dart';

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

  static void openSnackbar({
    required String message,
    Duration? duration,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    Get.snackbar(
      '',
      message,
      borderRadius: 4,
      titleText: const SizedBox(
        width: 0,
        height: 0,
      ),
      margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.primary,
      colorText: Colors.black,
      duration: duration ?? const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: onPressed ?? () => Get.back(),
        child: Text(
          buttonText ?? 'OK',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
