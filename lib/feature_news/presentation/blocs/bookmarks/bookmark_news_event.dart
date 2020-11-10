part of 'bookmark_news_bloc.dart';

abstract class BookmarkNewsEvent extends Equatable {
  const BookmarkNewsEvent();
  @override
  List<Object> get props => [];
}

class GetBookmarkedNews extends BookmarkNewsEvent {}

class RefreshBookmarkedNewsEvent extends BookmarkNewsEvent {}

class LoadMoreBookmarkedNewsEvent extends BookmarkNewsEvent {}
