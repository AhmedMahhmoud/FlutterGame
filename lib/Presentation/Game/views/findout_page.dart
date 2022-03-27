import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'choices_page.dart';

class FindOutScreen extends StatefulWidget {
  @override
  State<FindOutScreen> createState() => _FindOutScreenState();
}

class _FindOutScreenState extends State<FindOutScreen> {
  AudioCache drums = AudioCache();
  bool countDown = true;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    drums.play(
      "sounds/drum.mp3",
    );
    Future.delayed(Duration(seconds: 3)).whenComplete(() {
      setState(() {
        countDown = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/gamebg.jpg",
                ),
                fit: BoxFit.fill)),
        child: countDown == false
            ?
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                'البـِــكـِـس هو ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: setResponsiveFontSize(24)),
              ),
              SizedBox(height: 90.h,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(     color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 4,
                  child: Row(
                    children: [
                      Container(
                          height: 200.h,
                          width: 200.w,
                          child: Lottie.asset(
                              'assets/lotties/whoisout.json')),
                      Text(
                        '${Provider.of<PlayersProvider>(context, listen: false).playersList[Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex].playerName}',
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: setResponsiveFontSize(22)),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 200.h,),
              RoundedActionButton(
                btnColor: ColorManager.successColor,
                title: "التالى",
                btnFunc: () {
                  navigateReplacmentToPage(
                      context, ChoiceScreen());
                },
              ),
            ],
          )
            : Center(
                child: Lottie.asset(
                  'assets/lotties/countdown.json',
                ),
              ),
      ),
    );
  }
}
