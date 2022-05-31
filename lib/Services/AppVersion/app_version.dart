import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_updater/native_updater.dart';
import '../../Presentation/Game/widgets/update_dialog.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStoreVersion {
  Future<void> checkAppUpdate(BuildContext context) async {
    if (Platform.isAndroid) {
      NativeUpdater.displayUpdateAlert(
        context,
        forceUpdate: false,
      );
    } else {
      NewVersion newVersion = NewVersion();
      VersionStatus status = await newVersion.getVersionStatus();
      log('status is ${status.appStoreLink}');
      log('status is ${status.localVersion}');
      log('status is ${status.canUpdate}');
      try {
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
      } catch (e) {
        debugPrint('exception is $e');
      }
    }
  }
}
