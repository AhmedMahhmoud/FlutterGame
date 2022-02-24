import 'dart:math';
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_game/Data/Providers/Animal/AnimalProvider.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Database/AnimalDatabase.dart';
import 'package:flutter_game/Presentation/Game/views/questions_time.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/animalData.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';

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
  String randomAnimalName;

  @override
  void initState() {
    _whoIsOutIndex = _getRandomIndex();
    Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex =
        _whoIsOutIndex;
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
    randomAnimalName = animalData.itemsName[random];
    Provider.of<AnimalProvider>(context, listen: false)
        .setCurrentAnimal(randomAnimalName);
    return randomAnimalName;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<PlayersProvider>(
          builder: (context, value, child) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      child: _turnNumber < value.playersList.length * 2
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Lottie.asset('assets/lotties/bg_top.json',
                                    repeat: true, fit: BoxFit.fill),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: _switchToNewPlayer
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 20),
                                          child: AutoSizeText(
                                            "ادي الموبايل ل ${value.playersList[_currentIndex].playerName} عشان يعرف هو اللي برا اللعبة ولا لا !",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.getFont(
                                                        'Changa')
                                                    .fontFamily,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          elevation: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(
                                              children: [
                                                AutoSizeText(
                                                  'خربش يا ${value.playersList[_currentIndex].playerName} وشوف انت برا ولا جوا',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.getFont(
                                                                  'Changa')
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Scratcher(
                                                  brushSize: 11,
                                                  threshold: 50,
                                                  color: Colors.grey,
                                                  onScratchStart: () {
                                                    // play sound
                                                  },
                                                  onScratchEnd: () {
                                                    // off sound
                                                  },
                                                  image: Image.asset(
                                                      'assets/images/scratch.PNG'),
                                                  onChange: (value) => print(
                                                      "Scratch progress: $value%"),
                                                  onThreshold: () => print(
                                                      "Threshold reached, you won!"),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Container(
                                                        color: Colors.white,
                                                        child: AutoSizeText(
                                                          _currentIndex ==
                                                                  _whoIsOutIndex
                                                              ? "برا"
                                                              : randomAnimalName,
                                                          style: boldStyle,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              /*  SizedBox(
                                  height: 20,
                                ),*/
                                if (_currentIndex <
                                        (value.playersList.length) &&
                                    _turnNumber <
                                        value.playersList.length * 2) ...[
                                  GestureDetector(
                                    onTap: () {
                                      _switchToNewPlayer = !_switchToNewPlayer;

                                      if (_switchToNewPlayer &&
                                          _turnNumber % 2 != 0) {
                                        incrementIndex();
                                      }
                                      goNextTurn();
                                    },
                                    child: RotatedBox(
                                      quarterTurns: 2,
                                      child: Container(
                             //          color: Colors.red,
                                        height: 200,
                                        width: 200,
                                        child: Lottie.asset(
                                            'assets/lotties/next.json',
                                            repeat: true,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )

                                  /*  RoundedButton(
                                    title: "التالى",
                                    onTapped: () {
                                      _switchToNewPlayer = !_switchToNewPlayer;

                                      if (_switchToNewPlayer &&
                                          _turnNumber % 2 != 0) {
                                        incrementIndex();
                                      }
                                      goNextTurn();
                                    },
                                  ),*/
                                ]
                              ],
                            )
                          : QuestionScreen(),
                    ),
                    Container(
                     // color: Colors.red,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Lottie.asset('assets/lotties/bg_bottom.json',
                              repeat: true, fit: BoxFit.fill)),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ));
          },
        ),
      ),
    );
  }
}
