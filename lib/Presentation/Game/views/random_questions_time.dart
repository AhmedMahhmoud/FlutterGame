import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Presentation/Game/views/voting_page.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'choices_page.dart';

class RandomQuestionsTime extends StatefulWidget {
  @override
  _RandomQuestionsTimeState createState() => _RandomQuestionsTimeState();
}

class _RandomQuestionsTimeState extends State<RandomQuestionsTime> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      Provider.of<PlayersProvider>(context, listen: false).getAskingPlayer();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/gameBackground.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            AutoSizeText(
              "اسألة عشوائية",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 350.w,
                      height: 60.h,
                    ),
                    Container(
                      width: 350.w,
                      height: 700.h,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.w),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: AutoSizeText(
                                '${playersProv.playersList[playersProv.askingPlayerIndex].playerName} اختار شخص عايز تسأله لو لسه شاكك او دوس علي صوت لو جاهز',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () async {
                                          print('tapped');
                                          Provider.of<PlayersProvider>(context,
                                                      listen: false)
                                                  .lastAskingPlayerIndex =
                                              Provider.of<PlayersProvider>(
                                                      context,
                                                      listen: false)
                                                  .askingPlayerIndex;

                                          // updating lastAsking and currently asking player index

                                          await Provider.of<PlayersProvider>(
                                                  context,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: ColorManager.darkGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: AutoSizeText(
                                              playersProv.randomPlayers[index]
                                                  .playerName,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          height: 70.h,
                                          width: 250.w,
                                        )));
                              },
                              itemCount: playersProv.randomPlayers.length,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: RoundedActionButton(
                              title: "صوت",
                              btnColor: ColorManager.successColor,
                              btnFunc: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VotingScreen(),
                                    ));
                              },
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff8435DE),
                                Color(0xff8435DE).withOpacity(0.8)
                              ])),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.all(10),
                    height: 100.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff8435DE),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff8435DE),
                      backgroundImage: AssetImage(
                        playersProv.playersList[playersProv.askingPlayerIndex]
                            .playerImage,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
