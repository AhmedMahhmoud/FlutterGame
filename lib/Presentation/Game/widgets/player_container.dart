import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 75.h,
      width: 360.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.w,
                    color: Colors.white,
                  ),
                  image: DecorationImage(
                      image: AssetImage(playerImage), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15.w,
            ),
            AutoSizeText(
              playerName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: setResponsiveFontSize(18),
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                Provider.of<PlayersProvider>(context, listen: false)
                    .removePlayer(playerIndex);
              },
              child: const Icon(
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
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
    );
  }
}

class PlayerRanking extends StatelessWidget {
  final int playerIndex;
  final String playerName;
  final String playerImage;
  final int playerScore;
  const PlayerRanking({
    this.playerIndex,
    this.playerName,
    this.playerImage,
    this.playerScore,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 360.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2.w,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                          image: AssetImage(playerImage), fit: BoxFit.cover)),
                ),
                playerIndex <= 2
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 25.w,
                          height: 25.h,
                          child: Center(
                            child: AutoSizeText(
                              (playerIndex + 1).toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: playerIndex == 0
                                ? const Color(0xffF1CB4D)
                                : playerIndex == 1
                                    ? const Color(0xffAAC0CD)
                                    : const Color(0xffEB9F49),
                            shape: BoxShape.circle,
                          ),
                        ))
                    : Container()
              ],
            ),
             SizedBox(
              width: 15.w,
            ),
            AutoSizeText(
              playerName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: setResponsiveFontSize(18),
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            Directionality(
              textDirection: TextDirection.rtl,
              child: AutoSizeText(
                "${playerScore.toString()} \nنقطة ",
                style: TextStyle(
                    fontSize: setResponsiveFontSize(16),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
    );
  }
}

/*
class PlayerRanking extends StatelessWidget {
  final int playerIndex;
  final String playerName;
  final String playerImage;
  final int playerScore;
  const PlayerRanking({
    this.playerIndex,
    this.playerName,
    this.playerImage,
    this.playerScore,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 360.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                          image: AssetImage(playerImage), fit: BoxFit.cover)),
                ),
                playerIndex <= 2
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 25,
                          height: 25,
                          child: Center(
                            child: AutoSizeText(
                              (playerIndex + 1).toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: playerIndex == 0
                                ? Color(0xffF1CB4D)
                                : playerIndex == 1
                                    ? Color(0xffAAC0CD)
                                    : Color(0xffEB9F49),
                            shape: BoxShape.circle,
                          ),
                        ))
                    : Container()
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            AutoSizeText(
              playerName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: setResponsiveFontSize(18),
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            Directionality(
              textDirection: TextDirection.rtl,
              child: AutoSizeText(
                "${playerScore.toString()} \nنقطة ",
                style: TextStyle(
                    fontSize: setResponsiveFontSize(16),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
*/
