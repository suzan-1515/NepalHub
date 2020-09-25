part of 'news_category_bloc.dart';

abstract class NewsCategoryState extends Equatable {
  const NewsCategoryState();
}

class Initial extends NewsCategoryState {
  @override
  List<Object> get props => [];
}

class Loading extends NewsCategoryState {
  @override
  List<Object> get props => [];
}

class LoadSuccess extends NewsCategoryState {
  final List<NewsCategoryUIModel> categories;

  LoadSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

class Empty extends NewsCategoryState {
  final String message;

  Empty({this.message});

  @override
  List<Object> get props => [message];
}

class Error extends NewsCategoryState {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}
