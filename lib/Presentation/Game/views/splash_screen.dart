import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../../../Data/Providers/Players/players_provider.dart';
import '../../../Database/initalize.dart';
import '../../../core/constants.dart';

import '../../Home/views/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  void _startDelay() {
    _timer = Timer(const Duration(milliseconds: 4500), _goNext);
  }

  Future<void> intitalizeGame() async {
    await Init().initialize().whenComplete(() async {
      log('Filling players list from cache . . . ');
      await Provider.of<PlayersProvider>(context, listen: false)
          .fillPlayersFromCache();
    });
  }

  void _goNext() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (BuildContext c, Animation<double> a1, Animation<double> a2) =>
                Home(),
        transitionsBuilder: (BuildContext c, Animation<double> anim,
                Animation<double> a2, Widget child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  void initState() {


    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    intitalizeGame();
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(
                'assets/lotties/bg_splash2.json',
                repeat: false,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ZoomIn(
                        child: const Image(
                          image: AssetImage(
                            'assets/images/bakasa.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  ElasticInRight(
                    child: AutoSizeText('بـكـاسـة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: setResponsiveFontSize(28),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
