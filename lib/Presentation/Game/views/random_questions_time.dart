import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Presentation/Game/views/voting_page.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

import 'choices_page.dart';

class RandomQuestionsTime extends StatefulWidget {
  @override
  _RandomQuestionsTimeState createState() => _RandomQuestionsTimeState();
}

class _RandomQuestionsTimeState extends State<RandomQuestionsTime> {
  @override
  void initState() {
    Provider.of<PlayersProvider>(context, listen: false).getAskingPlayer();
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
                '${playersProv.playersList[playersProv.askingPlayerIndex].playerName} اختار شخص عايز تسأله لو لسه شاكك او دوس علي صوت لو جاهز',
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
                          print('tapped');
                          Provider.of<PlayersProvider>(context, listen: false)
                                  .lastAskingPlayerIndex =
                              Provider.of<PlayersProvider>(context,
                                      listen: false)
                                  .askingPlayerIndex;

                          // updating lastAsking and currently asking player index

                          await Provider.of<PlayersProvider>(context,
                                  listen: false)
                              .getAskingPlayer();

                          /*await Provider.of<PlayersProvider>(context, listen: false)
                            .assignIndex();*/

                          /*    Provider.of<PlayersProvider>(context, listen: false)
                            .lastAskingPlayerIndex =
                            Provider.of<PlayersProvider>(context, listen: false)
                                .askingPlayerIndex;*/
                        },
                        child: Container(
                          color: Colors.blue,
                          child: Text(
                            playersProv.randomPlayers[index].playerName,
                            style: TextStyle(color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          height: 70,
                          width: 250,
                        )));
              },
              itemCount: playersProv.randomPlayers.length,
            ),
            SizedBox(
              height: 100,
            ),
            RoundedButton(
              title: "صوت",
              onTapped: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VotingScreen(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
