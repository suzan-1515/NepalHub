part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowState extends Equatable {
  const FollowUnFollowState();
}

class InitialState extends FollowUnFollowState {
  @override
  List<Object> get props => [];
}

class InProgressState extends FollowUnFollowState {
  @override
  List<Object> get props => [];
}

class FollowedState extends FollowUnFollowState {
  final String message;

  FollowedState({this.message});

  @override
  List<Object> get props => [message];
}

class UnFollowedState extends FollowUnFollowState {
  final String message;

  UnFollowedState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends FollowUnFollowState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
