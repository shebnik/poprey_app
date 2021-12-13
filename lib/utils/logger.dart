// ignore_for_file: avoid_print

class Logger {
  static void d(dynamic object) {
    print('$getTime [Debug]');
    print(object);
  }

  static void i(String msg) {
    print('$getTime [Info] $msg');
  }

  static void e(String msg, [dynamic e]) {
    print('$getTime [Error] $msg');
    if (e != null) print('$getTime [Error] $e');
  }

  static get getTime => DateTime.now().toString();
}