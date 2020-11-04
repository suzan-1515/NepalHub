part of 'follow_un_follow_bloc.dart';

abstract class CategoryFollowUnfollowEvent extends Equatable {
  const CategoryFollowUnfollowEvent();
  @override
  List<Object> get props => [];
}

class CategoryFollowEvent extends CategoryFollowUnfollowEvent {
  final NewsCategoryEntity category;

  CategoryFollowEvent({@required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryUnFollowEvent extends CategoryFollowUnfollowEvent {
  final NewsCategoryEntity category;

  CategoryUnFollowEvent({@required this.category});

  @override
  List<Object> get props => [category];
}

class UpdateFollowEvent extends CategoryFollowUnfollowEvent {
  final NewsCategoryEntity category;

  UpdateFollowEvent({@required this.category});
  @override
  List<Object> get props => [category];
}

class UpdateUnfollowEvent extends CategoryFollowUnfollowEvent {
  final NewsCategoryEntity category;

  UpdateUnfollowEvent({@required this.category});
  @override
  List<Object> get props => [category];
}
