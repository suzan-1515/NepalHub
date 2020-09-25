part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  const LikeUnlikeState();

  @override
  List<Object> get props => [];
}

class InitialState extends LikeUnlikeState {}

class InProgressState extends LikeUnlikeState {}

class LikeSuccessState extends LikeUnlikeState {}

class UnlikeSuccessState extends LikeUnlikeState {}

class ErrorState extends LikeUnlikeState {
  final String message;

  ErrorState({this.message});
  @override
  List<Object> get props => [message];
}
