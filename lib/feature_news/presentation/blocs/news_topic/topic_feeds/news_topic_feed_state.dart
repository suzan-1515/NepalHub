part of 'news_topic_feed_bloc.dart';

abstract class NewsTopicFeedState extends Equatable {}

class NewsTopicFeedInitialState extends NewsTopicFeedState {
  final NewsTopicEntity topic;
  NewsTopicFeedInitialState({@required this.topic});

  @override
  List<Object> get props => [topic];
}

class NewsTopicFeedLoadingState extends NewsTopicFeedState {
  @override
  List<Object> get props => [];
}

class NewsTopicFeedMoreLoadingState extends NewsTopicFeedState {
  @override
  List<Object> get props => [];
}

class NewsTopicFeedLoadSuccessState extends NewsTopicFeedState {
  final List<NewsFeedEntity> feeds;
  final bool hasMore;

  NewsTopicFeedLoadSuccessState({this.feeds, this.hasMore});

  NewsTopicFeedLoadSuccessState copyWith({
    List<NewsFeedEntity> feeds,
    bool hasMore,
  }) =>
      NewsTopicFeedLoadSuccessState(
        feeds: feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class NewsTopicFeedEmptyState extends NewsTopicFeedState {
  final String message;

  NewsTopicFeedEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsTopicFeedErrorState extends NewsTopicFeedState {
  final String message;

  NewsTopicFeedErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsTopicFeedLoadErrorState extends NewsTopicFeedState {
  final String message;

  NewsTopicFeedLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
