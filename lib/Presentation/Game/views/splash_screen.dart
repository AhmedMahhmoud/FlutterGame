import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/constants.dart';
import '../../Home/views/home.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 4500), _goNext);
  }

  _goNext() {

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => Home(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );






   /* navigateReplacmentToPage(
        context, Home());*/
  }

  @override
  void initState() {

    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox( height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,child:
              Lottie.asset(
                  'assets/lotties/bg_splash2.json',repeat: false, fit: BoxFit.cover , ) ,),
            Padding(
              padding:  EdgeInsets.only(left: 12.w),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/3.4,
                      width: MediaQuery.of(context).size.width/2,
                      child:ZoomIn(
                        child: const Image(
                          image: AssetImage(
                            'assets/images/bakasa.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23.h,),
                  ElasticInRight(
                    child: AutoSizeText(
                      'بـكـاسـة',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          setResponsiveFontSize(
                              28),
                          fontWeight:
                          FontWeight.bold,fontFamily:GoogleFonts.getFont('Cairo').fontFamily) ),
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