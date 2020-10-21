part of 'news_filter_bloc.dart';

abstract class NewsFilterState extends Equatable {}

class InitialState extends NewsFilterState {
  @override
  List<Object> get props => [];
}

class SourceLoadingState extends NewsFilterState {
  @override
  List<Object> get props => [];
}

class SourceLoadSuccessState extends NewsFilterState {
  final List<NewsSourceUIModel> sources;

  SourceLoadSuccessState({this.sources});

  @override
  List<Object> get props => [sources];
}

class SourceLoadErrorState extends NewsFilterState {
  final String message;

  SourceLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class SourceEmptyState extends NewsFilterState {
  final String message;

  SourceEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class SourceChangedState extends NewsFilterState {
  final NewsSourceUIModel source;
  SourceChangedState({this.source});

  @override
  List<Object> get props => [source];
}

class SortByChangedState extends NewsFilterState {
  final SortBy sortBy;
  SortByChangedState({this.sortBy});

  @override
  List<Object> get props => [sortBy];
}
