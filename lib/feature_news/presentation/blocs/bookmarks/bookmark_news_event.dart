part of 'bookmark_news_bloc.dart';

abstract class BookmarkNewsEvent extends Equatable {
  const BookmarkNewsEvent();
  @override
  List<Object> get props => [];
}

class GetBookmarkedNews extends BookmarkNewsEvent {}

class RefreshBookmarkedNewsEvent extends BookmarkNewsEvent {}

class LoadMoreBookmarkedNewsEvent extends BookmarkNewsEvent {}

class FeedChangeEvent extends BookmarkNewsEvent {
  final Object data;
  final String eventType;
  const FeedChangeEvent({@required this.data, @required this.eventType});

  @override
  List<Object> get props => [data, eventType];
}
