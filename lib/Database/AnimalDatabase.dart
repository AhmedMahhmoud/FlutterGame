// import 'package:flutter_game/Domain/Models/AnimalModel.dart';
// import 'package:get_it/get_it.dart';

// import 'package:sembast/sembast.dart';

// class AnimalDatabase {
//   final Database _database = GetIt.I.get();
//   final StoreRef _store = intMapStoreFactory.store("animal_store");
//   Future<int> insertGame(Animal animal) async {
//     return await _store.add(_database, animal.toMap()).whenComplete(() {
//       print("inserted success");
//     });
//   }

//   Future<Animal> getAnimal(int id) async {
//     var map = await _store.record(id).get(_database);
//     return Animal.fromMap(id, map);
//   }

//   Future<List<Animal>> getAnimalTable() async {
//     final snapshots = await _store.find(_database);
//     return snapshots
//         .map((snapshot) => Animal.fromMap(snapshot.key, snapshot.value))
//         .toList(growable: false);
//   }
// }
