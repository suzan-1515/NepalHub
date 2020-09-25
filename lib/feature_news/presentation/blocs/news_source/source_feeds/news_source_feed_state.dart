part of 'news_source_feed_bloc.dart';

abstract class NewsSourceFeedState extends Equatable {}

class InitialState extends NewsSourceFeedState {
  final NewsSourceUIModel sourceModel;
  InitialState({@required this.sourceModel});

  @override
  List<Object> get props => [sourceModel.source];
}

class LoadingState extends NewsSourceFeedState {
  @override
  List<Object> get props => [];
}

class MoreLoadingState extends NewsSourceFeedState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends NewsSourceFeedState {
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

class EmptyState extends NewsSourceFeedState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends NewsSourceFeedState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadMoreErrorState extends NewsSourceFeedState {
  final String message;

  LoadMoreErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class RefreshingState extends NewsSourceFeedState {
  @override
  List<Object> get props => [];
}

class RefreshErrorState extends NewsSourceFeedState {
  final String message;

  RefreshErrorState({this.message});

  @override
  List<Object> get props => [message];
}
