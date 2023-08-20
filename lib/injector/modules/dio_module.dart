import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foodexaminer/configs/app_config.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../injector.dart';

class DioModule {
  DioModule._();

  static const String dioInstanceName = 'dioInstance';
  static final GetIt _injector = Injector.instance;

  static void setup() {
    _setupDio();
  }

  static void _setupDio() {
    _injector.registerLazySingleton<Dio>(instanceName: dioInstanceName, () {
      final Dio dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
        ),
      );
      if (!kReleaseMode) {
        dio.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            request: false,
          ),
        );
      }
      return dio;
    });
  }
}
