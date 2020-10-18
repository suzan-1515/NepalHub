part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowState extends Equatable {
  const FollowUnFollowState();

  @override
  List<Object> get props => [];
}

class FollowUnFollowInitialState extends FollowUnFollowState {
  FollowUnFollowInitialState();
}

class FollowUnFollowInProgressState extends FollowUnFollowState {
  @override
  List<Object> get props => [];
}

class FollowUnFollowFollowedState extends FollowUnFollowState {
  final String message;

  FollowUnFollowFollowedState({this.message});

  @override
  List<Object> get props => [message];
}

class FollowUnFollowUnFollowedState extends FollowUnFollowState {
  final String message;

  FollowUnFollowUnFollowedState({this.message});

  @override
  List<Object> get props => [message];
}

class FollowUnFollowErrorState extends FollowUnFollowState {
  final String message;

  FollowUnFollowErrorState({this.message});

  @override
  List<Object> get props => [message];
}
