part of 'news_detail_bloc.dart';

abstract class NewsDetailEvent extends Equatable {
  const NewsDetailEvent();
}

class GetNewsDetailEvent extends NewsDetailEvent {
  GetNewsDetailEvent();

  @override
  List<Object> get props => [];
}

class FeedChangeEvent extends NewsDetailEvent {
  final Object data;
  final String eventType;
  const FeedChangeEvent({@required this.data, @required this.eventType});

  @override
  List<Object> get props => [data, eventType];
}
