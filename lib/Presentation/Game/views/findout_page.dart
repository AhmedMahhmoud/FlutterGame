import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

import 'choices_page.dart';

class FindOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'اللى برا السالفة هو ${Provider.of<PlayersProvider>(context, listen: false).playersList[Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex].playerName}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: setResponsiveFontSize(25)),
          )),
          SizedBox(
            height: 100,
          ),
          RoundedButton(
            title: "التالى",
            onTapped: () {
              navigateToPage(context, ChoiceScreen());
            },
          )
        ],
      ),
    );
  }
}
