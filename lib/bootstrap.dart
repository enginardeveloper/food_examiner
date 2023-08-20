import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:logger/logger.dart';

import 'core/bloc_core/bloc_observer.dart';
import 'data/repository/remote/authentication_repository/authentication_repository.dart';
import 'features/app/view/app.dart';
import 'injector/injector.dart';

Future<void> bootstrap({
  AsyncCallback? firebaseInitialization,
  AsyncCallback? flavorConfiguration,
}) async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await firebaseInitialization?.call();
    Logger.level = Level.verbose;
    await flavorConfiguration?.call();

    Injector.init();

    await Injector.instance.allReady();

    Bloc.observer = AppBlocObserver();

    final authenticationRepository = Injector.instance.get<AuthenticationRepository>();

    bool result = await authenticationRepository.isLoggedIn();
    print("======result: $result");
     if (result) {
       await authenticationRepository.myUser.first;
     }

    runApp(const App());
  }, (error, stack) {
    //Injector.instance<CrashlyticsService>().recordException(error, stack);
  });
}