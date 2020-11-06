part of 'gold_silver_category_bloc.dart';

abstract class GoldCategoryState extends Equatable {
  const GoldCategoryState();

  @override
  List<Object> get props => [];
}

class GoldCategoryInitialState extends GoldCategoryState {}

class GoldCategoryLoadingState extends GoldCategoryState {}

class GoldCategoryLoadSuccessState extends GoldCategoryState {
  final List<GoldSilverCategoryEntity> categories;

  GoldCategoryLoadSuccessState({@required this.categories});
  @override
  List<Object> get props => [categories];
}

class GoldCategoryEmptyState extends GoldCategoryState {
  final String message;

  GoldCategoryEmptyState({this.message});
  @override
  List<Object> get props => [message];
}

class GoldCategoryLoadErrorState extends GoldCategoryState {
  final String message;

  GoldCategoryLoadErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class GoldCategoryErrorState extends GoldCategoryState {
  final String message;

  GoldCategoryErrorState({this.message});
  @override
  List<Object> get props => [message];
}
