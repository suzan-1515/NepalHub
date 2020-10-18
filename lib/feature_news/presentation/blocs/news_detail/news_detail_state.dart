part of 'news_detail_bloc.dart';

abstract class NewsDetailState extends Equatable {
  const NewsDetailState();
}

class InitialState extends NewsDetailState {
  final NewsFeedUIModel feed;

  InitialState({this.feed});

  @override
  List<Object> get props => [feed];
}

class LoadingState extends NewsDetailState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends NewsDetailState {
  final NewsFeedUIModel feed;

  LoadSuccessState(this.feed);

  @override
  List<Object> get props => [feed];
}

class EmptyState extends NewsDetailState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadErrorState extends NewsDetailState {
  final String message;

  LoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends NewsDetailState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
