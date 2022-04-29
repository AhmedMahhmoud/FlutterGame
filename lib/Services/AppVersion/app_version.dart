import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class AppStoreVersion {
  Future<void> checkAppUpdate(BuildContext context) async {
    NewVersion newVersion = NewVersion();
    VersionStatus status = await newVersion.getVersionStatus();

    if (status.canUpdate) {
      log('there is an update found');
      Future.delayed(const Duration(milliseconds: 1), () {
        showDialog(context: context, builder: (BuildContext context) {});
      });
    } else {
      log('There is no update available');
      log(status.localVersion.toString());
      log(status.storeVersion.toString());
    }
  }
}
