import 'dart:math';
import 'dart:math' as math;

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
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

import 'choices_page.dart';

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

  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;
  String path = 'sounds/scratchSound.mp3';

  @override
  void initState() {
    _whoIsOutIndex = _getRandomIndex();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      setState(() {
        audioPlayerState = state;
      });
    });
    Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex =
        _whoIsOutIndex;
    _getRandomAnimal();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
  }

  playMusic() async {
    await audioCache.play(path);
  }

  pauseMusic() async {
    await audioPlayer.pause();
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
                                              horizontal: 20, vertical: 20),
                                          child: Container(
                                            child: Center(
                                              child: Container(
                                                //   height: 200,
                                                // width: 200,
                                                color: ColorManager.accentColor,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: AutoSizeText(
                                                    "ادي الموبايل ل ${value.playersList[_currentIndex].playerName} عشان يعرف هو اللي برا اللعبة ولا لا !",
                                                    //  textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            GoogleFonts.getFont(
                                                                    'Changa')
                                                                .fontFamily,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorManager
                                                            .primary,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.elliptical(90, 90),
                                                bottomRight:
                                                    Radius.elliptical(90, 90)),
                                          ),
                                          elevation: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                ClayText(
                                                  'خربش يا ${value.playersList[_currentIndex].playerName} وشوف انت برا ولا جوا',
                                                  style: funckyStyle,
                                                  color: ColorManager.primary,
                                                  // textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Scratcher(
                                                  brushSize: 11,
                                                  threshold: 50,
                                                  color: Colors.grey,
                                                  onScratchStart: () {
                                                    audioPlayerState ==
                                                            AudioPlayerState
                                                                .PLAYING
                                                        ? pauseMusic()
                                                        : playMusic();
                                                    // play sound
                                                  },
                                                  onScratchEnd: () {
                                                    audioPlayerState ==
                                                            AudioPlayerState
                                                                .PLAYING
                                                        ? pauseMusic()
                                                        : playMusic();
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
                                                    child: ClayContainer(
                                                      color: Colors.amberAccent,
                                                      height: 80,
                                                      width: 80,
                                                      borderRadius: 50,
                                                      curveType:
                                                          CurveType.concave,
                                                      child: Center(
                                                        child: AutoSizeText(
                                                          _currentIndex ==
                                                                  _whoIsOutIndex
                                                              ? "برا"
                                                              : randomAnimalName,
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .getFont(
                                                                          'Cairo')
                                                                  .fontFamily,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),

                                                    /*    Container(
                                                        color: Colors.white,
                                                        child: ),*/
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
                                SizedBox(
                                  height: 20,
                                ),
                                if (_currentIndex <
                                        (value.playersList.length) &&
                                    _turnNumber <
                                        value.playersList.length * 2) ...[
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
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Lottie.asset('assets/lotties/bg_bottom.json',
                                repeat: true, fit: BoxFit.fill)),
                      ),
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
