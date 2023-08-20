part of 'app_bloc.dart';

// @immutable
// abstract class AppState {}
//
// class AppInitial extends AppState {
//
//   AppInitial():
// }

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final UIStatusState statusState;
  final String locale;
  final bool isDarkMode;
  final bool isFirstUse;
  final MyUser myUser;
  final AuthenticationStatus authenticationStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [statusState, locale, isDarkMode, isFirstUse, myUser, authenticationStatus];

//<editor-fold desc="Data Methods">
  const AppState({
    this.statusState = const UIStatusInitial(),
    this.locale = AppConfig.defaultLocale,
    this.isDarkMode = false,
    this.isFirstUse = true,
    required this.authenticationStatus,
    this.myUser = MyUser.empty,
  });


  const AppState.authenticated(MyUser myUser)
      : this(authenticationStatus: AuthenticationStatus.authenticated, myUser: myUser);

  const AppState.unauthenticated() : this(authenticationStatus: AuthenticationStatus.unauthenticated);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppState &&
          runtimeType == other.runtimeType &&
          statusState == other.statusState &&
          locale == other.locale &&
          isDarkMode == other.isDarkMode &&
          isFirstUse == other.isFirstUse &&
          myUser == other.myUser &&
          authenticationStatus == other.authenticationStatus);

  @override
  int get hashCode =>
      statusState.hashCode ^
      locale.hashCode ^
      isDarkMode.hashCode ^
      isFirstUse.hashCode ^
      myUser.hashCode ^
      authenticationStatus.hashCode;

  @override
  String toString() {
    return 'AppState{' +
        ' statusState: $statusState,' +
        ' locale: $locale,' +
        ' isDarkMode: $isDarkMode,' +
        ' isFirstUse: $isFirstUse,' +
        ' myUser: $myUser,' +
        ' authenticationStatus: $authenticationStatus,' +
        '}';
  }

  AppState copyWith({
    UIStatusState? statusState,
    String? locale,
    bool? isDarkMode,
    bool? isFirstUse,
    MyUser? myUser,
    AuthenticationStatus? authenticationStatus,
  }) {
    return AppState(
      statusState: statusState ?? this.statusState,
      locale: locale ?? this.locale,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isFirstUse: isFirstUse ?? this.isFirstUse,
      myUser: myUser ?? this.myUser,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusState': this.statusState,
      'locale': this.locale,
      'isDarkMode': this.isDarkMode,
      'isFirstUse': this.isFirstUse,
      'myUser': this.myUser,
      'authenticationStatus': this.authenticationStatus,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      statusState: map['statusState'] as UIStatusState,
      locale: map['locale'] as String,
      isDarkMode: map['isDarkMode'] as bool,
      isFirstUse: map['isFirstUse'] as bool,
      myUser: map['myUser'] as MyUser,
      authenticationStatus: map['authenticationStatus'] as AuthenticationStatus,
    );
  }

//</editor-fold>
}
