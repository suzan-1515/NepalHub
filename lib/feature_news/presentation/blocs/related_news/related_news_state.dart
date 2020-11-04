part of 'related_news_bloc.dart';

abstract class RelatedNewsState extends Equatable {
  const RelatedNewsState();

  @override
  List<Object> get props => [];
}

class InitialState extends RelatedNewsState {}

class LoadingState extends RelatedNewsState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends RelatedNewsState {
  final List<NewsFeedEntity> feeds;

  LoadSuccessState(this.feeds);
}

class EmptyState extends RelatedNewsState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadErrorState extends RelatedNewsState {
  final String message;

  LoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends RelatedNewsState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
