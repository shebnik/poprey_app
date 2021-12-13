import 'package:flutter/cupertino.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  PreferencesService(this.prefs);

  final SharedPreferences prefs;

  Future<void> deleteData() async {
    await prefs.clear();
    notifyListeners();
  }

  static const connectionAvailableKey = 'connectionAvailable';

  set connectionAvailable(bool val) {
    Logger.i('[PreferencesService] connectionAvailable set to - $val');
    prefs.setBool(connectionAvailableKey, val);
    notifyListeners();
  }

  bool get connectionAvailable {
    final val = prefs.getBool(connectionAvailableKey) ?? false;
    Logger.i('[PreferencesService] connectionAvailable got - $val');
    return val;
  }
}
