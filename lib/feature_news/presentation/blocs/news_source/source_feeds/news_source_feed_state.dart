part of 'news_source_feed_bloc.dart';

abstract class NewsSourceFeedState extends Equatable {}

class NewsSourceFeedInitialState extends NewsSourceFeedState {
  final NewsSourceUIModel sourceModel;
  NewsSourceFeedInitialState({@required this.sourceModel});

  @override
  List<Object> get props => [sourceModel.source];
}

class NewsSourceFeedLoadingState extends NewsSourceFeedState {
  @override
  List<Object> get props => [];
}

class NewsSourceFeedMoreLoadingState extends NewsSourceFeedState {
  @override
  List<Object> get props => [];
}

class NewsSourceFeedLoadSuccessState extends NewsSourceFeedState {
  final List<NewsFeedUIModel> feeds;
  final bool hasMore;

  NewsSourceFeedLoadSuccessState({this.feeds, this.hasMore});

  NewsSourceFeedLoadSuccessState copyWith({
    List<NewsFeedUIModel> feeds,
    bool hasMore,
  }) =>
      NewsSourceFeedLoadSuccessState(
        feeds: feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class NewsSourceFeedEmptyState extends NewsSourceFeedState {
  final String message;

  NewsSourceFeedEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsSourceFeedErrorState extends NewsSourceFeedState {
  final String message;

  NewsSourceFeedErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsSourceFeedLoadErrorState extends NewsSourceFeedState {
  final String message;

  NewsSourceFeedLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
