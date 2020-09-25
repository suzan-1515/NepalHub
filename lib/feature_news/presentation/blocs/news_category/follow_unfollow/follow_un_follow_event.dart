part of 'follow_un_follow_bloc.dart';

abstract class FollowUnFollowEvent extends Equatable {
  const FollowUnFollowEvent();
}

class Follow extends FollowUnFollowEvent {
  final NewsCategoryUIModel categoryModel;

  Follow({@required this.categoryModel});

  @override
  List<Object> get props => [categoryModel.category];
}

class UnFollow extends FollowUnFollowEvent {
  final NewsCategoryUIModel categoryModel;

  UnFollow({@required this.categoryModel});

  @override
  List<Object> get props => [categoryModel.category];
}
