import 'package:foodexaminer/features/home/view/home_page.dart';
import 'package:go_router/go_router.dart';

import '../features/app/view/app_director_view.dart';
import '../features/dog_image_random/view/dog_image_random_view.dart';
import '../features/login/view/login_page.dart';
import '../features/settings/settings_page.dart';
import '../features/sign_up/view/sign_up_view.dart';

class AppRouter {

  AppRouter._();

  static const String appDirector = 'appDirector';
  static const String appDirectorPath = '/';

  static const String homeNamed = 'home';
  static const String homePath = '/';

  static const String loginNamed = 'login';
  static const String loginPath = '/login';

  static const String settingsNamed = 'settings';
  static const String settingsPath = '/settings';

  static const String signUpNamed = 'signUp';
  static const String signUpPath = '/signUp';

  static const String assetsNamed = 'assets';
  static const String assetsPath = '/assets';

  static const String dogImageRandomNamed = 'dogImageRandom';
  static const String dogImageRandomPath = '/dogImageRandom';

  static GoRouter get router => _router;
  static final _router = GoRouter(
    routes: <GoRoute>[
      // GoRoute(
      //   name: appDirector,
      //     path: appDirectorPath,
      //   builder: (context, state) {
      //     return const AppDirectorView();
      //   }
      // ),
      // GoRoute(
      //     name: homeNamed,
      //     path: homePath,
      //     builder: (context, state) {
      //       return const HomeView();
      //     }
      // ),
      GoRoute(
          name: settingsNamed,
          path: settingsPath,
          builder: (context, state) {
            return const SettingsPage();
          }
      ),
      GoRoute(
          name: signUpNamed,
          path: signUpPath,
          builder: (context, state) {
            return const SignUpView();
          }
      ),
      // GoRoute(
      //     name: loginNamed,
      //     path: loginPath,
      //     builder: (context, state) {
      //       return const LoginView();
      //     }
      // ),
      GoRoute(
        name: dogImageRandomNamed,
        path: dogImageRandomPath,
        builder: (context, state) => const DogImageRandomView(),
      ),

    ],
  );
}