part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowEvent extends Equatable {
  const FollowUnFollowEvent();
}

class FollowEvent extends FollowUnFollowEvent {
  final NewsTopicUIModel topicModel;

  FollowEvent({@required this.topicModel});

  @override
  List<Object> get props => [topicModel.topic];
}

class UnFollowEvent extends FollowUnFollowEvent {
  final NewsTopicUIModel topicModel;

  UnFollowEvent({@required this.topicModel});

  @override
  List<Object> get props => [topicModel.topic];
}
