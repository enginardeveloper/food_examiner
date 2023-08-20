import '../../../model/dog_image.dart';

abstract class DogImageRandomRepository {

  Future<DogImage> getDogImageRandom();

}