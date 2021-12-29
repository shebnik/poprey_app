import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class AppWidgets {
  static Widget get loading => const Center(child: CircularProgressIndicator());

  static void showBottomSheet(BuildContext context, Widget widget) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: widget,
      ),
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
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontFamily: AppConstants.SFProDisplay,
                  color: AppTheme.primary(context),
                ),
          ),
        ),
        content: Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1?.apply(
                color: const Color(0xFF8A8F95),
              ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              actionText,
              style: Theme.of(context).textTheme.headline3?.apply(
                    color: const Color(0xFF00ABDF),
                  ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
