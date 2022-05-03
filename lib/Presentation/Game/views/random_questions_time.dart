import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/players_provider.dart';
import 'package:flutter_game/Presentation/Game/views/voting_page.dart';
import 'package:flutter_game/Presentation/Game/widgets/choices_display.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/exitDialog.dart';
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
    return WillPopScope(
      onWillPop: ()async{
        await showDialog(
            context: context,
            builder: (BuildContext context) => ZoomIn(
              child: const exitDialog(),
            ));
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/gameBackground.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              AutoSizeText(
                'اسألة عشوائية',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: setResponsiveFontSize(20),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              DisplayChoices(
                headerImage: playersProv
                    .playersList[playersProv.askingPlayerIndex].playerImage,
                content: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.w,horizontal: 12.w),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: AutoSizeText(
                          '${playersProv.playersList[playersProv.askingPlayerIndex].playerName} اختار شخص عايز تسأله لو لسه شاكك او دوس علي صوت لو جاهز',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: setResponsiveFontSize(16)),
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
                                    Provider.of<PlayersProvider>(context,
                                                listen: false)
                                            .lastAskingPlayerIndex =
                                        Provider.of<PlayersProvider>(context,
                                                listen: false)
                                            .askingPlayerIndex;

                                    // updating lastAsking and currently asking player index

                                    await Provider.of<PlayersProvider>(context,
                                            listen: false)
                                        .getAskingPlayer();
                                  },
                                  child: Container(
                                    margin:  EdgeInsets.symmetric(
                                        horizontal: 10.w),
                                    decoration: BoxDecoration(
                                        color: ColorManager.darkGrey,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: AutoSizeText(
                                        playersProv
                                            .randomPlayers[index].playerName,
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
                        itemCount: playersProv.randomPlayers.length,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 10.h),
                      child: RoundedActionButton(
                        title: 'صوت',
                        btnColor: ColorManager.successColor,
                        btnFunc: () {
                          navigateReplacmentToPage(context, VotingScreen());
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
