import 'package:flutter/cupertino.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';

class PlayersProvider with ChangeNotifier {
  List<Players> playersList = [];
  addPlayer(Players player) {
    playersList.add(player);
    notifyListeners();
  }

  removePlayer(int index) {
    playersList.removeAt(index);
    notifyListeners();
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
