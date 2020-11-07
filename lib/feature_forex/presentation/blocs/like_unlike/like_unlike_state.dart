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
  final ForexEntity forex;

  LikedState({@required this.forex});

  @override
  List<Object> get props => [forex];
}

class UnlikedState extends LikeUnlikeState {
  final ForexEntity forex;

  UnlikedState({@required this.forex});

  @override
  List<Object> get props => [forex];
}

class ErrorState extends LikeUnlikeState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
