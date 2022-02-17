import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
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
  @override
  void initState() {
    askingGame();
    super.initState();
  }

  askingGame() {
    _pointer1 = 0;
    _playerList =
        Provider.of<PlayersProvider>(context, listen: false).playersList;
    _pointer2 = _playerList.length - 1;
    _askingPlayers = [..._playerList];
    // _askingPlayers.shuffle();
    print("pointer2 $_pointer2");
  }

  checkPlayersSimilarity() {
    setState(() {
      var tempRemoved = _askingPlayers[0];
      _askingPlayers.removeAt(0);

      _askingPlayers.insert(_pointer2, tempRemoved);
      _currentIndex++;
    });
    // String askedPlayer = _askedPlayers[0].playerName;
    // String askingPlayer = _askingPlayers[0].playerName;

    // if (askedPlayer == askingPlayer) {
    //   print(askingPlayer);
    //   print(askedPlayer);
    //   print("shuffling");
    //   setState(() {
    //     _askingPlayers.shuffle();
    //     _askedPlayers.shuffle();
    //   });
    //   checkPlayersSimilarity();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(_playerList[0].playerName);
        _playerList.shuffle();
        print(_playerList[0]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          AutoSizeText(
            "وقت الأسئلة",
            style:
                boldStyle.copyWith(color: ColorManager.primary, fontSize: 20),
          ),
          if (!_showQuestion) ...[
            Container(
              width: 200,
              child: AutoSizeText(
                "كل واحد هيسأل شخص تانى سؤال اضغط التالى عشان تعرف مين هيسأل مين",
                style: boldStyle.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            RoundedButton(
              title: "التالى",
              onTapped: () {
                setState(() {
                  _showQuestion = true;
                });
              },
            )
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
                  // setState(() {
                  //   // _askingPlayers.removeAt(0);
                  //   // _askedPlayers.removeAt(0);
                  // });
                  checkPlayersSimilarity();
                  // if (_askingPlayers.length != 0) checkPlayersSimilarity();
                },
              )
            ] else ...[
              Container(
                child: Text("New stage ",
                    style: boldStyle.copyWith(
                        color: ColorManager.primary, fontSize: 20)),
              )
            ]
          ]
        ],
      ),
    );
  }
}
