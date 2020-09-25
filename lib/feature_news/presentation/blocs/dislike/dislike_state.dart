part of 'dislike_bloc.dart';

abstract class DislikeState extends Equatable {
  const DislikeState();
}

class DislikeInitial extends DislikeState {
  @override
  List<Object> get props => [];
}

class DislikeInProgress extends DislikeState {
  @override
  List<Object> get props => [];
}

class DislikeSuccess extends DislikeState {
  final String message;

  DislikeSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class UndislikeSuccess extends DislikeState {
  final String message;

  UndislikeSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class DislikeError extends DislikeState {
  final String message;

  DislikeError({this.message});

  @override
  List<Object> get props => [message];
}
