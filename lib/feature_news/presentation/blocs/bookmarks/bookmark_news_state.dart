part of 'bookmark_news_bloc.dart';

abstract class BookmarkNewsState extends Equatable {
  const BookmarkNewsState();
}

class BookmarkNewsInitialState extends BookmarkNewsState {
  @override
  List<Object> get props => [];
}

class BookmarkNewsLoadingState extends BookmarkNewsState {
  @override
  List<Object> get props => [];
}

class BookmarkNewsLoadingMoreState extends BookmarkNewsState {
  @override
  List<Object> get props => [];
}

class BookmarkNewsLoadSuccessState extends BookmarkNewsState {
  final List<NewsFeedUIModel> feeds;
  final bool hasMore;

  const BookmarkNewsLoadSuccessState(this.feeds, {this.hasMore = true});

  BookmarkNewsLoadSuccessState copyWith({
    List<NewsFeedUIModel> feeds,
    bool hasMore,
  }) =>
      BookmarkNewsLoadSuccessState(
        feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class BookmarkNewsEmptyState extends BookmarkNewsState {
  final String message;

  const BookmarkNewsEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class BookmarkNewsLoadErrorState extends BookmarkNewsState {
  final String message;

  const BookmarkNewsLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class BookmarkNewsErrorState extends BookmarkNewsState {
  final String message;

  const BookmarkNewsErrorState({this.message});

  @override
  List<Object> get props => [message];
}
