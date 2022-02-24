import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<bool> isDatabaseCreated() async {
    return _sharedPreferences.getBool("isDbCreated") ?? false;
  }

  Future setDbInitialized() async {
    await _sharedPreferences.setBool("isDbCreated", true);
  }
}
