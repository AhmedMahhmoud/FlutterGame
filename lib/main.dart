import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'Data/Providers/Animal/AnimalProvider.dart';

import 'Presentation/Game/views/splash_screen.dart';
import 'Presentation/Home/views/home.dart';
import 'core/GetItLocator/locator.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.intalizeLocator();
  // await intitalizeGame();
  runApp(MyApp());
}

InitLocator locator = InitLocator();
GetIt getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857, 899.42857),
        builder: () {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => PlayersProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => AnimalProvider(),
                ),
              ],
              child: MaterialApp(
                theme: ThemeData(fontFamily: 'Cairo'),
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
                title: 'بكاسة',
              ));
        });
  }
}

// Future<void> intitalizeGame() async {
//   final Future _init = await Init.initialize();
//   if (!await locator.locator<AppPreferences>().isDatabaseCreated()) {
//     AnimalDatabase animalDatabase = AnimalDatabase();
//     await animalDatabase.insertGame(animalData).then((value) async {
//       if (value != null) {
//         await locator.locator<AppPreferences>().setDbInitialized();
//       }
//     });
//   } else {
//     print("already added b4");
//   }
// }
