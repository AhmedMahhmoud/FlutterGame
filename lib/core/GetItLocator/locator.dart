import 'package:flutter_game/Data/Providers/Animal/AnimalProvider.dart';
import 'package:flutter_game/core/sharedPrefrences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

class InitLocator {
  GetIt locator = GetIt.I;
  void intalizeLocator() {
    _setUpLocator();
    print("initialized locators");
  }

  Future<void> _setUpLocator() async {
    locator.registerLazySingleton(() => AnimalProvider());
    final sharedPrefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    instance.registerLazySingleton<AppPreferences>(
        () => AppPreferences(instance()));
  }
}
