import 'package:intl/intl.dart';

class Utils {
  static String formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatNumber(int number) {
    var formatter = NumberFormat('#,###');
    return formatter.format(number).replaceAll(',', ' ');
  }

  // static void openUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     Logger.i('Cannot load URL $url');
  //   }
  // }
}
