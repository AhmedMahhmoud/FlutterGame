import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_game/Presentation/Game/widgets/update_dialog.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';


class AppStoreVersion {
  Future<void> checkAppUpdate(BuildContext context) async {
    NewVersion newVersion = NewVersion();
    VersionStatus status = await newVersion.getVersionStatus();

    if (status.canUpdate) {
      log('there is an update found');

      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(
              onPressed: () async {
                launch(status.appStoreLink);
              },
            );
          });
    } else {
      log('There is no update available');
      log(status.localVersion.toString());

      log(status.storeVersion.toString());
    }
  }
}
