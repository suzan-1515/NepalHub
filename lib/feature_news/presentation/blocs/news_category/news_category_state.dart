part of 'news_category_bloc.dart';

abstract class NewsCategoryState extends Equatable {
  const NewsCategoryState();
}

class NewsCategoryInitialState extends NewsCategoryState {
  @override
  List<Object> get props => [];
}

class NewsCategoryLoadingState extends NewsCategoryState {
  @override
  List<Object> get props => [];
}

class NewsCategoryRefreshingState extends NewsCategoryState {
  @override
  List<Object> get props => [];
}

class NewsCategoryLoadSuccessState extends NewsCategoryState {
  final List<NewsCategoryEntity> categories;

  NewsCategoryLoadSuccessState(this.categories);

  @override
  List<Object> get props => [categories];
}

class NewsCategoryLoadEmptyState extends NewsCategoryState {
  final String message;

  NewsCategoryLoadEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsCategoryErrorState extends NewsCategoryState {
  final String message;

  NewsCategoryErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsCategoryLoadErrorState extends NewsCategoryState {
  final String message;

  NewsCategoryLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
