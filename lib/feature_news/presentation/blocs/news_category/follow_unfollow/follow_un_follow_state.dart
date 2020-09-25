part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowState extends Equatable {
  const FollowUnFollowState();
}

class Initial extends FollowUnFollowState {
  @override
  List<Object> get props => [];
}

class InProgress extends FollowUnFollowState {
  @override
  List<Object> get props => [];
}

class Followed extends FollowUnFollowState {
  final String message;

  Followed({this.message});

  @override
  List<Object> get props => [message];
}

class UnFollowed extends FollowUnFollowState {
  final String message;

  UnFollowed({this.message});

  @override
  List<Object> get props => [message];
}

class Error extends FollowUnFollowState {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}
