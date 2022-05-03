import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/Presentation/Game/widgets/update_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/constants.dart';
import '../../Home/views/home.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({
    Key key,
  }) : super(key: key);

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
            child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'متأكد؟',
                  style: boldStyle.copyWith(
                      color: Colors.white, fontSize: setResponsiveFontSize(20)),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 60.h,
                child: Center(
                  child: AutoSizeText('لو خرجت الدور هيبوظ',
                      textAlign: TextAlign.center,
                      style: boldStyle.copyWith(color: Colors.white)),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Row(
                  children: [
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.green, width: 1.w)),
                        height: 50.h,
                        width: 100.w,
                        child: Center(
                          child: AutoSizeText('لا خلاص',
                              textAlign: TextAlign.center,
                              style: boldStyle.copyWith(
                                  color: ColorManager.successColor)),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        navigateToPage(context, Home());
                        //SystemNavigator.pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.red, width: 1.w)),
                        height: 50.h,
                        width: 100.w,
                        child: Center(
                          child: AutoSizeText('هخرج',
                              textAlign: TextAlign.center,
                              style: boldStyle.copyWith(
                                  color: ColorManager.failColor)),
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ]),
          ),
        ),
      ),
    );
    // return AlertDialog(
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //   elevation: 4,
    //   // backgroundColor: Colors.white,
    //   title: Center(
    //     child: Text(
    //       'متأكد؟',
    //       style: TextStyle(
    //           fontSize: setResponsiveFontSize(20),
    //           fontWeight: FontWeight.bold,
    //           color: Colors.green),
    //     ),
    //   ),
    //   content: Text('لو خرجت الدور هيبوظ',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //           color: Colors.green, fontSize: setResponsiveFontSize(18))),
    //   actions: <Widget>[
    //     Row(
    //       children: [
    //         FlatButton(
    //           onPressed: () => Navigator.of(context).pop(false),
    //           child: Container(
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: Colors.white,
    //                 border: Border.all(color: Colors.green, width: 1.w)),
    //             height: 50.h,
    //             width: 100.w,
    //             child: Center(
    //               child: Text('لا خلاص',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontSize: setResponsiveFontSize(16),
    //                       color: Colors.green,
    //                       fontWeight: FontWeight.bold)),
    //             ),
    //           ),
    //         ),
    //         FlatButton(
    //           onPressed: () async {
    //             navigateToPage(context, Home());
    //             //SystemNavigator.pop();
    //           },
    //           child: Container(
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: Colors.white,
    //                 border: Border.all(color: Colors.red, width: 1.w)),
    //             height: 50.h,
    //             width: 100.w,
    //             child: Center(
    //               child: Text('هخرج',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontSize: setResponsiveFontSize(16),
    //                       color: Colors.red,
    //                       fontWeight: FontWeight.bold)),
    //             ),
    //           ),
    //         ),
    //       ],
    //       mainAxisAlignment: MainAxisAlignment.center,
    //     )
    //   ],
    // );
  }
}
