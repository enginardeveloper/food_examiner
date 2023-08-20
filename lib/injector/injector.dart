import 'package:flutter/foundation.dart';
import 'package:foodexaminer/injector/modules/bloc_module.dart';
import 'package:foodexaminer/injector/modules/repository_module.dart';
import 'package:foodexaminer/injector/modules/rest_api_client_module.dart';
import 'package:get_it/get_it.dart';

import 'modules/dio_module.dart';
import 'modules/service_module.dart';

class Injector {
  Injector._();

  static GetIt instance = GetIt.instance;

  static void init() {
    DioModule.setup();
    ServiceModule.init();
    RestApiClientModule.init();
    // if (!kIsWeb) {
    //   DatabaseModule.init();
    // }
    RepositoryModule.init();
    BlocModule.init();

  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }


}