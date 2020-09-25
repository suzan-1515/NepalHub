part of 'news_sources_bloc.dart';

abstract class NewsSourceState extends Equatable {
  const NewsSourceState();
}

class InitialState extends NewsSourceState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NewsSourceState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends NewsSourceState {
  final List<NewsSourceUIModel> sources;

  LoadSuccessState(this.sources);

  @override
  List<Object> get props => [sources];
}

class EmptyState extends NewsSourceState {
  final String message;

  EmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends NewsSourceState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
