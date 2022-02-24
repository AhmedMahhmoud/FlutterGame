import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';

class PlayersProvider with ChangeNotifier {
  List<Players> playersList = [];
  List<Players> playersListCopy = [];

  List<Players> randomPlayers = [];
  List<Players> suspectsPlayers = [];
  int whoIsOutIndex;
  int lastAskingPlayerIndex = -1;
  int askingPlayerIndex;

  addPlayer(Players player) {
    playersList.add(player);
    playersListCopy.add(player);
    notifyListeners();
  }

  removePlayer(int index) {
    playersList.removeAt(index);
    playersListCopy.removeAt(index);
    notifyListeners();
  }

  removeCopyPlayer(int index) {
    playersListCopy.removeAt(index);
    notifyListeners();
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


    if(playersList.length>3){
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
