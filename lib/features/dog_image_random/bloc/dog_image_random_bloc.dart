import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../core/bloc_core/ui_status_state.dart';
import '../../../data/model/dog_image.dart';
import '../../../data/repository/remote/dog_image_random_repository/dog_image_random_repository.dart';
import '../../../data/repository/remote/dog_image_random_repository/impl/dog_image_random_repository_impl.dart';
import '../../../services/log_service/log_service.dart';
import 'dog_image_random_notification.dart';

part 'dog_image_random_event.dart';

part 'dog_image_random_state.dart';

class DogImageRandomBloc
    extends Bloc<DogImageRandomEvent, DogImageRandomState> {
  late final DogImageRandomRepository _dogImageRandomRepository;
  late final LogService _logService;

  DogImageRandomBloc(
      {required DogImageRandomRepository dogImageRandomRepository,
      required LogService logService})
      : super(DogImageRandomState()) {
    _dogImageRandomRepository = dogImageRandomRepository;
    _logService = logService;

    on<DogImageRandomEventLoaded>(_onLoaded);
    on<DogImageRandomEventRandomRequested>(_onRandomRequested,
        transformer: droppable());
  }

  FutureOr<void> _onLoaded(
      DogImageRandomEventLoaded event, Emitter<DogImageRandomState> emit) {
    try {
      emit(state.copyWith(statusState: UIStatusLoading()));
      emit(state.copyWith(statusState: UIStatusLoadSuccess()));
    } catch (e, stackTrace) {
      _logService.e('DogImageRandomLoaded failed', e, stackTrace);
      emit(state.copyWith(
          statusState: UIStatusLoadFailed(message: e.toString())));
    }
  }

  FutureOr<void> _onRandomRequested(DogImageRandomEventRandomRequested event,
      Emitter<DogImageRandomState> emit) async {
    try {
      emit(state.copyWith(isBusy: true));
      final DogImage image =
          await _dogImageRandomRepository.getDogImageRandom();
      emit(state.copyWith(
          statusState: const UIStatusLoadSuccess(),
          isBusy: false,
          dogImage: image));
    } catch (e, stackTrace) {
      _logService.e('DogImageRandomLoaded failed', e, stackTrace);
      emit(state.copyWith(
          isBusy: false,
          notification: NotificationNotifyFailed(message: e.toString())));
    }
  }
}
