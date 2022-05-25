import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../Data/Providers/Players/players_provider.dart';
import '../../../core/Shared/rounded_action_button.dart';
import '../widgets/choices_display.dart';
import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/ExitDialog.dart';
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
    PlayersProvider playersProv =
        Provider.of<PlayersProvider>(context, listen: true);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => ZoomIn(
                    child: const ExitDialog(),
                  ));
        },
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: AutoSizeText(
                      'مرحلة التصويت',
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
                        padding: EdgeInsets.symmetric(vertical: 20.h),
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
                        itemBuilder: (BuildContext context, int index) {
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
                                          log('playerIndex before $playerIndex');

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
                                              log('correct choice');
                                              playersProv.playersList[playerIndex]
                                                  .playerScore += 100;
                                            } else {
                                              log('wrong choice');
                                            }
                                          } else {
                                            log('bara el salfa');
                                          }
                                        }
                                        log('score ${playersProv.playersList[playerIndex].playerScore}');

                                        // zwdna el index 34an ygbly list na2sa el la3eb elly b3do
                                        setState(() {
                                          playerIndex++;
                                        });
                                        log('playerIndex after $playerIndex');
                                        await Provider.of<PlayersProvider>(
                                                context,
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
                                            log('correct choice');
                                            playersProv.playersList[playerIndex]
                                                .playerScore += 100;
                                          } else {
                                            log('wrong choice');
                                          }
                                        } else {
                                          log('bara el salfa');
                                        }
                                        log('score ${playersProv.playersList[playerIndex].playerScore}');
                                      }
                                    } else {
                                      return;
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                    height: 60.h,
                                    width: 250.w,
                                  )));
                        },
                        itemCount: playersProv.suspectsPlayers.length,
                      ),
                      button_display_index == playersProv.playersList.length
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                              child: RoundedActionButton(
                                title: 'التالى',
                                btnColor: ColorManager.successColor,
                                btnFunc: () {
                                  navigateToPage(context, FindOutScreen());
                                },
                              ),
                            )
                          : Container()
                      //const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
