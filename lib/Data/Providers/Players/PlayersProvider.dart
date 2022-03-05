import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/core/Shared/constantData.dart';

class PlayersProvider with ChangeNotifier {
  List<Players> playersList = [];
  List<Players> playersListCopy = [];
  List<String> charactersImages = playersImages;
  List<Players> randomPlayers = [];
  List<Players> suspectsPlayers = [];
  int whoIsOutIndex;
  int lastAskingPlayerIndex = -1;
  int askingPlayerIndex;

  addPlayer(Players player, int index, int imageIndex) {
    playersList.add(player);
    playersListCopy.add(player);
    charactersImages.removeAt(imageIndex);
    notifyListeners();
  }

  resetPlayers() {
    playersList.clear();
    charactersImages = [
      "assets/images/p1.png",
      "assets/images/p2.png",
      "assets/images/p3.png",
      "assets/images/p4.png",
      "assets/images/p5.png",
      "assets/images/p6.png",
      "assets/images/p7.png",
    ];
  }

  removePlayer(int index) {
    charactersImages.insert(0, playersList[index].playerImage);
    playersList.removeAt(index);
    playersListCopy.removeAt(index);
    notifyListeners();
  }

  removeCopyPlayer(int index) {
    playersListCopy.removeAt(index);
    notifyListeners();
  }

  sortList() {
    playersList.sort((a, b) => a.playerScore.compareTo(b.playerScore));
    playersList = playersList.reversed.toList();
    print("list sorted");
  }

  bool checkPlayerExist(String playerName) {
    for (int i = 0; i < playersList.length; i++) {
      if (playersList[i].playerName == playerName) {
        return true;
      }
    }
    return false;
  }

  String getPlayerByname(String name) {
    if (playersList.isNotEmpty) {
      return playersList
          .where((element) => element.playerName == name)
          .first
          .playerName;
    }
    return "";
  }

  getRandomPlayers() {
    randomPlayers = [...playersList];
    randomPlayers.removeAt(askingPlayerIndex);

    if (playersList.length > 3) {
      if (lastAskingPlayerIndex == -1) {
        print('awel mara');
        randomPlayers.removeAt(Random().nextInt(randomPlayers.length));
      } else {
        print('lastAskingPlayerIndex $lastAskingPlayerIndex');

        randomPlayers.removeAt(lastAskingPlayerIndex);
      }
    }

    notifyListeners();
  }

  assignIndex() {
    lastAskingPlayerIndex = askingPlayerIndex;
    notifyListeners();
  }

  getSuspectsPlayers(int index) {
    suspectsPlayers = [...playersList];
    suspectsPlayers.removeAt(index);
    notifyListeners();
  }

  getAskingPlayer() {
    final random = Random().nextInt(playersList.length - 1);
    if (random == lastAskingPlayerIndex) {
      print('wrong random');
      getAskingPlayer();
    } else {
      print(
          'random index is $random  last player index is $lastAskingPlayerIndex');
      askingPlayerIndex = random;

      getRandomPlayers();
    }
    notifyListeners();
  }
}
