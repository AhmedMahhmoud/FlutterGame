
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants.dart';
import '../../Home/views/home.dart';



class exitDialog extends StatelessWidget {
  const exitDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 4,
     // backgroundColor: Colors.white,
      title:  Center(
        child: Text(
          'متأكد؟',
          style: TextStyle(
fontSize: setResponsiveFontSize(20),
              fontWeight: FontWeight.bold,
              color: Colors.green),
        ),
      ),
      content:  Text('لو خرجت الدور هيبوظ',
          textAlign: TextAlign.center,
          style: TextStyle( color: Colors.green,fontSize: setResponsiveFontSize(18))),
      actions: <Widget>[
        Row(
          children: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 1.w)),
                height: 50.h,
                width: 100.w,
                child:  Center(
                  child: Text('لا خلاص',
                      textAlign: TextAlign.center,
                      style: TextStyle(
fontSize: setResponsiveFontSize(16),
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            FlatButton(
              onPressed: () async {
                navigateToPage(context,  Home());
                //SystemNavigator.pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 1.w)),
                height: 50.h,
                width: 100.w,
                child:  Center(
                  child: Text('هخرج',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: setResponsiveFontSize(16),
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}
