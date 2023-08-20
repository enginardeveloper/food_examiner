import 'package:equatable/equatable.dart';

class DogImageRandomNotification extends Equatable {
  const DogImageRandomNotification();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationNotifySuccess extends DogImageRandomNotification {
  final String message;

  const NotificationNotifySuccess(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationNotifyFailed extends DogImageRandomNotification {
  final String message;

  const NotificationNotifyFailed({required this.message});

  @override
  List<Object> get props => [message];
}