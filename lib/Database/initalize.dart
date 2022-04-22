import 'dart:developer';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Init {
  Future<void> initialize() async {
    await _initSembast();
    log('sembast intialized ');
  }

  static Future<void> _initSembast() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    String databasePath = join(appDir.path, 'sembast.db');
    Database database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }
}
