import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/players_provider.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/exitDialog.dart';
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
      'sounds/drum.mp3',
    );
    Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      setState(() {
        countDown = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage(
                    'assets/images/gamebg.jpg',
                  ),
                  fit: BoxFit.fill)),
          child: countDown == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    AutoSizeText(
                      'البـِــكـِـس هو ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: setResponsiveFontSize(24)),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                            //color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 200.h,
                                        width: 200.w,
                                        child: Lottie.asset(
                                            'assets/lotties/whoisout.json')),
                                    AutoSizeText(
                                      Provider.of<PlayersProvider>(context,
                                              listen: false)
                                          .playersList[
                                              Provider.of<PlayersProvider>(
                                                      context,
                                                      listen: false)
                                                  .whoIsOutIndex]
                                          .playerName,
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.bold,
                                          fontSize: setResponsiveFontSize(22)),
                                    )
                                  ],
                                ),
                              ),
                            ))),
                    SizedBox(
                      height: 200.h,
                    ),
                    RoundedActionButton(
                      btnColor: ColorManager.successColor,
                      title: 'التالى',
                      btnFunc: () {
                        navigateToPage(context, ChoiceScreen());
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
      ),
    );
  }
}
