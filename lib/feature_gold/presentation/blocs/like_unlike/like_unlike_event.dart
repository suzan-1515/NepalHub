part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
  @override
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent {
  final GoldSilverEntity goldSilver;

  LikeEvent({@required this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}

class UnlikeEvent extends LikeUnlikeEvent {
  final GoldSilverEntity goldSilver;

  UnlikeEvent({@required this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}
