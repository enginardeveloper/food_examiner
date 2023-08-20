import 'package:foodexaminer/data/data_provider/remote/rest/api_client/dog_api_client.dart';
import 'package:foodexaminer/injector/modules/dio_module.dart';
import 'package:get_it/get_it.dart';

import '../injector.dart';

class RestApiClientModule {
  RestApiClientModule._();

  static final GetIt _injector = Injector.instance;

  static void init() {
    _injector.registerFactory<DogApiClient>(
      () => DogApiClient(
        _injector(instanceName: DioModule.dioInstanceName),
      ),
    );
  }


}
