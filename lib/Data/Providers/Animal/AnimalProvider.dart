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
import 'package:flutter_game/Domain/Models/AnimalModel.dart';
import 'package:flutter_game/core/Shared/constantData.dart';

class AnimalProvider with ChangeNotifier {
  String currentAnimal;
  Animal animal = animalData;

  setCurrentAnimal(String animalName) {
    currentAnimal = animalName;
  }

  List<String> generateRandomAnimalsForChoices() {
    List<String> choicesList = [];
    choicesList.add(currentAnimal);
    var list = List<int>.generate(animal.itemsName.length, (i) => i)..shuffle();
    list = list.take(6).toList();
    for (int i = 0; i < 6; i++) {
      if (!choicesList.contains(animal.itemsName[list[i]])) {
        choicesList.add(animal.itemsName[list[i]]);
      }
    }
    choicesList.shuffle();
    return choicesList;
  }
}
