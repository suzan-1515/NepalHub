part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class GetNewsEvent extends FeedEvent {
  final int page;
  final Language langugage;
  final NewsType newsType;

  GetNewsEvent(
      {this.page = 1,
      this.langugage = Language.NEPALI,
      @required this.newsType});

  @override
  List<Object> get props => [page, langugage];
}

class RefreshNewsEvent extends FeedEvent {
  final int page;
  final Language langugage;
  final NewsType newsType;

  RefreshNewsEvent(
      {this.page = 1,
      this.langugage = Language.NEPALI,
      @required this.newsType});

  @override
  List<Object> get props => [page, langugage];
}

class LoadMoreNewsEvent extends FeedEvent {
  final int page;
  final Language langugage;
  final NewsType newsType;

  LoadMoreNewsEvent(
      {this.page = 1,
      this.langugage = Language.NEPALI,
      @required this.newsType});

  @override
  List<Object> get props => [page, langugage];
}

class FeedChangeEvent extends FeedEvent {
  final Object data;
  final String eventType;
  const FeedChangeEvent({@required this.data, @required this.eventType});

  @override
  List<Object> get props => [data, eventType];
}
