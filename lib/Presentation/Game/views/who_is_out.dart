import 'dart:math';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
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
import 'package:flutter_game/core/Shared/constantData.dart';
import 'package:flutter_game/core/Shared/hoverButton.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';
import 'package:shape_of_view/shape_of_view.dart';

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
      if (mounted) {
        setState(() {
          audioPlayerState = state;
        });
      }
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/gamebg.jpg",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                    Container(
                      child: _turnNumber < value.playersList.length * 2
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          20.w,
                                      height: 330.h,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/frame.png",
                                              ),
                                              fit: BoxFit.cover)),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: _switchToNewPlayer
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child: Container(
                                                  child: Center(
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 16),
                                                        child: AutoSizeText(
                                                          "ادي الموبايل ل ${value.playersList[_currentIndex].playerName} عشان يعرف \n هو اللي برا اللعبة ولا لا !",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .getFont(
                                                                          'Changa')
                                                                  .fontFamily,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  setResponsiveFontSize(
                                                                      18)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      'خـــرربــش',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: GoogleFonts
                                                                  .getFont(
                                                                      'Changa')
                                                              .fontFamily,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize:
                                                              setResponsiveFontSize(
                                                                  16)),
                                                    ),
                                                    Dance(
                                                      child: ShapeOfView(
                                                        elevation: 8,
                                                        height: 140.h,
                                                        width: 140.w,
                                                        shape: StarShape(
                                                          noOfPoints: 8,
                                                        ),
                                                        child: Scratcher(
                                                          brushSize: 14,
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
                                                            'assets/images/scratch.PNG',
                                                            fit: BoxFit.cover,
                                                          ),
                                                          onChange: (value) =>
                                                              print(
                                                                  "Scratch progress: $value%"),
                                                          onThreshold: () => print(
                                                              "Threshold reached, you won!"),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child:
                                                                ClayContainer(
                                                              color: Colors
                                                                  .amberAccent,
                                                              height: 60.h,
                                                              width: 60.w,
                                                              borderRadius: 50,
                                                              curveType:
                                                                  CurveType
                                                                      .concave,
                                                              child: Center(
                                                                child:
                                                                    AutoSizeText(
                                                                  _currentIndex ==
                                                                          _whoIsOutIndex
                                                                      ? "برا"
                                                                      : randomAnimalName,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          GoogleFonts.getFont('Cairo')
                                                                              .fontFamily,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          setResponsiveFontSize(
                                                                              16)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      )),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                if (_currentIndex <
                                        (value.playersList.length) &&
                                    _turnNumber <
                                        value.playersList.length * 2) ...[
                                  RoundedActionButton(
                                    btnColor: ColorManager.successColor,
                                    title: "التالى",
                                    btnFunc: () {
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
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ));
          },
        ),
      ),
    );
  }
}
