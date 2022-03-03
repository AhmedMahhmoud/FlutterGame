import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Presentation/Game/widgets/choices_display.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'findout_page.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  int playerIndex = 0;
  int button_display_index = 0;
  int ctr = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayersProvider>(context, listen: false)
          .getSuspectsPlayers(playerIndex);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/gameBackground.jpg"),
                fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AutoSizeText(
                  "مرحلة التصويت",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: setResponsiveFontSize(20)),
                ),
              ),
            ),
            DisplayChoices(
              headerImage: playersProv.playersList[playerIndex].playerImage,
              content: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.w),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: AutoSizeText(
                        '${playersProv.playersList[playerIndex].playerName} اختار الشخص اللي شاكك فيه ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: setResponsiveFontSize(18)),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () async {
                                // to prevent voting after display of next button
                                if (button_display_index !=
                                    playersProv.playersList.length) {
                                  setState(() {
                                    button_display_index++;
                                  });

                                  if (button_display_index !=
                                      playersProv.playersList.length) {
                                    if (button_display_index !=
                                        playersProv.playersList.length) {
                                      print('playerIndex before $playerIndex');

                                      // 34an at2kd en elly by-vote msh hwa elly bara el salfa
                                      if (playersProv.playersList[playerIndex]
                                              .playerName !=
                                          playersProv
                                              .playersList[
                                                  playersProv.whoIsOutIndex]
                                              .playerName) {
                                        // 34an at2kd en elly e5taro hwa hwa elly bara el salfa
                                        if (playersProv.suspectsPlayers[index]
                                                .playerName ==
                                            playersProv
                                                .playersList[
                                                    playersProv.whoIsOutIndex]
                                                .playerName) {
                                          print('correct choice');
                                          playersProv.playersList[playerIndex]
                                              .playerScore += 100;
                                        } else {
                                          print('wrong choice');
                                        }
                                      } else {
                                        print('bara el salfa');
                                      }
                                    }
                                    print(
                                        'score ${playersProv.playersList[playerIndex].playerScore}');

                                    // zwdna el index 34an ygbly list na2sa el la3eb elly b3do
                                    setState(() {
                                      playerIndex++;
                                    });
                                    print('playerIndex after $playerIndex');
                                    await Provider.of<PlayersProvider>(context,
                                            listen: false)
                                        .getSuspectsPlayers(playerIndex);
                                  } else {
                                    // 34an at2kd en elly by-vote msh hwa elly bara el salfa
                                    if (playersProv.playersList[playerIndex]
                                            .playerName !=
                                        playersProv
                                            .playersList[
                                                playersProv.whoIsOutIndex]
                                            .playerName) {
                                      // 34an at2kd en elly e5taro hwa hwa elly bara el salfa
                                      if (playersProv.suspectsPlayers[index]
                                              .playerName ==
                                          playersProv
                                              .playersList[
                                                  playersProv.whoIsOutIndex]
                                              .playerName) {
                                        print('correct choice');
                                        playersProv.playersList[playerIndex]
                                            .playerScore += 100;
                                      } else {
                                        print('wrong choice');
                                      }
                                    } else {
                                      print('bara el salfa');
                                    }
                                    print(
                                        'score ${playersProv.playersList[playerIndex].playerScore}');
                                  }
                                } else {
                                  return;
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: ColorManager.darkGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: AutoSizeText(
                                    playersProv
                                        .suspectsPlayers[index].playerName,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                        fontSize: setResponsiveFontSize(16)),
                                  ),
                                ),
                                alignment: Alignment.center,
                                height: 70.h,
                                width: 250.w,
                              )));
                    },
                    itemCount: playersProv.suspectsPlayers.length,
                  ),
                  Spacer(),
                  button_display_index == playersProv.playersList.length
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: RoundedActionButton(
                            title: "التالى",
                            btnColor: ColorManager.successColor,
                            btnFunc: () {
                              navigateToPage(context, FindOutScreen());
                            },
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
