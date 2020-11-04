part of 'bookmark_un_bookmark_bloc.dart';

abstract class BookmarkUnBookmarkState extends Equatable {
  const BookmarkUnBookmarkState();
}

class BookmarkUnBookmarkInitial extends BookmarkUnBookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkSuccess extends BookmarkUnBookmarkState {
  final NewsFeedEntity feed;

  const BookmarkSuccess({this.feed});

  @override
  List<Object> get props => [feed];
}

class BookmarkInProgress extends BookmarkUnBookmarkState {
  const BookmarkInProgress();

  @override
  List<Object> get props => [];
}

class UnbookmarkSuccess extends BookmarkUnBookmarkState {
  final NewsFeedEntity feed;

  const UnbookmarkSuccess({this.feed});

  @override
  List<Object> get props => [feed];
}

class BookmarkUnBookmarkError extends BookmarkUnBookmarkState {
  final String message;

  const BookmarkUnBookmarkError({this.message});

  @override
  List<Object> get props => [message];
}
