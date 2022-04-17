import 'dart:async';
import 'dart:developer' as lg;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_game/Domain/Models/player_model.dart';
import 'package:flutter_game/core/Shared/constant_data.dart';

class PlayersProvider with ChangeNotifier {
  List<Players> playersList = [];
  List<Players> playersListCopy = [];
  List<String> charactersImages = playersImages;
  List<Players> randomPlayers = [];
  List<Players> suspectsPlayers = [];
  int whoIsOutIndex;
  int tmpWhoIsOutIndex;
  int lastAskingPlayerIndex = -1;
  int askingPlayerIndex;

  String finalBara;

  void switchWhoIsBara() {
    tmpWhoIsOutIndex = whoIsOutIndex;

    for (int i = 0; i < playersList.length; i++) {
      whoIsOutIndex = i;
      Future.delayed(const Duration(milliseconds: 500));
      lg.log('player is ${i}');
      notifyListeners();
    }
  }

  addPlayer(Players player, int index, int imageIndex) {
    playersList.add(player);
    playersListCopy.add(player);
    charactersImages.removeAt(imageIndex);
    notifyListeners();
  }

  resetPlayers() {
    playersList.clear();
    charactersImages = [
      'assets/images/p1.png',
      'assets/images/p2.png',
      'assets/images/p3.png',
      'assets/images/p4.png',
      'assets/images/p5.png',
      'assets/images/p6.png',
      'assets/images/p7.png',
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
    playersList
        .sort((Players a, Players b) => a.playerScore.compareTo(b.playerScore));
    playersList = playersList.reversed.toList();
    lg.log('list sorted');
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
          .where((Players element) => element.playerName == name)
          .first
          .playerName;
    }
    return '';
  }

  getRandomPlayers() {
    randomPlayers = [...playersList];
    randomPlayers.removeAt(askingPlayerIndex);

    if (playersList.length > 3) {
      if (lastAskingPlayerIndex == -1) {
        lg.log('awel mara');
        randomPlayers.removeAt(Random().nextInt(randomPlayers.length));
      } else {
        lg.log('lastAskingPlayerIndex $lastAskingPlayerIndex');

        randomPlayers.removeAt(
            lastAskingPlayerIndex == 0 ? 0 : lastAskingPlayerIndex - 1);
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
    int random = Random().nextInt(playersList.length);
    lg.log('random is $random');
    if (random == lastAskingPlayerIndex) {
      lg.log('wrong random');
      getAskingPlayer();
    } else {
      lg.log(
          'random index is $random  last player index is $lastAskingPlayerIndex');
      askingPlayerIndex = random;

      getRandomPlayers();
    }
    notifyListeners();
  }
}
