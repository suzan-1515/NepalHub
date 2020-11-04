part of 'news_filter_bloc.dart';

abstract class NewsFilterEvent extends Equatable {
  const NewsFilterEvent();
}

class GetNewsFilterSourcesEvent extends NewsFilterEvent {
  final Language language;

  GetNewsFilterSourcesEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class NewsFilterSourceChangedEvent extends NewsFilterEvent {
  final NewsSourceEntity source;

  NewsFilterSourceChangedEvent({this.source});

  @override
  List<Object> get props => [source];
}

class NewsFilterSortByChangedEvent extends NewsFilterEvent {
  final SortBy sortBy;

  NewsFilterSortByChangedEvent({this.sortBy});

  @override
  List<Object> get props => [sortBy];
}
