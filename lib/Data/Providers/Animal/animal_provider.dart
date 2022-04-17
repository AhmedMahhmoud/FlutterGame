// import 'package:flutter/cupertino.dart';
// import 'package:flutter_game/Domain/Models/AnimalModel.dart';

// class AnimalProvider {
//   Animal animal;
//   getAnimalFromDb(Animal animalDB) {
//     animal = animalDB;
//   }
// }
import 'dart:math';

import 'package:flutter/cupertino.dart';
import '../../../Domain/Models/animal_model.dart';
import '../../../core/Shared/constant_data.dart';

class GameProvider with ChangeNotifier {
  String currentGame;
  Game game;

  void setCurrentGame(String currentName) {
    currentGame = currentName;
  }

  void setGameCategory(Game gameCat) {
    game = gameCat;
    notifyListeners();
  }

  List<String> generateRandomAnimalsForChoices() {
    List<String> choicesList = [];
    choicesList.add(currentGame);
    var list = List<int>.generate(game.itemsName.length, (i) => i)..shuffle();
    list = list.take(6).toList();
    for (int i = 0; i < 6; i++) {
      if (!choicesList.contains(game.itemsName[list[i]])) {
        choicesList.add(game.itemsName[list[i]]);
      }
    }
    choicesList.shuffle();
    return choicesList;
  }
}
