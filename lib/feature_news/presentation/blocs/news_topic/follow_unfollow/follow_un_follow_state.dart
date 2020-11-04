part of 'follow_un_follow_bloc.dart';

abstract class TopicFollowUnFollowState extends Equatable {
  const TopicFollowUnFollowState();
}

class TopicFollowInitialState extends TopicFollowUnFollowState {
  @override
  List<Object> get props => [];
}

class TopicFollowInProgressState extends TopicFollowUnFollowState {
  @override
  List<Object> get props => [];
}

class TopicFollowSuccessState extends TopicFollowUnFollowState {
  final NewsTopicEntity topic;

  TopicFollowSuccessState({this.topic});

  @override
  List<Object> get props => [topic];
}

class TopicUnFollowSuccessState extends TopicFollowUnFollowState {
  final NewsTopicEntity topic;

  TopicUnFollowSuccessState({this.topic});

  @override
  List<Object> get props => [topic];
}

class TopicFollowErrorState extends TopicFollowUnFollowState {
  final String message;

  TopicFollowErrorState({this.message});

  @override
  List<Object> get props => [message];
}
