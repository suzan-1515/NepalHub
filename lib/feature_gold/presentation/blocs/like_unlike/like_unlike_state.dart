part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  const LikeUnlikeState();
}

class InitialState extends LikeUnlikeState {
  @override
  List<Object> get props => [];
}

class InProgressState extends LikeUnlikeState {
  @override
  List<Object> get props => [];
}

class LikedState extends LikeUnlikeState {
  final GoldSilverEntity goldSilver;

  LikedState({this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}

class UnlikedState extends LikeUnlikeState {
  final GoldSilverEntity goldSilver;

  UnlikedState({this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}

class ErrorState extends LikeUnlikeState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
