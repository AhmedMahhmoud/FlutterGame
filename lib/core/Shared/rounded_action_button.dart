import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedActionButton extends StatelessWidget {
  final Color btnColor;
  final String title;
  final Function btnFunc;
  const RoundedActionButton({
    this.btnColor,
    this.title,
    this.btnFunc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnFunc,
      child: Container(
        height: 55.h,
        width: 190.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: AutoSizeText(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: setResponsiveFontSize(18),
                  color: Colors.white),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: btnColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
