import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:page_transition/page_transition.dart';

import 'ColorManager/ColorManager.dart';

TextStyle boldStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: setResponsiveFontSize(17));

TextStyle funckyStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: ColorManager.accentColor,
    fontFamily: 'Cairo');

double setResponsiveFontSize(size) {
  return ScreenUtil().setSp(size);
}

navigateToPage(BuildContext context, page) {
  Navigator.push(
    context,
    PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
        curve: Curves.bounceInOut,
        inheritTheme: true,
        ctx: context),
  );
}

navigateReplacmentToPage(BuildContext context, page) {
  Navigator.pushReplacement(
    context,
    PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
        curve: Curves.bounceInOut,
        inheritTheme: true,duration: const Duration(milliseconds: 500),
        ctx: context),
  );
}

showAnimatedToast(BuildContext context, String content) {
  showToast(
    content,
    context: context,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.center,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}

const kTextFieldDecorationWhite = InputDecoration(
  isDense: true,

  contentPadding:  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  hintText: 'Enter a value',
  hintStyle:
      TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
  fillColor: Colors.white,
  filled: true,
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffD7D7D7), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
//  contentPadding: EdgeInsets.symmetric(),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff4a4a4a), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff4a4a4a), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

class RoundedButton extends StatelessWidget {
  final String title;
  final Color btnColor;
  final Function onTapped;

  const RoundedButton({
    this.title,
    this.onTapped,
    this.btnColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorManager.primary, width: 2)),
        child: Center(
          child: AutoSizeText(
            title,
            style: TextStyle(
                fontSize: setResponsiveFontSize(17),
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
                fontFamily: 'Changa'),
          ),
        ),
      ),
    );
  }
}
