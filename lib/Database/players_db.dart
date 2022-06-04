import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import '../Data/Providers/Players/players_provider.dart';
import '../Domain/Models/player_model.dart';

class PlayersDB {
  //singleton code ..
  static final PlayersDB _singleton = PlayersDB._internal();
  factory PlayersDB() {
    return _singleton;
  }
  PlayersDB._internal();
  //end of singleton...
  final Database _database = GetIt.I.get();
  Database get db => _database;
  final StoreRef _store = intMapStoreFactory.store('players_store');
  Future<void> insertPlayer(Players players) async {
    return await _store.add(_database, players.toMap()).whenComplete(() {
      print('inserted success');
    });
  }

  Future<void> removePlayer(Players players) async {
    Finder finder = Finder(
        filter: Filter.and(
      [
        //you can add more filters
        Filter.equals('playerName', players.playerName)
      ],
    ));
    return await _store.delete(_database, finder: finder).whenComplete(() {
      print('removed success');
    });
  }

  Future<List<Players>> getPlayersTable() async {
    List<RecordSnapshot> snapshots = await _store.find(_database);
    return snapshots
        .map((RecordSnapshot snapshot) => Players.fromMap(snapshot.value))
        .toList(growable: false);
  }
}
