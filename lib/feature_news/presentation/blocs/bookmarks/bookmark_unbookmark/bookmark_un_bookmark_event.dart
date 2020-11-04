part of 'bookmark_un_bookmark_bloc.dart';

abstract class BookmarkUnBookmarkEvent extends Equatable {
  const BookmarkUnBookmarkEvent();
  @override
  List<Object> get props => [];
}

class BookmarkNews extends BookmarkUnBookmarkEvent {
  final NewsFeedEntity feed;

  BookmarkNews({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UnBookmarkNews extends BookmarkUnBookmarkEvent {
  final NewsFeedEntity feed;

  UnBookmarkNews({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UpdateBookmarkEvent extends BookmarkUnBookmarkEvent {
  final NewsFeedEntity feed;

  UpdateBookmarkEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UpdateUnbookmarkEvent extends BookmarkUnBookmarkEvent {
  final NewsFeedEntity feed;

  UpdateUnbookmarkEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}
