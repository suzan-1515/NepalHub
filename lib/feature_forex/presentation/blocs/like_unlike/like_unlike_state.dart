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
  final String message;

  LikedState({this.message});

  @override
  List<Object> get props => [message];
}

class UnlikedState extends LikeUnlikeState {
  final String message;

  UnlikedState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends LikeUnlikeState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
