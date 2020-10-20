part of 'news_source_feed_bloc.dart';

abstract class NewsSourceFeedEvent extends Equatable {
  const NewsSourceFeedEvent();
}

class GetSourceNewsEvent extends NewsSourceFeedEvent {
  final Language language;

  GetSourceNewsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}

class GetMoreSourceNewsEvent extends NewsSourceFeedEvent {
  final int page;
  final Language language;
  const GetMoreSourceNewsEvent({this.page, this.language = Language.NEPALI});

  @override
  List<Object> get props => [page, language];
}

class RetrySourceNewsEvent extends NewsSourceFeedEvent {
  @override
  List<Object> get props => [];
}

class RefreshSourceNewsEvent extends NewsSourceFeedEvent {
  final Language language;

  RefreshSourceNewsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}
