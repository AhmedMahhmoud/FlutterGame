import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import '../../../Data/Providers/Animal/animal_provider.dart';
import '../../../Services/AppVersion/app_version.dart';
import '../../../core/Shared/constant_data.dart';
import 'package:provider/provider.dart';
import '../../../core/Shared/rounded_action_button.dart';
import '../../Game/views/add_players.dart';
import '../../Game/views/how_to_play_screen.dart';
import '../../Game/widgets/categories_container.dart';
import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
// Animal _animal = Animal();
// AnimalDatabase _animalDatabase = AnimalDatabase();
// Future animalFuture;
// Future<void> getAnimal() async {
//   _animal = await _animalDatabase.getAnimal(1);
//   locator.locator<AnimalProvider>().getAnimalFromDb(_animal);
// }

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    AppStoreVersion _appStoreVersion = AppStoreVersion();
    _appStoreVersion.checkAppUpdate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProv = Provider.of<GameProvider>(context, listen: false);
    // final _animalProv = locator.locator<AnimalProvider>();
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: Scaffold(
              body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/gameBackground.jpg'),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  AutoSizeText(
                    'تلعب ايه',
                    style: TextStyle(
                        fontSize: setResponsiveFontSize(20),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FadeInRight(
                    duration: const Duration(seconds: 1),
                    child: CategoriesCard(
                      catColor: ColorManager.playersCardsColor[0],
                      onTap: () {
                        gameProv.setGameCategory(animalData);
                        navigateToPage(context, const AddPlayerScreen(true));
                      },
                      catTitle: 'حيوانات',
                      catImage: 'assets/images/animals.jpg',
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 1500),
                    child: CategoriesCard(
                      catColor: ColorManager.playersCardsColor[1],
                      catImage: 'assets/images/movies.jpg',
                      catTitle: 'افلام',
                      onTap: () {
                        gameProv.setGameCategory(moviesData);
                        navigateToPage(context, const AddPlayerScreen(true));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 2200),
                    child: CategoriesCard(
                      catColor: ColorManager.playersCardsColor[4],
                      catImage: 'assets/images/food.jpg',
                      catTitle: 'اكلات مصرية',
                      onTap: () {
                        gameProv.setGameCategory(foodData);
                        navigateToPage(context, const AddPlayerScreen(true));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 2900),
                    child: CategoriesCard(
                      catColor: ColorManager.playersCardsColor[3],
                      catImage: 'assets/images/clothes.jpg',
                      onTap: () {
                        gameProv.setGameCategory(clothesData);
                        navigateToPage(context, const AddPlayerScreen(true));
                      },
                      catTitle: 'ملابس',
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 3600),
                    child: CategoriesCard(
                      catColor: ColorManager.playersCardsColor[6],
                      catImage: 'assets/images/makeup.jpg',
                      onTap: () {
                        gameProv.setGameCategory(makeupData);
                        navigateToPage(context, const AddPlayerScreen(true));
                      },
                      catTitle: 'قعدة بنات',
                    ),
                  ),
                  Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 16.h, right: 8.w, left: 8.w),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () =>
                              navigateToPage(context, HowToPlayScreen()),
                          child: Column(
                            children: [
                              CircleAvatar(
                                  child: Image.asset(
                                    'assets/images/h2p.png',
                                    width: 35.w,
                                  ),
                                  backgroundColor: Colors.white,
                                  radius: 28.w),
                              AutoSizeText(
                                'شرح اللعبة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: setResponsiveFontSize(16),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
