import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/app_widgets.dart';

import '../main_controller.dart';

class Utils {
  static String formatAmount(dynamic amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatNumber(int number) {
    var formatter = NumberFormat('#,###');
    return formatter.format(number).replaceAll(',', ' ');
  }

  static List<TextInputFormatter> getInputFormatters({
    bool isNumberType = false,
  }) {
    return [
      LengthLimitingTextInputFormatter(64),
      FilteringTextInputFormatter.deny(
        RegExp(
            r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
      ),
      if (isNumberType)
        FilteringTextInputFormatter.allow(RegExp(r'([0-9]+[.,]?[0-9]*)')),
    ];
  }

  static bool isOnline() {
    if (!MainController.isOnline) {
      AppWidgets.openSnackbar(
          message: AppLocale(Get.context!).checkInternetConnection);
      return false;
    } else {
      return true;
    }
  }

  // static void openUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     Logger.i('Cannot load URL $url');
  //   }
  // }
}
