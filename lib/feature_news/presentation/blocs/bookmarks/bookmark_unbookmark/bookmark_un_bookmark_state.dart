part of 'bookmark_un_bookmark_bloc.dart';

abstract class BookmarkUnBookmarkState extends Equatable {
  const BookmarkUnBookmarkState();
}

class BookmarkUnBookmarkInitial extends BookmarkUnBookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkSuccess extends BookmarkUnBookmarkState {
  final String message;

  const BookmarkSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class BookmarkInProgress extends BookmarkUnBookmarkState {
  const BookmarkInProgress();

  @override
  List<Object> get props => [];
}

class UnbookmarkSuccess extends BookmarkUnBookmarkState {
  final String message;

  const UnbookmarkSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class BookmarkUnBookmarkError extends BookmarkUnBookmarkState {
  final String message;

  const BookmarkUnBookmarkError({this.message});

  @override
  List<Object> get props => [message];
}
