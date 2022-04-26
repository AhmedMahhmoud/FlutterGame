import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/Data/Providers/Players/players_provider.dart';
import 'package:flutter_game/Database/initalize.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'Data/Providers/Animal/animal_provider.dart';

import 'Presentation/Game/views/splash_screen.dart';
import 'Presentation/Home/views/home.dart';
import 'core/GetItLocator/locator.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //locator.intalizeLocator();
  // await intitalizeGame();
  runApp(const MyApp());
}

/*InitLocator locator = InitLocator();
GetIt getIt = GetIt.instance;*/

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857, 899.42857),
        builder: () {
          return MultiProvider(
              providers: [
                // ignore: always_specify_types
                ChangeNotifierProvider(
                  create: (BuildContext context) => PlayersProvider(),
                ),
                // ignore: always_specify_types
                ChangeNotifierProvider(
                  create: (BuildContext context) => GameProvider(),
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
