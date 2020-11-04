part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();
}

class InitialState extends FeedState {
  @override
  List<Object> get props => [];
}

class LoadingState extends FeedState {
  @override
  List<Object> get props => [];
}

class LoadingMoreState extends FeedState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends FeedState {
  final List<NewsFeedEntity> feeds;
  final bool hasMore;

  LoadSuccessState({@required this.feeds, this.hasMore = true});

  LoadSuccessState copyWith({List<NewsFeedEntity> feeds, bool hasMore}) =>
      LoadSuccessState(
          feeds: feeds ?? this.feeds, hasMore: hasMore ?? this.hasMore);

  @override
  List<Object> get props => [feeds, hasMore];
}

class EmptyState extends FeedState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadErrorState extends FeedState {
  final String message;

  LoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends FeedState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
