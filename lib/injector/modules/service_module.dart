import 'package:foodexaminer/services/app_service/impl/app_service_impl.dart';
import 'package:foodexaminer/services/cache_client_service/impl/cache_client_service_impl.dart';
import 'package:foodexaminer/services/crashlytics_service/crashlytics_service.dart';
import 'package:foodexaminer/services/crashlytics_service/impl/firebase_crashlytics_service_impl.dart';
import 'package:foodexaminer/services/local_storage_service/local_storage_service.dart';
import 'package:foodexaminer/services/log_service/impl/debug_log_service_impl.dart';
import 'package:get_it/get_it.dart';

import '../../services/app_service/app_service.dart';
import '../../services/cache_client_service/cache_client_service.dart';
import '../../services/local_storage_service/impl/shared_preferences_local_storage_service_impl.dart';
import '../../services/log_service/log_service.dart';
import '../injector.dart';

class ServiceModule {
  ServiceModule._();

  //static const String logServiceInstanceName = 'logServiceInstance';

  static final GetIt _injector = Injector.instance;

  static void init() {
    _injector
      ..registerSingletonAsync<CrashlyticsService>(() async {
        return FirebaseCrashlyticsServiceImpl();
      })
      ..registerFactory<LogService>(
        DebugLogServiceImpl.new,
      )
      ..registerSingleton<LocalStorageService>(
        SharedPreferencesLocalStorageServiceImpl(
          logService: _injector(),
        ),
        signalsReady: true,
      )
      ..registerSingleton<AppService>(
        AppServiceImpl(
          localStorageService: _injector(),
        ),
      )
    ..registerSingleton<CacheClientService>(CacheClientServiceImpl(),
    );
  }
}
