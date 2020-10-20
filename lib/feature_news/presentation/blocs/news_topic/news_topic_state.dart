part of 'news_topic_bloc.dart';

abstract class NewsTopicState extends Equatable {
  const NewsTopicState();
}

class InitialState extends NewsTopicState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NewsTopicState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends NewsTopicState {
  final List<NewsTopicUIModel> topics;

  LoadSuccessState(this.topics);

  @override
  List<Object> get props => [topics];
}

class EmptyState extends NewsTopicState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends NewsTopicState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
