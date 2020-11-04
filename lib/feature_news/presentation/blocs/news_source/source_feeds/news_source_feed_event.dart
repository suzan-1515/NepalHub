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
  final Language language;
  const GetMoreSourceNewsEvent({this.language = Language.NEPALI});

  @override
  List<Object> get props => [language];
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

class FeedChangeEvent extends NewsSourceFeedEvent {
  final Object data;
  final String eventType;
  const FeedChangeEvent({@required this.data, @required this.eventType});

  @override
  List<Object> get props => [data, eventType];
}
