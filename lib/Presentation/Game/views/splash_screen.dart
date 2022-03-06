import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game/Presentation/Home/views/home.dart';
import 'package:flutter_game/core/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 3), () {
    //   navigateToPage(context, Home());
    // });

    super.initState();
  }

  double opacityLevel = 1.0;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
            opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                "count is $counter",
                key: ValueKey<int>(counter),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(milliseconds: 2),
              child: Text(
                "count is $counter",
                key: ValueKey<int>(counter),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
