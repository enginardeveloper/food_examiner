import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodexaminer/configs/app_config.dart';
import 'package:foodexaminer/core/bloc_core/ui_status_state.dart';
import 'package:meta/meta.dart';

import '../../../data/model/my_user.dart';
import '../../../data/repository/remote/authentication_repository/authentication_repository.dart';
import '../../../services/app_service/app_service.dart';
import '../../../services/log_service/log_service.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late final LogService _logService;
  late final AppService _appService;
  late final StreamSubscription<MyUser> _userSubscription;
  final AuthenticationRepository _authenticationRepository;

  AppBloc({ required LogService logService, required AppService appService,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentMyUser.isNotEmpty ?
        AppState.authenticated(authenticationRepository.currentMyUser)
              :
        AppState.unauthenticated()
  ) {
    _logService = logService;
    _appService = appService;

    on<AppEventLoaded>(_onLoaded);
    on<AppEventDarkModeChanged>(_onDarkModeChanged);
    on<AppEventLocaleChanged>(_onLocaleChanged);
    on<AppEventDisableFirstUse>(_onDisableFirstUse);
    on<_AppEventUserChanged>(_onUserChanged);
    on<AppEventLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.myUser.listen(
          (user) => add(_AppEventUserChanged(user)),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onUserChanged(_AppEventUserChanged event, Emitter<AppState> emit) {
    if (event.myUser.isNotEmpty)
    _logService.i("_onUserChanged AppState.authenticated");
      else
      _logService.i("_onUserChanged AppState.unauthenticated");


    emit(event.myUser.isNotEmpty ? state.copyWith(authenticationStatus: AuthenticationStatus.authenticated, myUser: event.myUser)
        : state.copyWith(authenticationStatus: AuthenticationStatus.unauthenticated));
  }

  FutureOr<void> _onLogoutRequested(AppEventLogoutRequested event, Emitter<AppState> emit) {
    //emit(event.user.isNotEmpty);
    try {
      _authenticationRepository.logOut();
    } catch (e) {
      /// bia inja benevis vase handle kardanesh
    }

  }

  FutureOr<void> _onLoaded(AppEventLoaded event, Emitter<AppState> emit) {
    try {

      _logService.i("_onLoaded is called1");
      emit(
        state.copyWith(
          statusState: const UIStatusLoading(),
        ),
      );
      _logService.i("_onLoaded is called2");

      final bool darkMode = _appService.isDarkMode;
      final bool isFirstUse = _appService.isFirstUse;
      final String locale = _appService.locale;

      emit(
        state.copyWith(
          statusState: const UIStatusLoadSuccess(),
          isDarkMode: darkMode,
          isFirstUse: isFirstUse,
          locale: locale,
        ),
      );
      _logService.i("_onLoaded is called3");
    } catch (e, stackTrace) {
      _logService.e('AppBloc load failed', e, stackTrace);
      emit(state.copyWith(
          statusState: UIStatusLoadFailed(message: e.toString())));
    }
  }

  FutureOr<void> _onDarkModeChanged(
      AppEventDarkModeChanged event, Emitter<AppState> emit) async {
    final bool isDarkMode = !state.isDarkMode;
    await _appService.setIsDarkMode(isDarkMode: isDarkMode);
    emit(
      state.copyWith(
        isDarkMode: isDarkMode,
      ),
    );
  }

  FutureOr<void> _onLocaleChanged(
      AppEventLocaleChanged event, Emitter<AppState> emit) async {
      if (state.locale != event.locale) {
        // change the actual locale function
        //await S.load(Locale)
        await _appService.setLocale(locale: event.locale);
        emit(state.copyWith(locale: event.locale));
      }
  }

  FutureOr<void> _onDisableFirstUse(AppEventDisableFirstUse event, Emitter<AppState> emit) async {
    if (state.isFirstUse) {
      await _appService.setIsFirstUse(isFirstUse: false);
    }
    emit(state.copyWith(isFirstUse: false));
  }
}
