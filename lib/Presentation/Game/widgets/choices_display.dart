import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
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
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);
    return Stack(
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
              child: content,
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
                headerImage,
              ),
            ),
          ),
        )
      ],
    );
  }
}
