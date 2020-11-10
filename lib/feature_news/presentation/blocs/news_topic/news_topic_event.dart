part of 'news_topic_bloc.dart';

abstract class NewsTopicEvent extends Equatable {
  const NewsTopicEvent();
}

class GetTopicsEvent extends NewsTopicEvent {
  final Language language;

  GetTopicsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}

class GetFollowedTopicsEvent extends NewsTopicEvent {
  final Language language;

  GetFollowedTopicsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}

class RefreshTopicsEvent extends NewsTopicEvent {
  final Language language;

  RefreshTopicsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}
