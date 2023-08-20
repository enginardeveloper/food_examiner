part of 'dog_image_random_bloc.dart';

class DogImageRandomState extends Equatable {
  final UIStatusState statusState;
  final DogImage dogImage;
  final bool isBusy;
  final DogImageRandomNotification? notification;

  @override
  // TODO: implement props
  List<Object?> get props => [statusState, dogImage, isBusy];

//<editor-fold desc="Data Methods">

  const DogImageRandomState({
    this.statusState = const UIStatusInitial(),
    this.dogImage = const DogImage(message: '', status: ''),
    this.isBusy = false,
    this.notification,
  });

//   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is DogImageRandomState &&
              runtimeType == other.runtimeType &&
              statusState == other.statusState &&
              dogImage == other.dogImage &&
              isBusy == other.isBusy &&
              notification == other.notification
          );


  @override
  int get hashCode =>
      statusState.hashCode ^
      dogImage.hashCode ^
      isBusy.hashCode ^
      notification.hashCode;


  @override
  String toString() {
    return 'DogImageRandomState{' +
        ' statusState: $statusState,' +
        ' dogImage: $dogImage,' +
        ' isBusy: $isBusy,' +
        ' notification: $notification,' +
        '}';
  }


  DogImageRandomState copyWith({
    UIStatusState? statusState,
    DogImage? dogImage,
    bool? isBusy,
    DogImageRandomNotification? notification,
  }) {
    return DogImageRandomState(
      statusState: statusState ?? this.statusState,
      dogImage: dogImage ?? this.dogImage,
      isBusy: isBusy ?? this.isBusy,
      notification: notification ?? this.notification,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'statusState': this.statusState,
      'dogImage': this.dogImage,
      'isBusy': this.isBusy,
      'notification': this.notification,
    };
  }

  factory DogImageRandomState.fromMap(Map<String, dynamic> map) {
    return DogImageRandomState(
      statusState: map['statusState'] as UIStatusState,
      dogImage: map['dogImage'] as DogImage,
      isBusy: map['isBusy'] as bool,
      notification: map['notification'] as DogImageRandomNotification,
    );
  }


  //</editor-fold>



}

