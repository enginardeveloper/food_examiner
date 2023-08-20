part of 'app_bloc.dart';


abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppEventLogoutRequested extends AppEvent {
  const AppEventLogoutRequested();
}

class _AppEventUserChanged extends AppEvent {
  final MyUser myUser;
  const _AppEventUserChanged(
      this.myUser
      );
}

class AppEventLoaded extends AppEvent {
  const AppEventLoaded();
}

class AppEventLocaleChanged extends AppEvent {
  final String locale;
  AppEventLocaleChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}

class AppEventDisableFirstUse extends AppEvent {
  const AppEventDisableFirstUse();
}

class AppEventDarkModeChanged extends AppEvent {
  const AppEventDarkModeChanged();
}
