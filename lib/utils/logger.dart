import 'package:intl/intl.dart';

class Logger {
  static void i(String msg) {
    // TODO Dev: uncomment
    print('[${getTime()}] [Info] $msg');
  }

  static void e(String msg, [dynamic? e]) {
    // TODO Dev: uncomment
    var time = getTime();
    print('[$time] [Error] $msg');
    if (e != null) print('[$time] [Error] $e');
  }

  static String getTime() {
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('HH:mm:ss');
    var time = formatter.format(date) + ':';

    var millisecond = date.millisecond;
    if (millisecond < 100) time += '0';
    time += millisecond.toString();
    return time;
  }
}
