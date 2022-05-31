import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesCard extends StatelessWidget {
  final Color catColor;
  final String catImage;
  final String catTitle;
  final Function onTap;
  const CategoriesCard({
    this.catImage,
    this.catColor,
    this.catTitle,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        //  alignment: Alignment.topLeft,
        children: [
          Column(
            children: [
              SizedBox(
                width: 350.w,
                height: 100.h,
              ),
              Container(
                padding: EdgeInsets.only(right: 20.w),
                width: 350.w,
                height: 120.h,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: SizedBox(
                    width: 180.w,
                    height: 90.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: AutoSizeText(
                            catTitle,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: setResponsiveFontSize(17),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        /*     Expanded(child: Container()),
                      const  Icon(
                          FontAwesomeIcons.angleRight,
                          color: Colors.white,
                        )*/
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        catColor,
                        catColor.withOpacity(0.5),
                      ]),
                  boxShadow: [
                    BoxShadow(
                      color: catColor.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Positioned(
            left: 40.w,
            top: 50.h,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2.w, color: Colors.white),
                  color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage(catImage), fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}
