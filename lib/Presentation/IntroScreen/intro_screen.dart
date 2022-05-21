// // ignore_for_file: deprecated_member_use

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import '../../core/ColorManager/ColorManager.dart';
// import '../../core/constants.dart';
// import 'Widgets/slide_cliper.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class IntroScreen extends StatelessWidget {
//   const IntroScreen({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double appPadding = 20.0;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorManager.backGroundColor,
//         body: PageView(
//           children: [
//             Stack(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     SizedBox(
//                         width: 300.w,
//                         height: 200.h,
//                         child: Lottie.network(
//                             'https://assets8.lottiefiles.com/packages/lf20_i9arxzcg.json')),
//                     ClipPath(
//                       clipper: SlandingClipper(),
//                       child: Container(
//                         height: size.height * 0.5,
//                         color: ColorManager.primary,
//                       ),
//                     )
//                   ],
//                 ),
//                 Positioned(
//                   top: size.height * 0.55,
//                   child: Container(
//                     width: size.width,
//                     padding: EdgeInsets.all(appPadding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         AutoSizeText(
//                           'أول مرحلة',
//                           textAlign: TextAlign.end,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: setResponsiveFontSize(30),
//                           ),
//                         ),
//                         AutoSizeText(
//                           'مين برا اللعبة ؟',
//                           textAlign: TextAlign.end,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: setResponsiveFontSize(26),
//                           ),
//                         ),
//                         SizedBox(
//                           height: size.height * 0.04,
//                         ),
//                         // Text(
//                         //   "ن عليه ويختاره من بين 8 اختيارات تانيه لو عرفه هياخد هو كمان 100 نقطه',",
//                         //   style: boldStyle.copyWith(
//                         //       fontWeight: FontWeight.w900,
//                         //       fontSize: setResponsiveFontSize(17),
//                         //       color: Colors.white.withOpacity(0.6)),
//                         //   textAlign: TextAlign.right,
//                         // )
//                         AnimatedTextKit(
//                           isRepeatingAnimation: false,
//                           displayFullTextOnTap: true,
//                           animatedTexts: [
//                             TyperAnimatedText(
//                                 'دى المرحلة اللي بتنقلوا الموبايل بينكم و بين بعض  عشان كل واحد فيكم يعرف هو جوا ولا برا اللعبة\n  برا اللعبة :   يعني  الشخص اللي بينكم ال مش هيكون عارف الحاجة اللي بتتلعب ',
//                                 textAlign: TextAlign.end,
//                                 textStyle: TextStyle(
//                                     fontSize: setResponsiveFontSize(17),
//                                     color: Colors.white.withOpacity(0.6),
//                                     fontWeight: FontWeight.w900))
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   left: 0,
//                   right: 0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: appPadding / 4),
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 2),
//                             shape: BoxShape.circle,
//                             color: Colors.white),
//                       ),
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: appPadding / 4),
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 1),
//                             shape: BoxShape.circle,
//                             color: Colors.black),
//                       ),
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: appPadding / 4),
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 1),
//                             shape: BoxShape.circle,
//                             color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: appPadding * 1),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         alignment: Alignment.centerRight,
//                         child: FlatButton(
//                           onPressed: () => print('Skip'),
//                           child: AutoSizeText('ابدأ',
//                               style: boldStyle.copyWith(
//                                   fontSize: setResponsiveFontSize(24))),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: EdgeInsets.only(right: appPadding),
//                       //   child: FloatingActionButton(
//                       //     onPressed: () {
//                       //       Navigator.push(
//                       //         context,
//                       //         MaterialPageRoute(
//                       //           builder: (_) => OnboardingScreenTwo(),
//                       //         ),
//                       //       );
//                       //     },
//                       //     backgroundColor: white,
//                       //     child: Icon(
//                       //       Icons.navigate_next_rounded,
//                       //       color: black,
//                       //       size: 30,
//                       //     ),
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
