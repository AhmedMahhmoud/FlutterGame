import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/Data/Providers/Animal/AnimalProvider.dart';
import 'package:flutter_game/Database/AnimalDatabase.dart';
import 'package:flutter_game/Domain/Models/AnimalModel.dart';
import 'package:flutter_game/Presentation/Game/views/add_players.dart';
import 'package:flutter_game/Presentation/Game/views/findout_page.dart';
import 'package:flutter_game/Presentation/Game/widgets/categories_container.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/constantData.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_game/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  Widget build(BuildContext context) {
    // final _animalProv = locator.locator<AnimalProvider>();
    return WillPopScope(
      onWillPop: ()=> SystemNavigator.pop(),
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/gameBackground.jpg'),
                fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            AutoSizeText(
              '???????? ??????',
              style: TextStyle(
                  fontSize: setResponsiveFontSize(20),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25.h,
            ),
            FadeInRight(
              duration: const Duration(seconds: 1),
              child: CategoriesCard(
                catColor: ColorManager.playersCardsColor[0],
                onTap: () {
                  navigateToPage(context, AddPlayerScreen(true));
                },
                catTitle: '??????????????',
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
                catTitle: '??????????',
                onTap: () {
                  showToast(
                    '???? ???????????? ????????????',
                    context: context,
                    animation: StyledToastAnimation.slideFromTop,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration:const Duration(seconds: 1),
                    duration:const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear,
                  );
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
                catTitle: '?????????? ??????????',
                onTap: () {
                  showToast(
                    '???? ???????????? ????????????',
                    context: context,
                    animation: StyledToastAnimation.slideFromTop,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration:const Duration(seconds: 1),
                    duration:const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear,
                  );
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            FadeInLeft(
              delay:const Duration(milliseconds: 2900),
              child: CategoriesCard(
                catColor: ColorManager.playersCardsColor[3],
                catImage: 'assets/images/clothes.jpg',
                onTap: () {
                  showToast(
                    '???? ???????????? ????????????',
                    context: context,
                    animation: StyledToastAnimation.slideFromTop,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear,
                  );
                },
                catTitle: '??????????',
              ),
            ),
          ],
        ),
      )),
    );
  }
}
