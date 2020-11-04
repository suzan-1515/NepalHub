part of 'news_topic_bloc.dart';

abstract class NewsTopicState extends Equatable {
  const NewsTopicState();
}

class NewsTopicInitialState extends NewsTopicState {
  @override
  List<Object> get props => [];
}

class NewsTopicLoadingState extends NewsTopicState {
  @override
  List<Object> get props => [];
}

class NewsTopicRefreshingState extends NewsTopicState {
  @override
  List<Object> get props => [];
}

class NewsTopicLoadSuccessState extends NewsTopicState {
  final List<NewsTopicEntity> topics;

  NewsTopicLoadSuccessState(this.topics);

  @override
  List<Object> get props => [topics];
}

class NewsTopicLoadEmptyState extends NewsTopicState {
  final String message;

  NewsTopicLoadEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsTopicLoadErrorState extends NewsTopicState {
  final String message;

  NewsTopicLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsTopicErrorState extends NewsTopicState {
  final String message;

  NewsTopicErrorState({this.message});

  @override
  List<Object> get props => [message];
}
