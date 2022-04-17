import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../Data/Providers/Animal/animal_provider.dart';
import '../../../Data/Providers/Players/players_provider.dart';
import '../../../Domain/Models/animal_model.dart';
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

class _ChoiceScreenState extends State<ChoiceScreen> {
  List<String> choicesList = [];
  int _cuurentIndex = 0;
  bool _choiceResult;
  AudioCache player = AudioCache();
  @override
  void initState() {
    super.initState();
    choicesList = Provider.of<GameProvider>(context, listen: false)
        .generateRandomAnimalsForChoices();
  }

  void setCurrentIndex(int newIndex) {
    setState(() {
      _cuurentIndex = newIndex;
    });
  }

  Color setButtonColor(int index) {
    if (_choiceResult == null) {
      return ColorManager.darkGrey;
    } else {
      if (_cuurentIndex == index) {
        if (_choiceResult) {
          player.play('sounds/CorrectAnswer.mp3');
          return ColorManager.successColor;
        } else {
          player.play('sounds/WrongAnswer.mp3');
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
      setState(() {
        _choiceResult = true;
        Provider.of<PlayersProvider>(context, listen: false)
            .playersList[Provider.of<PlayersProvider>(context, listen: false)
                .whoIsOutIndex]
            .playerScore += 100;
      });
    } else {
//      Provider.of<PlayersProvider>(context, listen: false).playersList[Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex].playerScore=(Provider.of<PlayersProvider>(context, listen: false).playersList[Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex].playerScore-100).abs();

      setState(() {
        _choiceResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var playersProv = Provider.of<PlayersProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/gameBackground.jpg'),
                  fit: BoxFit.cover)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                AutoSizeText(
                  'تتوقع مين ؟',
                  style: boldStyle.copyWith(
                      fontSize: setResponsiveFontSize(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15.h,
                ),
                DisplayChoices(
                  headerImage: playersProv
                      .playersList[playersProv.whoIsOutIndex].playerImage,
                  content: Column(
                    children: [
                      SizedBox(
                        height: 35.h,
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
                                    height: 70.h,
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
                  height: 5.h,
                ),
                _choiceResult != null
                    ? RoundedActionButton(
                        btnColor: ColorManager.successColor,
                        title: 'التالى',
                        btnFunc: () async {
                          await playersProv.sortList();
                          navigateReplacmentToPage(context, FinalResult());
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
