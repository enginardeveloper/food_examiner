import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/view/home_page.dart';
import '../../intro/intro_view.dart';
import '../../login/view/login_page.dart';
import '../bloc/app_bloc.dart';
//
// class AppDirectorView extends StatelessWidget {
//   const AppDirectorView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppBloc, AppState>(
//       buildWhen: (prev, next) => prev.isFirstUse != next.isFirstUse,
//       builder: (context, state) {
//         final bool isFirstUse = state.isFirstUse;
//         if (isFirstUse) {
//           return const IntroView();
//         } else {
//           if (state.authenticationStatus == AuthenticationStatus.unauthenticated)
//             return const LoginView();
//
//           return const HomeView();
//         }
//       },
//     );
//   }
// }