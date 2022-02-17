import 'package:flutter/cupertino.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';

class PlayersProvider with ChangeNotifier {
  List<Players> playersList = [];
  List<Players> playersListCopy = [];
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
}
