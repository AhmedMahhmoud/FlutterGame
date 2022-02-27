import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PLayerContainer extends StatelessWidget {
  final int playerIndex;
  final String playerName;
  final String playerImage;
  const PLayerContainer({
    this.playerIndex,
    this.playerName,
    this.playerImage,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 360,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  image: DecorationImage(
                      image: AssetImage(playerImage), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            AutoSizeText(
              playerName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                Provider.of<PlayersProvider>(context, listen: false)
                    .removePlayer(playerIndex);
              },
              child: Icon(
                FontAwesomeIcons.times,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: ColorManager.playersCardsColor[playerIndex],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorManager.playersCardsColor[playerIndex].withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
