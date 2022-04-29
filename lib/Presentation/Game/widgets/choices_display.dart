import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/players_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayChoices extends StatelessWidget {
  const DisplayChoices({
    this.content,
    this.headerImage,
    Key key,
  }) : super(key: key);
  final Widget content;
  final String headerImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 350.w,
              height: 90.h,
            ),
            Container(
              width: 350.w,
              height: 650.h,
              child: content,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xff8435DE),
                        const Color(0xff8435DE).withOpacity(0.8)
                      ])),
            ),
          ],
        ),
        Positioned(
          top: 10.h,
          child: Container(
            width: 100.w,
            padding: const EdgeInsets.all(10),
            height: 100.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff8435DE),
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xff8435DE),
              backgroundImage: AssetImage(
                headerImage,
              ),
            ),
          ),
        )
      ],
    );
  }
}
