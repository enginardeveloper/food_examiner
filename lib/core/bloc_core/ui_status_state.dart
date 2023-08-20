import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UIStatusState  {
const UIStatusState();
}

class UIStatusInitial extends UIStatusState {
   const UIStatusInitial();
}

class UIStatusLoading extends UIStatusState {
  const UIStatusLoading();
}

class UIStatusLoadFailed extends UIStatusState {
  final String message;
  const UIStatusLoadFailed({required this.message});
}

class UIStatusLoadSuccess extends UIStatusState {
  final String? message;
  const UIStatusLoadSuccess({this.message});
}