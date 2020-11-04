part of 'news_topic_feed_bloc.dart';

abstract class NewsTopicFeedEvent extends Equatable {
  const NewsTopicFeedEvent();
}

class GetTopicNewsEvent extends NewsTopicFeedEvent {
  final Language language;

  GetTopicNewsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}

class GetMoreTopicNewsEvent extends NewsTopicFeedEvent {
  final Language language;

  GetMoreTopicNewsEvent({this.language = Language.NEPALI});

  @override
  List<Object> get props => [];
}

class RefreshTopicNewsEvent extends NewsTopicFeedEvent {
  @override
  List<Object> get props => [];
}

class FeedChangeEvent extends NewsTopicFeedEvent {
  final Object data;
  final String eventType;
  const FeedChangeEvent({@required this.data, @required this.eventType});

  @override
  List<Object> get props => [data, eventType];
}
