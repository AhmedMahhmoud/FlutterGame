import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<bool> isDatabaseCreated() async {
    return _sharedPreferences.getBool('isDbCreated') ?? false;
  }

  Future<void> setDbInitialized() async {
    await _sharedPreferences.setBool('isDbCreated', true);
  }
}
