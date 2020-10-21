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
