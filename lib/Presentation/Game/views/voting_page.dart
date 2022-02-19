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
  int tmpIndex = 0;

  @override
  void initState() {
    Provider.of<PlayersProvider>(context, listen: false)
        .getSuspectsPlayers(playerIndex);
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
                          setState(() {
                            tmpIndex++;
                          });

                          if (playerIndex <
                              playersProv.playersList.length - 1) {
                            print('tapped ');

                            setState(() {
                              playerIndex++;
                            });

                            await Provider.of<PlayersProvider>(context,
                                    listen: false)
                                .getSuspectsPlayers(playerIndex);

                            if (playersProv
                                    .playersList[playerIndex-1].playerName !=
                                playersProv
                                    .playersList[playersProv.whoIsOutIndex]
                                    .playerName) {

                              if (playersProv.suspectsPlayers[index].playerName ==
                                  playersProv
                                      .playersList[playersProv.whoIsOutIndex]
                                      .playerName) {
                                print('correct choice');
                                playersProv
                                    .playersList[playerIndex].playerScore += 100;
                              } else {
                                print('wrong choice');

                            /*    playersProv.playersList[playerIndex].playerScore =
                                    (playersProv.playersList[playerIndex]
                                        .playerScore -
                                        100)
                                        .abs();*/
                              }
                            }
                            else{
                              print('bara el salfa');
                            }

                          }
                          print('score ${playersProv.playersList[playerIndex].playerScore}');
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
            tmpIndex == playersProv.playersList.length
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
