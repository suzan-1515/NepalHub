part of 'related_news_bloc.dart';

abstract class RelatedNewsEvent extends Equatable {
  const RelatedNewsEvent();
}

class GetRelatedNewsEvent extends RelatedNewsEvent {
  final NewsFeedUIModel parentFeed;
  GetRelatedNewsEvent({@required this.parentFeed});

  @override
  List<Object> get props => [parentFeed.feed];
}
