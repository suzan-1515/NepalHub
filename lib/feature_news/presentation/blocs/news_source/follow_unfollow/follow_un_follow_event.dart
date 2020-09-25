part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowEvent extends Equatable {
  const FollowUnFollowEvent();
}

class FollowEvent extends FollowUnFollowEvent {
  final NewsSourceEntity sourceModel;

  FollowEvent({@required this.sourceModel});

  @override
  List<Object> get props => [sourceModel];
}

class UnFollowEvent extends FollowUnFollowEvent {
  final NewsSourceEntity sourceModel;

  UnFollowEvent({@required this.sourceModel});

  @override
  List<Object> get props => [sourceModel];
}
