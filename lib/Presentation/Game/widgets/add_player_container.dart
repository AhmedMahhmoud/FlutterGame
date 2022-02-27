import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPLayerContainer extends StatelessWidget {
  final Function ontaaped;
  AddPLayerContainer(this.ontaaped);
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1,
      dashPattern: [3, 3],
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      color: Colors.white,
      child: Container(
        height: 75,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              DottedBorder(
                borderType: BorderType.Circle,
                color: Colors.white,
                strokeWidth: 1,
                dashPattern: [3, 3],
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              AutoSizeText(
                "لاعب جديد",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: ontaaped,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorManager.successColor.withAlpha(200),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.successColor.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
