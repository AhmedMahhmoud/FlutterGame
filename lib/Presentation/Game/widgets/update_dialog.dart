import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Shared/rounded_action_button.dart';

class UpdateDialog extends StatelessWidget {
  final Function onPressed;

  // ignore: use_key_in_widget_constructors
  const UpdateDialog({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: 400.w,
            height: 250.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/gameBackground.jpg',
                  ),
                  fit: BoxFit.cover,
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 80.w,
                  height: 80.h,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        // ignore: prefer_single_quotes
                        image: AssetImage(
                          'assets/images/bakasa.png',
                        ),
                      )),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: AutoSizeText(
                    'فية ابديت للعبة جديد نزل !',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: setResponsiveFontSize(18),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RoundedActionButton(
                    btnColor: ColorManager.successColor,
                    title: 'تنزيل',
                    btnFunc: () {
                      onPressed();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
