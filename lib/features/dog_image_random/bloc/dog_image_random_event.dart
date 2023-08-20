part of 'dog_image_random_bloc.dart';

class DogImageRandomEvent extends Equatable {

  const DogImageRandomEvent();

  @override
  List<Object?> get props => [];

}

class DogImageRandomEventLoaded extends DogImageRandomEvent {
  const DogImageRandomEventLoaded();
}

class DogImageRandomEventRandomRequested extends DogImageRandomEvent {
  final bool insertDb;

  const DogImageRandomEventRandomRequested({this.insertDb = false});
}

