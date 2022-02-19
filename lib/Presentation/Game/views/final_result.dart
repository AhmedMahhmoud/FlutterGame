import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

class FinalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(

              children: [
                AutoSizeText(
                  "النتائج",
                  style: boldStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primary),
                ),
                Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(playersProv.playersList[index].playerName),
                          Text(playersProv.playersList[index].playerScore.toString()),
                        ],
                      ));
                    },
                    itemCount: playersProv.playersList.length,
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
