import 'package:get_it/get_it.dart';

import '../../features/app/bloc/app_bloc.dart';
import '../../features/dog_image_random/bloc/dog_image_random_bloc.dart';
import '../../features/login/cubit/login_cubit.dart';
import '../../features/sign_up/cubit/sign_up_cubit.dart';
import '../injector.dart';

class BlocModule {
  BlocModule._();

  static final GetIt _injector = Injector.instance;

  static void init() {
    _injector
      ..registerLazySingleton<AppBloc>(() =>
          AppBloc(
            logService: _injector(),
            appService: _injector(),
            authenticationRepository: _injector(),
          ),
      )
      ..registerLazySingleton<LoginCubit>(() =>
          LoginCubit(
            authenticationRepository: _injector(),
            logService: _injector(),
          ),
      )
      ..registerLazySingleton<SignUpCubit>(() =>
          SignUpCubit(
            authenticationRepository: _injector(),
            logService: _injector(),
          ),
      )
    ..registerFactory<DogImageRandomBloc>(() =>
        DogImageRandomBloc(
          logService: _injector(),
          dogImageRandomRepository: _injector(),
        ),
    );

  }

}