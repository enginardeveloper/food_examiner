import 'package:foodexaminer/data/model/dog_image.dart';

import '../../../../data_provider/remote/rest/api_client/dog_api_client.dart';
import '../../../../data_provider/remote/rest/dto/dog_image_dto.dart';
import '../dog_image_random_repository.dart';

class DogImageRandomRepositoryImpl implements DogImageRandomRepository {
  late final DogApiClient _dogApiClient;

  DogImageRandomRepositoryImpl({
      required DogApiClient dogApiClient,}
  ) : _dogApiClient = dogApiClient;

  @override
  Future<DogImage> getDogImageRandom() async {
    DogImageDTO dogImageDTO = await _dogApiClient.getDogImageRandom();
    DogImage dogImage =
        new DogImage(message: dogImageDTO.message, status: dogImageDTO.status);
    return dogImage;
  }
}
