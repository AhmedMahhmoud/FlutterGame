import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Animal/AnimalProvider.dart';
import 'package:flutter_game/Domain/Models/AnimalModel.dart';
import 'package:flutter_game/Presentation/Game/views/who_is_out.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  List<String> choicesList = [];
  int _cuurentIndex = 0;
  bool _choiceResult;
  @override
  void initState() {
    super.initState();
    choicesList = Provider.of<AnimalProvider>(context, listen: false)
        .generateRandomAnimalsForChoices();
  }

  setCurrentIndex(int newIndex) {
    setState(() {
      _cuurentIndex = newIndex;
    });
  }

  Color setButtonColor(int index) {
    if (_choiceResult == null) {
      return ColorManager.backGroundColor;
    } else {
      if (_cuurentIndex == index) {
        if (_choiceResult) {
          return ColorManager.successColor;
        } else {
          return ColorManager.failColor;
        }
      } else {
        return ColorManager.backGroundColor;
      }
    }
  }

  isCorrectAnswer(String choosenAnimal) {
    if (choosenAnimal ==
        Provider.of<AnimalProvider>(context, listen: false).currentAnimal) {
      setState(() {
        _choiceResult = true;
      });
    } else {
      setState(() {
        _choiceResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              AutoSizeText(
                "مين تتوقع يكون الحيوان ؟",
                style: boldStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary),
              ),
              Container(
                child: Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          btnColor: setButtonColor(index),
                          title: choicesList[index],
                          onTapped: _choiceResult == null
                              ? () {
                                  setCurrentIndex(index);
                                  isCorrectAnswer(choicesList[index]);
                                }
                              : null,
                        ),
                      );
                    },
                    itemCount: choicesList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
