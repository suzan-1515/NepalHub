part of 'bookmark_news_bloc.dart';

abstract class BookmarkNewsState extends Equatable {
  const BookmarkNewsState();
}

class InitialState extends BookmarkNewsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BookmarkNewsState {
  @override
  List<Object> get props => [];
}

class LoadingMoreState extends BookmarkNewsState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends BookmarkNewsState {
  final List<NewsFeedEntity> feeds;
  final bool hasMore;

  const LoadSuccessState(this.feeds, {this.hasMore = true});

  LoadSuccessState copyWith({
    List<NewsFeedEntity> feeds,
    bool hasMore,
  }) =>
      LoadSuccessState(
        feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class EmptyState extends BookmarkNewsState {
  final String message;

  const EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadErrorState extends BookmarkNewsState {
  final String message;

  const LoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends BookmarkNewsState {
  final String message;

  const ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
