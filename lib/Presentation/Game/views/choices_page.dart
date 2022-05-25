import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../Data/Providers/Animal/animal_provider.dart';
import '../../../Data/Providers/Players/players_provider.dart';
import '../../../Domain/Models/animal_model.dart';
import '../widgets/ExitDialog.dart';
import 'who_is_out.dart';
import '../widgets/choices_display.dart';
import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/Shared/rounded_action_button.dart';
import '../../../core/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'final_result.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({Key key}) : super(key: key);

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

AudioCache player = AudioCache();

class _ChoiceScreenState extends State<ChoiceScreen> {
  List<String> choicesList = [];
  int _cuurentIndex = 0;
  bool _choiceResult;

/*  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;
  String correctPath = 'sounds/CorrectAnswer.mp3';
  String wrongPath = 'sounds/WrongAnswer.mp3';*/

  @override
  void initState() {
    super.initState();

/*    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      if (mounted) {
        setState(() {
          audioPlayerState = state;
        });
      }
    });*/

    choicesList = Provider.of<GameProvider>(context, listen: false)
        .generateRandomAnimalsForChoices();
  }

  void setCurrentIndex(int newIndex) {
    setState(() {
      _cuurentIndex = newIndex;
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.clearCache();
    /*   pauseMusic();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();*/
  }
/*
  Future<void> playCorrectMusic() async {
    await audioCache.play(correctPath);
  } Future<void> playWrongMusic() async {
    await audioCache.play(wrongPath);
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }
*/

  Color setButtonColor(int index) {
    if (_choiceResult == null) {
      return ColorManager.darkGrey;
    } else {
      if (_cuurentIndex == index) {
        if (_choiceResult) {
          //  playCorrectMusic();
          return ColorManager.successColor;
        } else {
          //    playWrongMusic();
          return ColorManager.failColor;
        }
      } else {
        return ColorManager.darkGrey;
      }
    }
  }

  isCorrectAnswer(String choosenAnimal) {
    if (choosenAnimal ==
        Provider.of<GameProvider>(context, listen: false).currentGame) {
      player.play('sounds/CorrectAnswer.mp3');
      setState(() {
        _choiceResult = true;
        Provider.of<PlayersProvider>(context, listen: false)
            .playersList[Provider.of<PlayersProvider>(context, listen: false)
                .whoIsOutIndex]
            .playerScore += 100;
      });
    } else {
//      Provider.of<PlayersProvider>(context, listen: false).playersList[Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex].playerScore=(Provider.of<PlayersProvider>(context, listen: false).playersList[Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex].playerScore-100).abs();
      player.play('sounds/WrongAnswer.mp3');
      setState(() {
        _choiceResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) => ZoomIn(
                  child: const ExitDialog(),
                ));
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/gameBackground.jpg'),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  AutoSizeText(
                    'تفتكر الكلام على إيه ؟',
                    style: boldStyle.copyWith(
                        fontSize: setResponsiveFontSize(20),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DisplayChoices(
                    screen: 'guess',
                    headerImage: playersProv
                        .playersList[playersProv.whoIsOutIndex].playerImage,
                    content: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: _choiceResult == null
                                        ? () {
                                            setCurrentIndex(index);
                                            isCorrectAnswer(choicesList[index]);
                                          }
                                        : null,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: setButtonColor(index),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: AutoSizeText(
                                          choicesList[index],
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  setResponsiveFontSize(16)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      height: 60.h,
                                      width: 250.w,
                                    ),
                                  ));
                            },
                            itemCount: choicesList.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  _choiceResult != null
                      ? RoundedActionButton(
                          btnColor: ColorManager.successColor,
                          title: 'التالى',
                          btnFunc: () async {
                            playersProv.sortList();
                            player.clearCache();
                            navigateToPage(context, FinalResult());
                          },
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
