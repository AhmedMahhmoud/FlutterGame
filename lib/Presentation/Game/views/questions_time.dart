import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/Presentation/Game/views/choices_page.dart';
import 'package:flutter_game/Presentation/Game/views/random_questions_time.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/constantData.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool _showQuestion = false;
  List<Players> _askingPlayers = [];
  List<Players> _playerList = [];
  int _currentIndex = 0;
  int _pointer1 = 0;
  int _pointer2;
  bool test = false;

  @override
  void initState() {
    askingGame();
    Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() {
      setState(() {
        test = true;
      });
    });
    super.initState();
  }

  askingGame() {
    _pointer1 = 0;
    _playerList =
        Provider.of<PlayersProvider>(context, listen: false).playersList;
    _pointer2 = _playerList.length - 1;
    _askingPlayers = [..._playerList];
  }

  checkPlayersSimilarity() {
    setState(() {
      var tempRemoved = _askingPlayers[0];
      _askingPlayers.removeAt(0);

      _askingPlayers.insert(_pointer2, tempRemoved);
      _currentIndex++;
    });
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _currentIndex == _playerList.length
            ? Container()
            : AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: SlideInDown(
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      opacity: test ? 0.0 : 1.0,
                      duration: const Duration(seconds: 1),
                      child: Image.asset(
                        'assets/images/questionsTime.png',
                        height: 300.h,
                      ),
                    )),
              ),
        if (!_showQuestion) ...[
          test == true
              ? ZoomIn(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(
                    seconds: 1,
                  ),
                  child: const DisplayTextInFrame(
                    text:
                        '???? ???????? ?????????? ?????? ???????? ???????? \n ???????? ???????????? ???????? ???????? \n ?????? ?????????? ??????',
                  ),
                )
              : Container(),
          /*      Container(
            width: 200,
            child: AutoSizeText(
              "???? ???????? ?????????? ?????? ???????? ???????? ???????? ???????????? ???????? ???????? ?????? ?????????? ??????",
              style: boldStyle.copyWith(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),*/

          test == true
              ? ZoomIn(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(
                    seconds: 1,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: RoundedActionButton(
                      btnColor: ColorManager.playersCardsColor[3],
                      title: '????????????',
                      btnFunc: () {
                        setState(() {
                          _showQuestion = true;
                        });
                      },
                    ),
                  ),
                )
              : Container()
          /*     RoundedButton(
            title: "????????????",
            btnColor: ColorManager.successColor,
            btnFunc: () {
              setState(() {
                _showQuestion =true;
              });
            },
          )*/
        ] else ...[
          DisplayTextInFrame(
            text:
                ' ${_askingPlayers[_pointer1].playerName} ???????? ${_askingPlayers[_pointer2].playerName} ?? ???????? ?????????? ',
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: RoundedActionButton(
              btnFunc: () {
                if (counter == _playerList.length - 1) {
                  navigateReplacmentToPage(context, RandomQuestionsTime());
                } else if (_currentIndex != _playerList.length) {
                  counter++;
                  checkPlayersSimilarity();
                }
              },
              btnColor: ColorManager.successColor,
              title: '????????????',
            ),
          )
          // ] else ...[
          //   Container(
          //     height: 500.h,
          //     child: Center(
          //       child: RoundedActionButton(
          //         btnFunc: () {
          //           MaterialPageRoute(
          //             builder: (context) => RandomQuestionsTime(),
          //           );
          //         },
          //         btnColor: ColorManager.successColor,
          //         title: "????????????",
          //       ),
          //     ),
          //   )
          // ]
        ]
      ],
    );
  }
}

class DisplayTextInFrame extends StatelessWidget {
  final String text;

  const DisplayTextInFrame({
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
          width: MediaQuery.of(context).size.width - 20.w,
          height: 300.h,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/frame.png',
                  ),
                  fit: BoxFit.cover)),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: AutoSizeText(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: setResponsiveFontSize(16)),
                      ),
                    ),
                  )))),
    );
  }
}
