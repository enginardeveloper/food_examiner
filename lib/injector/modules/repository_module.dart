import 'package:foodexaminer/data/repository/remote/authentication_repository/authentication_repository.dart';
import 'package:foodexaminer/data/repository/remote/dog_image_random_repository/impl/dog_image_random_repository_impl.dart';
import 'package:foodexaminer/injector/injector.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/remote/authentication_repository/impl/authentication_repository_impl.dart';
import '../../data/repository/remote/dog_image_random_repository/dog_image_random_repository.dart';

class RepositoryModule {
  RepositoryModule._();

  static final GetIt _injector = Injector.instance;

  static void init() {
    _injector
      ..registerFactory<DogImageRandomRepository>(
        () => DogImageRandomRepositoryImpl(dogApiClient: _injector()),
      )
      ..registerFactory<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(cache: _injector()),
      );
  }
}
