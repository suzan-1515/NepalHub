part of 'news_sources_bloc.dart';

abstract class NewsSourcesEvent extends Equatable {
  const NewsSourcesEvent();
}

class GetSourcesEvent extends NewsSourcesEvent {
  final Language language;

  GetSourcesEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class GetFollowedSourcesEvent extends NewsSourcesEvent {
  final Language language;

  GetFollowedSourcesEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class RefreshSourceEvent extends NewsSourcesEvent {
  final Language language;

  RefreshSourceEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}
