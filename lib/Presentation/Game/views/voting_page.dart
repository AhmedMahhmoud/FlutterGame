import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '${playersProv.playersList[playerIndex].playerName} اختار الشخص اللي شاكك فيه ',
                textAlign: TextAlign.center,
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
                                if (playersProv
                                        .playersList[playerIndex].playerName !=
                                    playersProv
                                        .playersList[playersProv.whoIsOutIndex]
                                        .playerName) {
                                  // 34an at2kd en elly e5taro hwa hwa elly bara el salfa
                                  if (playersProv
                                          .suspectsPlayers[index].playerName ==
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
                              if (playersProv
                                      .playersList[playerIndex].playerName !=
                                  playersProv
                                      .playersList[playersProv.whoIsOutIndex]
                                      .playerName) {
                                // 34an at2kd en elly e5taro hwa hwa elly bara el salfa
                                if (playersProv
                                        .suspectsPlayers[index].playerName ==
                                    playersProv
                                        .playersList[playersProv.whoIsOutIndex]
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
                          color: Colors.blue,
                          child: Text(
                            playersProv.suspectsPlayers[index].playerName,
                            style: TextStyle(color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          height: 70,
                          width: 250,
                        )));
              },
              itemCount: playersProv.suspectsPlayers.length,
            ),
            button_display_index == playersProv.playersList.length
                ? RoundedButton(
                    title: "التالى",
                    onTapped: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FindOutScreen(),
                          ));
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
