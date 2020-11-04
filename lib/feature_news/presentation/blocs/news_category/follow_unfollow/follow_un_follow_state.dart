part of 'follow_un_follow_bloc.dart';

abstract class CategoryFollowUnFollowState extends Equatable {
  const CategoryFollowUnFollowState();
}

class CategoryFollowInitialState extends CategoryFollowUnFollowState {
  @override
  List<Object> get props => [];
}

class CategoryFollowInProgressState extends CategoryFollowUnFollowState {
  @override
  List<Object> get props => [];
}

class CategoryFollowSuccessState extends CategoryFollowUnFollowState {
  final NewsCategoryEntity category;

  CategoryFollowSuccessState({@required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryUnFollowSuccessState extends CategoryFollowUnFollowState {
  final NewsCategoryEntity category;

  CategoryUnFollowSuccessState({@required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryFollowErrorstate extends CategoryFollowUnFollowState {
  final String message;

  CategoryFollowErrorstate({this.message});

  @override
  List<Object> get props => [message];
}
