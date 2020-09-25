part of 'news_topic_feed_bloc.dart';

abstract class NewsTopicFeedState extends Equatable {}

class InitialState extends NewsTopicFeedState {
  final NewsTopicUIModel topicModel;
  InitialState({@required this.topicModel});

  @override
  List<Object> get props => [topicModel.topic];
}

class LoadingState extends NewsTopicFeedState {
  @override
  List<Object> get props => [];
}

class MoreLoadingState extends NewsTopicFeedState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends NewsTopicFeedState {
  final List<NewsFeedUIModel> feeds;
  final bool hasMore;

  LoadSuccessState({this.feeds, this.hasMore});

  LoadSuccessState copyWith({
    List<NewsFeedUIModel> feeds,
    bool hasMore,
  }) =>
      LoadSuccessState(
        feeds: feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class EmptyState extends NewsTopicFeedState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends NewsTopicFeedState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadMoreErrorState extends NewsTopicFeedState {
  final String message;

  LoadMoreErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class RefreshingState extends NewsTopicFeedState {
  @override
  List<Object> get props => [];
}

class RefreshErrorState extends NewsTopicFeedState {
  final String message;

  RefreshErrorState({this.message});

  @override
  List<Object> get props => [message];
}
