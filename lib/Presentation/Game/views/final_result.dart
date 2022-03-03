import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FinalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Color(0xff199cd0),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Lottie.asset('assets/lotties/score.json',
                            repeat: true, fit: BoxFit.fill))),
                AutoSizeText(
                  "النتائج",
                  style: boldStyle.copyWith(
                      fontSize: setResponsiveFontSize(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Center(
                  child: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 90),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                playersProv.playersList[index].playerName,
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                  playersProv.playersList[index].playerScore
                                      .toString(),
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ));
                      },
                      itemCount: playersProv.playersList.length,
                    ),
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
