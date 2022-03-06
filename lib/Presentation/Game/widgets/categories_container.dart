import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Column(
          children: [
            Container(
              width: 350,
              height: 30,
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(right: 20),
                width: 350,
                height: 90,
                alignment: Alignment.centerRight,
                child: Container(
                  width: 180,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        catTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        FontAwesomeIcons.angleRight,
                        color: Colors.white,
                      )
                    ],
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
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 20,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.white),
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage(catImage), fit: BoxFit.cover)),
          ),
        )
      ],
    );
  }
}
