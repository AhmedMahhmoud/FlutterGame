import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Database/AnimalDatabase.dart';
import 'package:flutter_game/Presentation/Game/views/questions_time.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/animalData.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

class WhoIsOut extends StatefulWidget {
  @override
  _WhoIsOutState createState() => _WhoIsOutState();
}

class _WhoIsOutState extends State<WhoIsOut> {
  int _whoIsOutIndex;
  int _currentIndex = 0;
  bool _switchToNewPlayer = true;
  int _playersLength;
  int _turnNumber = 0; // (number of players *2)
  String _randomAnimalName;
  @override
  void initState() {
    _whoIsOutIndex = _getRandomIndex();
    _getRandomAnimal();
    super.initState();
  }

  goNextTurn() {
    setState(() {
      _turnNumber++;
    });
  }

  incrementIndex() {
    if (_currentIndex < _playersLength - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  String _getRandomAnimal() {
    int animalsTableLength = animalData.itemsName.length;
    final random = Random().nextInt(animalsTableLength);
    _randomAnimalName = animalData.itemsName[random];
    print("Animal name is :$_randomAnimalName ");
    return _randomAnimalName;
  }

  int _getRandomIndex() {
    _playersLength =
        Provider.of<PlayersProvider>(context, listen: false).playersList.length;

    final random = Random().nextInt(_playersLength);
    return random;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlayersProvider>(
        builder: (context, value, child) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                child: _turnNumber < value.playersList.length * 2
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(
                            value.playersList[_currentIndex].playerName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorManager.primary),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: _switchToNewPlayer
                                ? AutoSizeText(
                                    "ادي الموبايل ل ${value.playersList[_currentIndex].playerName} عشان يعرف هو اللي برا اللعبة ولا لا !",
                                    style: boldStyle,
                                  )
                                : _currentIndex == _whoIsOutIndex
                                    ? AutoSizeText(
                                        "انت اللى برا حاول تعرف اسم الحيوان",
                                        style: boldStyle,
                                      )
                                    : AutoSizeText(
                                        "انت جوة اللعبة حاول تعرف مين اللي برة اسم الحيوان :$_randomAnimalName",
                                        style: boldStyle,
                                        textAlign: TextAlign.center,
                                      ),
                          ),
                          if (_currentIndex < (value.playersList.length) &&
                              _turnNumber < value.playersList.length * 2) ...[
                            RoundedButton(
                              title: "التالى",
                              onTapped: () {
                                _switchToNewPlayer = !_switchToNewPlayer;

                                if (_switchToNewPlayer &&
                                    _turnNumber % 2 != 0) {
                                  incrementIndex();
                                }
                                goNextTurn();
                              },
                            )
                          ]
                        ],
                      )
                    : QuestionScreen(),
              ));
        },
      ),
    );
  }
}
