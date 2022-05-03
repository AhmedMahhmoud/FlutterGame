import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/players_provider.dart';
import 'package:flutter_game/Presentation/Game/views/add_players.dart';
import 'package:flutter_game/Presentation/Game/widgets/player_container.dart';
import 'package:flutter_game/Presentation/Home/views/home.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

double listHeight = 90.h;

class FinalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          navigateReplacmentToPage(context,  Home()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/gameBackground.jpg',
                  ),
                  fit: BoxFit.fill)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<PlayersProvider>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    AutoSizeText(
                      'النتيجة',
                      style: TextStyle(
                          fontSize: setResponsiveFontSize(25),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: listHeight * value.playersList.length,
                      margin:  EdgeInsets.symmetric(horizontal: 8.w),
                      child: ListView.builder(
                        itemCount: value.playersList.isEmpty
                            ? 1
                            : value.playersList.length,
                        itemBuilder: (context, index) {
                          return BounceInRight(
                            child: Visibility(
                              visible: value.playersList.isNotEmpty,
                              child: Padding(
                                padding:
                                     EdgeInsets.symmetric(vertical: 6.h),
                                child: PlayerRanking(
                                  playerScore:
                                      value.playersList[index].playerScore,
                                  playerIndex: index,
                                  playerImage: value.playersList.isEmpty
                                      ? ''
                                      : value.playersList[index].playerImage,
                                  playerName: value.playersList.isEmpty
                                      ? ' '
                                      : value.playersList[index].playerName,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    RoundedActionButton(
                      btnColor: ColorManager.successColor,
                      title: 'دور جديد',
                      btnFunc: () {
                        navigateReplacmentToPage(
                            context, const AddPlayerScreen(false));
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    RoundedActionButton(
                      btnColor: ColorManager.failColor,
                      title: 'إنهاء اللعبة',
                      btnFunc: () {
                        navigateReplacmentToPage(context, Home());
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
