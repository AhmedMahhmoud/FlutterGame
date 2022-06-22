import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import '../../../Data/Providers/Players/players_provider.dart';
import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/Shared/rounded_action_button.dart';
import '../../../core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../widgets/ExitDialog.dart';
import 'choices_page.dart';

class FindOutScreen extends StatefulWidget {
  @override
  State<FindOutScreen> createState() => _FindOutScreenState();
}

class _FindOutScreenState extends State<FindOutScreen> {
  BannerAd _bannerAd;
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
/*    _bannerAd = createBannerAd()
      ..load()
      ..show();*/
  }

/*  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print('BannerAd event $event');
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
   /*     try {
          _bannerAd?.dispose();
          _bannerAd = null;
        } catch (e) {
          print(e);
        }*/
        await showDialog(
            context: context,
            builder: (BuildContext context) => ZoomIn(
                  child: const ExitDialog(),
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
                                filter:
                                    ImageFilter.blur(sigmaX: 30, sigmaY: 30),
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
                        try {
                          print(_bannerAd == null);
                          if (_bannerAd != null) {
                            _bannerAd.dispose();
                          }
                        } catch (e) {
                          print(e);
                        }

                        navigateToPage(context, const ChoiceScreen());
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
