part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowState extends Equatable {
  const FollowUnFollowState();
}

class FollowUnFollowInitialState extends FollowUnFollowState {
  @override
  List<Object> get props => [];
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

class FollowUnFollowErrorstate extends FollowUnFollowState {
  final String message;

  FollowUnFollowErrorstate({this.message});

  @override
  List<Object> get props => [message];
}
