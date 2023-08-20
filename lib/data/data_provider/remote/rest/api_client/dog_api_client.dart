import 'package:dio/dio.dart';
import 'package:foodexaminer/configs/app_config.dart';

import '../dto/dog_image_dto.dart';


class DogApiClient {

  final Dio dio;

  DogApiClient(this.dio,);

  Future<DogImageDTO> getDogImageRandom() async {
    final result = await dio.get(AppConfig.baseUrl + '/breeds/image/random',);
    final value = DogImageDTO.fromJson(result.data!);
    return value;
  }

}