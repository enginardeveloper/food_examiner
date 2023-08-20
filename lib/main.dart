import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'bootstrap.dart';
import 'configs/app_config.dart';

Future<void> main() async {
  await bootstrap(
      firebaseInitialization: () async {
        await Firebase.initializeApp();
      },
      flavorConfiguration: () async {
        AppConfig.configDev();
        //AppConfig
      });
}
