part of 'bookmark_un_bookmark_bloc.dart';

abstract class BookmarkUnBookmarkEvent extends Equatable {
  const BookmarkUnBookmarkEvent();
}

class BookmarkNews extends BookmarkUnBookmarkEvent {
  final NewsFeedUIModel feedModel;

  const BookmarkNews({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}

class UnBookmarkNews extends BookmarkUnBookmarkEvent {
  final NewsFeedUIModel feedModel;

  const UnBookmarkNews({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}
