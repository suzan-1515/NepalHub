part of 'dislike_bloc.dart';

abstract class DislikeUndislikeEvent extends Equatable {
  const DislikeUndislikeEvent();
  @override
  List<Object> get props => [];
}

class DislikeEvent extends DislikeUndislikeEvent {
  final GoldSilverEntity goldSilver;

  DislikeEvent({@required this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}

class UndislikeEvent extends DislikeUndislikeEvent {
  final GoldSilverEntity goldSilver;

  UndislikeEvent({@required this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}
