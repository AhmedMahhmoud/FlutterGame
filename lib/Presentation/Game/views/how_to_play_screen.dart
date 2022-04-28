import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../../../core/constants.dart';
import '../../Home/views/home.dart';

class HowToPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  navigateToPage(context,  Home()),
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/gameBackground.jpg'),
                        fit: BoxFit.cover)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-20.h,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 20.w),
                      child:   AnimatedTextKit(isRepeatingAnimation: false,displayFullTextOnTap: true,animatedTexts: [
                        TyperAnimatedText('هنفترض إنكم اختارتوا حيوانات وعددكم 5 ، يبقى الأبليكيشن هيختار واحد عشوائى منكم ويبقى ده اللي بره اللعبه والباقي هيظهرلهم اسم حيوان  \n\n كده اللعبه بدأت ، المفروض الأبليكيشن هيخليكم تقعدو تسألوا بعض اسأله بشكل عشوائى عن الحيوان ده بشرط الاساله لازم تكون إجابتها (اه / لا) عشان تستنتجوا من الإجابات مين اللي بره وعامل فيها عارف (البــِكــِس)\n\n وطبعا اللي بره هيحاول يلقط الحيوان ده ويعيش معاكم كإنه عارف الحيوان\n\nوفالأخر خالص هتصوتوا وكل واحد يشوف شاكك في مين ونشوف اللي بره اللعبه عرف يتباكس عليكم ولا انتم طلعتوا اصيع منه\n\nبالنسبه للنتيجة : كل واحد هيخمن صح هياخد 100 نقطه واللي بره اللعبه فالاخر خالص المفروض بيحاول يخمن الحيوان اللي الكلام كان عليه ويختاره من بين 8 اختيارات تانيه لو عرفه هياخد هو كمان 100 نقطه',
                        textAlign: TextAlign.end,textStyle:  TextStyle(
                                fontSize: setResponsiveFontSize(16),
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ],)


                      /*AutoSizeText(
                        'هنفترض إنكم اختارتوا حيوانات وعددكم 5 ، يبقى الأبليكيشن هيختار واحد عشوائى منكم ويبقى ده اللي بره اللعبه والباقي هيظهرلهم اسم حيوان ، خلينا نفترضه الاسد  \n\n كده اللعبه بدأت ، المفروض الأبليكيشن هيخليكم تقعدو تسألوا بعض اسأله بشكل عشوائى عن الحيوان ده بشرط الاساله لازم تكون إجابتها (اه / لا) عشان تستنتجوا من الإجابات مين اللي بره (البــِكــِس) وعامل فيها عارف\n\n وطبعا اللي بره هيحاول يلقط الحيوان ده ويعيش معاكم كإنه عارف الحيوان\n\nوفالأخر خالص هتصوتوا وكل واحد يشوف شاكك في مين ونشوف اللي بره اللعبه عرف يتباكس عليكم ولا انتم طلعتوا اصيع منه\n\nبالنسبه للنتيجة : كل واحد هيخمن صح هياخد 100 نقطه واللي بره اللعبه فالاخر خالص المفروض بيحاول يخمن الحيوان اللي الكلام كان عليه ويختاره من بين 8 اختيارات تانيه لو عرفه هياخد هو كمان 100 نقطه',
                        textAlign: TextAlign.end,

                        style: TextStyle(
                            fontSize: setResponsiveFontSize(16),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),*/
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
