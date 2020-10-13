part of 'bookmark_un_bookmark_bloc.dart';

abstract class BookmarkUnBookmarkEvent extends Equatable {
  const BookmarkUnBookmarkEvent();
  @override
  List<Object> get props => [];
}

class BookmarkNews extends BookmarkUnBookmarkEvent {}

class UnBookmarkNews extends BookmarkUnBookmarkEvent {}
