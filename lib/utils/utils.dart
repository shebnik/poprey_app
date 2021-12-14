import 'package:poprey_app/utils/logger.dart';

class Utils {
  
  static String formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
  
  // static void openUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     Logger.i('Cannot load URL $url');
  //   }
  // }
}