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
    Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _currentIndex == _playerList.length
            ? Container()
            : Container(
                child: Container(
                child: SlideInDown(
                    duration: Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      opacity: test ? 0.0 : 1.0,
                      duration: const Duration(seconds: 1),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        child: Image.asset(
                          'assets/images/questionsTime.png',
                          height: 300.h,
                        ),
                      ),
                    )),
              )),
        if (!_showQuestion) ...[
          test == true
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 20.w,
                      height: 300.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/frame.png",
                              ),
                              fit: BoxFit.cover)),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Container(
                                child: Center(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: AutoSizeText(
                                        'كل واحد هيسأل شخص تانى سؤال \n اضغط التالى عشان تعرف \n مين هيسأل مين',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.getFont('Changa')
                                                    .fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize:
                                                setResponsiveFontSize(16)),
                                      ),
                                    ),
                                  ),
                                ),
                              )))),
                )
              : Container(),
          /*      Container(
            width: 200,
            child: AutoSizeText(
              "كل واحد هيسأل شخص تانى سؤال اضغط التالى عشان تعرف مين هيسأل مين",
              style: boldStyle.copyWith(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),*/

          test == true
              ? RoundedActionButton(
                  btnColor: ColorManager.successColor,
                  title: "التالى",
                  btnFunc: () {
                    setState(() {
                      _showQuestion = true;
                    });
                  },
                )
              : Container()
          /*     RoundedButton(
            title: "التالى",
            btnColor: ColorManager.successColor,
            btnFunc: () {
              setState(() {
                _showQuestion = true;
              });
            },
          )*/
        ] else ...[
          if (_currentIndex != _playerList.length) ...[
            Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  child: AutoSizeText(
                    " ${_askingPlayers[_pointer1].playerName} اسأل ${_askingPlayers[_pointer2].playerName} و حاول توقعة ",
                    style: boldStyle,
                  ),
                )),
            RoundedButton(
              title: "التالى",
              onTapped: () {
                checkPlayersSimilarity();
              },
            )
          ] else ...[
            RoundedButton(
              title: "التالى",
              onTapped: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RandomQuestionsTime(),
                    ));
              },
            )
          ]
        ]
      ],
    );
  }
}
