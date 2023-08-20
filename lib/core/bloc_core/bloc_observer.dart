import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexaminer/injector/injector.dart';

import '../../services/log_service/log_service.dart';

class AppBlocObserver extends BlocObserver {

  late final LogService _logService;

  AppBlocObserver() {
    _logService = Injector.instance<LogService>();
  }

  @override
  void onCreate(BlocBase bloc) {
    _logService.i('BLoC: ${bloc.runtimeType} created');
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logService.e('Error: ${error.runtimeType}', error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    _logService.i('Event: ${event.runtimeType} added');
    super.onEvent(bloc, event);
  }
}