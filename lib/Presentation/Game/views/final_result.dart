import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Presentation/Game/views/add_players.dart';
import 'package:flutter_game/Presentation/Game/widgets/player_container.dart';
import 'package:flutter_game/Presentation/Home/views/home.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

double listHeight = 90;

class FinalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/gameBackground.jpg",
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
                    height: 5,
                  ),
                  AutoSizeText(
                    "النتيجة",
                    style: TextStyle(
                        fontSize: setResponsiveFontSize(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: listHeight * value.playersList.length,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                      itemCount: value.playersList.length == 0
                          ? 1
                          : value.playersList.length,
                      itemBuilder: (context, index) {
                        return BounceInRight(
                          child: Visibility(
                            visible: value.playersList.length != 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: PlayerRanking(
                                playerScore:
                                    value.playersList[index].playerScore,
                                playerIndex: index,
                                playerImage: value.playersList.length == 0
                                    ? ""
                                    : value.playersList[index].playerImage,
                                playerName: value.playersList.length == 0
                                    ? " "
                                    : value.playersList[index].playerName,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  RoundedActionButton(
                    btnColor: ColorManager.failColor,
                    title: 'دور جديد',
                    btnFunc: () {
                      navigateReplacmentToPage(context, AddPlayerScreen(false));
                    },
                  ),
                  SizedBox(
                    height: 15,
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
    );
  }
}
