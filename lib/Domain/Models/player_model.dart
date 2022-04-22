import 'dart:convert';

class Players {
  String playerName, playerImage;
  int playerScore;

  Players({this.playerName, this.playerScore, this.playerImage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerName': playerName,
      'playerImage': playerImage,
      'playerScore': playerScore,
    };
  }

  factory Players.fromMap(Map<String, dynamic> map) {
    return Players(
        playerName: map['playerName'],
        playerImage: map['playerImage'],
        playerScore: map['playerScore']);
  }
}
