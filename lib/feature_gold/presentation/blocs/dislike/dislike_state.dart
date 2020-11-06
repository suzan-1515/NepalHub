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
  final GoldSilverEntity goldSilver;

  DislikeSuccess({this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}

class UndislikeSuccess extends DislikeState {
  final GoldSilverEntity goldSilver;

  UndislikeSuccess({this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}

class DislikeError extends DislikeState {
  final String message;

  DislikeError({this.message});

  @override
  List<Object> get props => [message];
}
