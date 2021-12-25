import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'dart:io' show Platform;

class Widgets {
  static Widget get loading => const Center(child: CircularProgressIndicator());

  static void showBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: widget,
      ),
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
      backgroundColor: AppTheme.primaryColor,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: onPressed ?? () => Get.back(),
        child: Text(
          buttonText ?? 'OK',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Future<void> openDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String actionText,
  }) async {
    // if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(
            description,
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                actionText,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    // } else {
    //   return await showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text(title),
    //       content: Text(
    //         description,
    //       ),
    //       actions: [
    //         CupertinoDialogAction(
    //           child: Text(
    //             actionText,
    //           ),
    //           onPressed: () => Navigator.of(context).pop(true),
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }
}
