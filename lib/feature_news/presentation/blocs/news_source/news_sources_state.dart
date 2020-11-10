part of 'news_sources_bloc.dart';

abstract class NewsSourceState extends Equatable {
  const NewsSourceState();
}

class NewsSourceInitialState extends NewsSourceState {
  @override
  List<Object> get props => [];
}

class NewsSourceLoadingState extends NewsSourceState {
  @override
  List<Object> get props => [];
}

class NewsSourceRefreshingState extends NewsSourceState {
  @override
  List<Object> get props => [];
}

class NewsSourceLoadSuccessState extends NewsSourceState {
  final List<NewsSourceUIModel> sources;

  NewsSourceLoadSuccessState(this.sources);

  @override
  List<Object> get props => [sources];
}

class NewsSourceLoadEmptyState extends NewsSourceState {
  final String message;

  NewsSourceLoadEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsSourceErrorState extends NewsSourceState {
  final String message;

  NewsSourceErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsSourceLoadErrorState extends NewsSourceState {
  final String message;

  NewsSourceLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
