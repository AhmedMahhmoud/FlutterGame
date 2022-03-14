import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:provider/provider.dart';

import 'choices_page.dart';


class FindOutScreen extends StatefulWidget {
  @override
  State<FindOutScreen> createState() => _FindOutScreenState();
}

class _FindOutScreenState extends State<FindOutScreen> {
  String finalBara;
  String tempBara;

  Timer _timer;

  @override
  void initState() {
    super.initState();
/*    finalBara = Provider.of<PlayersProvider>(context, listen: false)
        .playersList[
            Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex]
        .playerName;*/





    Provider.of<PlayersProvider>(context, listen: false).switchWhoIsBara();


/*    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
     // if(mounted)




     // Provider.of<PlayersProvider>(context, listen: false).switchWhoIsBara();
    });*/



    print('finish');
   /* Timer(Duration(seconds: 3), () {

    });*/

 /*   Provider.of<PlayersProvider>(context, listen: false)
        .playersList[
            Provider.of<PlayersProvider>(context, listen: false).whoIsOutIndex]
        .playerName = finalBara;
    _timer.cancel();*/
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
              child: Text(
            'اللى برا السالفة هو ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: setResponsiveFontSize(25)),
          )),
          Center(
              child: Text(
            '${Provider.of<PlayersProvider>(context, listen: true).playersList[Provider.of<PlayersProvider>(context, listen: true).whoIsOutIndex].playerName}',

            textAlign: TextAlign.center,
            style: TextStyle(fontSize: setResponsiveFontSize(25)),
          )),
          SizedBox(
            height: 100,
          ),
          RoundedButton(
            title: "التالى",
            onTapped: () {

              navigateReplacmentToPage(context, ChoiceScreen());

            },
          )
        ],
      ),
    );
  }
}
