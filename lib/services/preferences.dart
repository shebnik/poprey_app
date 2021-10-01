import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider =
    Provider<PreferencesService>(((ref) => throw UnimplementedError()));

class PreferencesService {
  PreferencesService(this.prefs);

  final SharedPreferences prefs;

  Future<bool> deleteData() async {
    return await prefs.clear();
  }
}
