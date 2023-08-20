import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexaminer/core/bloc_core/ui_status_state.dart';
import '../../../core/themes/app_themes.dart';
import '../../../injector/injector.dart';
import '../../../router/app_router.dart';
import '../../../services/log_service/log_service.dart';
import '../../../widgets/pages/splash_page.dart';
import '../bloc/app_bloc.dart';
import '../routes/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc _appBloc;
  late final LogService _logService;

  @override
  void initState() {
    _appBloc = Injector.instance<AppBloc>()
    ..add(AppEventLoaded());

    _logService  = Injector.instance<LogService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _logService.i("====ok we are here now");

   return BlocProvider.value(
     value: _appBloc,
     child: BlocSelector<AppBloc, AppState, UIStatusState>(
       bloc: _appBloc,
       selector: (state) => state.statusState,
       builder: (context, statusState) {

         _logService.i("====statusState: $statusState");

         if (statusState is UIStatusInitial || statusState is UIStatusLoading) {
           _logService.i("====UIStatusInitial || UIStatusLoading");
           return SplashPage();
         } else if (statusState is UIStatusLoadFailed) {
           _logService.i("====UIStatusLoadFailed");
           return const SizedBox(
             child: Text('Failed!!!!',style: TextStyle(color: Colors.white),),
           );
         } else if (statusState is UIStatusLoadSuccess) {
           _logService.i("====UIStatusLoadSuccess");
           return const _AppView();
         } else {
           _logService.i("====else: $statusState");
           return const SizedBox();
         }
       },
     ),
   );
  }

}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final String locale = context.select((AppBloc value) => value.state.locale);
    final bool isDarkMode = context.select((AppBloc value) => value.state.isDarkMode);

    final LogService _logService  = Injector.instance<LogService>();
    _logService.i("======isDarkMode in app_view: $isDarkMode");

    // return MaterialApp.router(
    //   // locale:
    //   // Provider.of<AppLanguageViewModel>(context, listen: true).appLocale,
    //   // supportedLocales: [
    //   //   Locale('en'),
    //   //   Locale('tr'),
    //   // ],
    //   // localizationsDelegates: [
    //   //   AppLocalizations.delegate,
    //   //   GlobalMaterialLocalizations.delegate,
    //   //   GlobalWidgetsLocalizations.delegate,
    //   //   GlobalCupertinoLocalizations.delegate,
    //   // ],
    //   debugShowCheckedModeBanner: false,
    //   themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light ,
    //   theme: AppThemes.lightTheme,
    //   darkTheme: AppThemes.darkTheme,
    //   routerConfig: AppRouter.router,
    //   title: 'Food Examiner',
    // );
    return MaterialApp(
      // locale:
      // Provider.of<AppLanguageViewModel>(context, listen: true).appLocale,
      // supportedLocales: [
      //   Locale('en'),
      //   Locale('tr'),
      // ],
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light ,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      title: 'Food Examiner',
      home: FlowBuilder<AuthenticationStatus>(
        state: context.select((AppBloc bloc) => bloc.state.authenticationStatus),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }

}

