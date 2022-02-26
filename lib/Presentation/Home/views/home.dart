import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Animal/AnimalProvider.dart';
import 'package:flutter_game/Database/AnimalDatabase.dart';
import 'package:flutter_game/Domain/Models/AnimalModel.dart';
import 'package:flutter_game/Presentation/Game/views/add_players.dart';
import 'package:flutter_game/core/Shared/constantData.dart';
import 'package:flutter_game/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// Animal _animal = Animal();
// AnimalDatabase _animalDatabase = AnimalDatabase();
// Future animalFuture;
// Future<void> getAnimal() async {
//   _animal = await _animalDatabase.getAnimal(1);
//   locator.locator<AnimalProvider>().getAnimalFromDb(_animal);
// }

class _HomeState extends State<Home> {
  @override
  void initState() {
    // animalFuture = getAnimal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _animalProv = locator.locator<AnimalProvider>();
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPlayerScreen(),
                  ));
            },
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/animals.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: AutoSizeText(animalData.categoryName),
          )
        ],
      ),
    ));
  }
}
