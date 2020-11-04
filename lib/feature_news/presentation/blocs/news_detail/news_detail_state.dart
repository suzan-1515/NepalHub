part of 'news_detail_bloc.dart';

abstract class NewsDetailState extends Equatable {
  const NewsDetailState();
}

class NewsDetailInitialState extends NewsDetailState {
  final NewsFeedEntity feed;

  NewsDetailInitialState({this.feed});

  @override
  List<Object> get props => [feed];
}

class NewsDetailLoadingState extends NewsDetailState {
  @override
  List<Object> get props => [];
}

class NewsDetailLoadSuccessState extends NewsDetailState {
  final NewsFeedEntity feed;

  NewsDetailLoadSuccessState(this.feed);

  @override
  List<Object> get props => [feed];
}

class NewsDetailEmptyState extends NewsDetailState {
  final String message;

  NewsDetailEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsDetailLoadErrorState extends NewsDetailState {
  final String message;

  NewsDetailLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsDetailErrorState extends NewsDetailState {
  final String message;

  NewsDetailErrorState({this.message});

  @override
  List<Object> get props => [message];
}
